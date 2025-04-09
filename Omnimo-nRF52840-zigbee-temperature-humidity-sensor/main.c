/**
 * Copyright (c) 2019 - 2022, Nordic Semiconductor ASA
 *
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification,
 * are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice, this
 *    list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form, except as embedded into a Nordic
 *    Semiconductor ASA integrated circuit in a product or a software update for
 *    such product, must reproduce the above copyright notice, this list of
 *    conditions and the following disclaimer in the documentation and/or other
 *    materials provided with the distribution.
 *
 * 3. Neither the name of Nordic Semiconductor ASA nor the names of its
 *    contributors may be used to endorse or promote products derived from this
 *    software without specific prior written permission.
 *
 * 4. This software, with or without modification, must only be used with a
 *    Nordic Semiconductor ASA integrated circuit.
 *
 * 5. Any software provided in binary form under this license must not be reverse
 *    engineered, decompiled, modified and/or disassembled.
 *
 * THIS SOFTWARE IS PROVIDED BY NORDIC SEMICONDUCTOR ASA "AS IS" AND ANY EXPRESS
 * OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
 * OF MERCHANTABILITY, NONINFRINGEMENT, AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL NORDIC SEMICONDUCTOR ASA OR CONTRIBUTORS BE
 * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE
 * GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT
 * OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 */
/** @file
 *
 * @defgroup zigbee_examples_multi_sensor_freertos main.c
 * @{
 * @ingroup zigbee_examples
 * @brief Zigbee Pressure and Temperature sensor using FreeRTOS
 */

#include <stdbool.h>
#include <stddef.h>

#include "FreeRTOS.h"
#include "semphr.h"
#include "task.h"


#include "zboss_api.h"
#include "zb_mem_config_med.h"
#include "zb_error_handler.h"
#include "zigbee_helpers.h"
#include "app_timer.h"
#include "bsp.h"
#include "boards.h"
#include "sensorsim.h"

#include "nrf_assert.h"
#include "nrf_drv_clock.h"
#include "nrf_log.h"
#include "nrf_log_ctrl.h"
#include "nrf_log_default_backends.h"

#include "nrf_drv_twi.h"
#include "libraries/delay/nrf_delay.h"


#include "zb_multi_sensor.h"


#define IEEE_CHANNEL_MASK                  (1l << ZIGBEE_CHANNEL)               /**< Scan only one, predefined channel to find the coordinator. */
#define ERASE_PERSISTENT_CONFIG            ZB_FALSE                             /**< Do not erase NVRAM to save the network parameters after device reboot or power-off. */

#define ZIGBEE_NETWORK_STATE_LED            BSP_BOARD_LED_2                       /**< LED indicating that light switch successfully joind Zigbee network. */

#if !defined ZB_ED_ROLE
#error Define ZB_ED_ROLE to compile End Device source code.
#endif


#define ZIGBEE_MAIN_TASK_PRIORITY               (tskIDLE_PRIORITY + 2U)
static TaskHandle_t m_zigbee_main_task_handle;
static SemaphoreHandle_t m_zigbee_main_task_mutex;

#define TEMPERATURE_PRESSURE_MEASUREMENT_TASK_STACK_SIZE    (configMINIMAL_STACK_SIZE + 4*64U) //(configMINIMAL_STACK_SIZE + 64U)
#define TEMPERATURE_PRESSURE_MEASUREMENT_TASK_PRIORITY      (tskIDLE_PRIORITY + 2U)
static TaskHandle_t m_pressure_measurement_task_handle;

#define LED_TOGGLE_TASK_STACK_SIZE        (configMINIMAL_STACK_SIZE + 64U)
#define LED_TOGGLE_TASK_PRIORITY          (tskIDLE_PRIORITY + 2U)
static TaskHandle_t m_led_toggle_task_handle;


#if (NRF_LOG_ENABLED && NRF_LOG_DEFERRED)
#define LOG_TASK_STACK_SIZE               (1024U / sizeof(StackType_t))
#define LOG_TASK_PRIORITY                 (tskIDLE_PRIORITY + 1U)               /**< Must be lower than any task generating logs */
static TaskHandle_t m_logger_task_handle;
#endif


static sensor_device_ctx_t m_dev_ctx;

ZB_ZCL_DECLARE_IDENTIFY_CLIENT_ATTRIB_LIST(identify_client_attr_list);

ZB_ZCL_DECLARE_IDENTIFY_SERVER_ATTRIB_LIST(identify_server_attr_list, &m_dev_ctx.identify_attr.identify_time);

ZB_ZCL_DECLARE_BASIC_ATTRIB_LIST_EXT(basic_attr_list,
                                     &m_dev_ctx.basic_attr.zcl_version,
                                     &m_dev_ctx.basic_attr.app_version,
                                     &m_dev_ctx.basic_attr.stack_version,
                                     &m_dev_ctx.basic_attr.hw_version,
                                     m_dev_ctx.basic_attr.mf_name,
                                     m_dev_ctx.basic_attr.model_id,
                                     m_dev_ctx.basic_attr.date_code,
                                     &m_dev_ctx.basic_attr.power_source,
                                     m_dev_ctx.basic_attr.location_id,
                                     &m_dev_ctx.basic_attr.ph_env,
                                     m_dev_ctx.basic_attr.sw_ver);

ZB_ZCL_DECLARE_TEMP_MEASUREMENT_ATTRIB_LIST(temperature_attr_list, 
                                            &m_dev_ctx.temp_attr.measure_value,
                                            &m_dev_ctx.temp_attr.min_measure_value, 
                                            &m_dev_ctx.temp_attr.max_measure_value, 
                                            &m_dev_ctx.temp_attr.tolerance);

ZB_ZCL_DECLARE_PRES_MEASUREMENT_ATTRIB_LIST(pressure_attr_list, 
                                            &m_dev_ctx.pres_attr.measure_value, 
                                            &m_dev_ctx.pres_attr.min_measure_value, 
                                            &m_dev_ctx.pres_attr.max_measure_value, 
                                            &m_dev_ctx.pres_attr.tolerance);

ZB_DECLARE_MULTI_SENSOR_CLUSTER_LIST(multi_sensor_clusters,
                                     basic_attr_list,
                                     identify_client_attr_list,
                                     identify_server_attr_list,
                                     temperature_attr_list,
                                     pressure_attr_list);

ZB_ZCL_DECLARE_MULTI_SENSOR_EP(multi_sensor_ep,
                               MULTI_SENSOR_ENDPOINT,
                               multi_sensor_clusters);

ZBOSS_DECLARE_DEVICE_CTX_1_EP(multi_sensor_ctx, multi_sensor_ep);



APP_TIMER_DEF(temperature_measurement_timer);

typedef struct
{
    zb_int16_t  measured_value;
} update_temperature_measurement_ctx_t;

/**@brief  Context used to convey data from @ref temperature_measurement_timer_handler to update_temperature_measurement_cb
 */





/* TWI instance ID. */
#define TWI_INSTANCE_ID     0


/* HDC3021 I2C address. */
#define HDC3021_ADDR        (0x44U)

/* HDC3021 Command Definitions */
#define HDC3021_CMD_MEASURE_TEMP_HUMID_NO_HOLD   0x37  // Measure both temperature and humidity without holding the bus
#define HDC3021_CMD_READ_SERIAL_ID_FIRST         0xFB  // First part of the serial ID read command
#define HDC3021_CMD_READ_SERIAL_ID_SECOND        0xFC  // Second part of the serial ID read command


#define HDC3021_CMD_TRIGGER_MEASUREMENT   0x24  // Trigger measurement without clock stretching
#define HDC3021_CMD_HIGH_REPEATABILTY     0x00  // High repeatability mode

/* Buffer for samples read from HDC3021 sensor. */
static uint8_t m_sample[6]; // 6 bytes: 2 bytes for humidity, 2 bytes for temperature, and 2 bytes for CRC

/* Indicates if operation on TWI has ended. */
static volatile bool m_xfer_done = false;

/* TWI instance. */
static const nrf_drv_twi_t m_twi = NRF_DRV_TWI_INSTANCE(TWI_INSTANCE_ID);


bool hdc3021_init(void)
{
    ret_code_t err_code;

    /* Initialize TWI */
 //   twi_init();

    /* Test communication with the HDC3021 sensor */
    err_code = nrf_drv_twi_tx(&m_twi, HDC3021_ADDR, NULL, 0, false);
    if (err_code != NRF_SUCCESS)
    {
        NRF_LOG_ERROR("Failed to communicate with HDC3021!");
        return false;
    }

    NRF_LOG_INFO("HDC3021 initialized successfully.");
    return true;
}


/**
 * @brief Function for handling data from HDC3021 sensor.
 *
 * @param[in] temp          Temperature in Celsius degrees read from sensor.
 * @param[in] humidity      Humidity in percentage read from sensor.
 */
__STATIC_INLINE void data_handler(float temp, float humidity)
{
    NRF_LOG_INFO("Temperature: %.2f C, Humidity: %.2f %%", temp, humidity);
}

/**
 * @brief TWI events handler.
 */
void twi_handler(nrf_drv_twi_evt_t const * p_event, void * p_context)
{
    switch (p_event->type)
    {
        case NRF_DRV_TWI_EVT_DONE:
            if (p_event->xfer_desc.type == NRF_DRV_TWI_XFER_RX)
            {
                // Process received data
                uint16_t raw_humidity = (m_sample[0] << 8) | m_sample[1];
                uint16_t raw_temp = (m_sample[3] << 8) | m_sample[4];

                // Convert raw values to physical units
                float humidity = (raw_humidity / 65536.0f) * 100.0f;
                float temp = ((raw_temp / 65536.0f) * 165.0f) - 40.0f;

                // Call data handler
                data_handler(temp, humidity);
            }
            m_xfer_done = true;
            break;
        default:
            break;
    }
}



/**
 * @brief UART initialization.
 */
void twi_init (void)
{
    ret_code_t err_code;

    const nrf_drv_twi_config_t twi_lm75b_config = {
       .scl                = NRF_GPIO_PIN_MAP(0, 11), //ARDUINO_SCL_PIN,
       .sda                = NRF_GPIO_PIN_MAP(0, 12), //ARDUINO_SDA_PIN,
       .frequency          = NRF_DRV_TWI_FREQ_100K,
       .interrupt_priority = APP_IRQ_PRIORITY_HIGH,
       .clear_bus_init     = false
    };

    err_code = nrf_drv_twi_init(&m_twi, &twi_lm75b_config, NULL/*twi_handler*/, NULL);
    APP_ERROR_CHECK(err_code);

    nrf_drv_twi_enable(&m_twi);
}


/**
 * @brief Function for reading data from HDC3021 sensor.
 */
static void read_sensor_data()
{
    m_xfer_done = false;

    /* Read 6 bytes: 2 bytes for humidity, 2 bytes for temperature, and 2 bytes for CRC. */
    ret_code_t err_code = nrf_drv_twi_rx(&m_twi, HDC3021_ADDR, m_sample, sizeof(m_sample));
    APP_ERROR_CHECK(err_code);
}


/**
 * @brief Function to trigger a measurement on the HDC3021 sensor.
 */
void hdc3021_trigger_measurement(void)
{
    ret_code_t err_code;

    /* Send measurement command */
    uint8_t cmd[2] = {HDC3021_CMD_TRIGGER_MEASUREMENT, HDC3021_CMD_HIGH_REPEATABILTY};
    err_code = nrf_drv_twi_tx(&m_twi, HDC3021_ADDR, cmd, sizeof(cmd), false);
    APP_ERROR_CHECK(err_code);

    /* Wait for measurement to complete (typical conversion time is 20 ms). */
    nrf_delay_ms(20);
}

/**
 * @brief Function to read data from the HDC3021 sensor.
 */
void hdc3021_read_data(float *temperature, float *humidity)
{
    ret_code_t err_code;

    /* Read 6 bytes: 2 bytes for temperature, 2 bytes for humidity, and 2 bytes for CRC. */
    err_code = nrf_drv_twi_rx(&m_twi, HDC3021_ADDR, m_sample, sizeof(m_sample));
    APP_ERROR_CHECK(err_code);

    /* Extract raw values */
    uint16_t raw_temp = (m_sample[0] << 8) | m_sample[1];
    uint16_t raw_humidity = (m_sample[3] << 8) | m_sample[4];

    /* Convert raw values to physical units */
    *temperature = ((float)(raw_temp) / 65535.0f) * 175.0f - 45.0f;
    *humidity = ((float)(raw_humidity) / 65535.0f) * 100.0f;
}





/**@brief Function for initializing the nrf log module.
 */
static void log_init(void)
{
    ret_code_t err_code = NRF_LOG_INIT(NULL);
    APP_ERROR_CHECK(err_code);

    NRF_LOG_DEFAULT_BACKENDS_INIT();
}


/**@brief Function for initializing all clusters attributes.
 */
static void multi_sensor_clusters_attr_init(void)
{
    /* Basic cluster attributes data */
    m_dev_ctx.basic_attr.zcl_version   = ZB_ZCL_VERSION;
    m_dev_ctx.basic_attr.app_version   = SENSOR_INIT_BASIC_APP_VERSION;
    m_dev_ctx.basic_attr.stack_version = SENSOR_INIT_BASIC_STACK_VERSION;
    m_dev_ctx.basic_attr.hw_version    = SENSOR_INIT_BASIC_HW_VERSION;

    /* Use ZB_ZCL_SET_STRING_VAL to set strings, because the first byte should
     * contain string length without trailing zero.
     *
     * For example "test" string wil be encoded as:
     *   [(0x4), 't', 'e', 's', 't']
     */
    ZB_ZCL_SET_STRING_VAL(m_dev_ctx.basic_attr.mf_name,
                          SENSOR_INIT_BASIC_MANUF_NAME,
                          ZB_ZCL_STRING_CONST_SIZE(SENSOR_INIT_BASIC_MANUF_NAME));

    ZB_ZCL_SET_STRING_VAL(m_dev_ctx.basic_attr.model_id,
                          SENSOR_INIT_BASIC_MODEL_ID,
                          ZB_ZCL_STRING_CONST_SIZE(SENSOR_INIT_BASIC_MODEL_ID));

    ZB_ZCL_SET_STRING_VAL(m_dev_ctx.basic_attr.date_code,
                          SENSOR_INIT_BASIC_DATE_CODE,
                          ZB_ZCL_STRING_CONST_SIZE(SENSOR_INIT_BASIC_DATE_CODE));

    m_dev_ctx.basic_attr.power_source = SENSOR_INIT_BASIC_POWER_SOURCE;

    ZB_ZCL_SET_STRING_VAL(m_dev_ctx.basic_attr.location_id,
                          SENSOR_INIT_BASIC_LOCATION_DESC,
                          ZB_ZCL_STRING_CONST_SIZE(SENSOR_INIT_BASIC_LOCATION_DESC));


    m_dev_ctx.basic_attr.ph_env = SENSOR_INIT_BASIC_PH_ENV;

    /* Identify cluster attributes data */
    m_dev_ctx.identify_attr.identify_time        = ZB_ZCL_IDENTIFY_IDENTIFY_TIME_DEFAULT_VALUE;

    /* Temperature measurement cluster attributes data */
    m_dev_ctx.temp_attr.measure_value            = ZB_ZCL_ATTR_TEMP_MEASUREMENT_VALUE_UNKNOWN;
    m_dev_ctx.temp_attr.min_measure_value        = ZB_ZCL_ATTR_TEMP_MEASUREMENT_MIN_VALUE_MIN_VALUE;
    m_dev_ctx.temp_attr.max_measure_value        = ZB_ZCL_ATTR_TEMP_MEASUREMENT_MAX_VALUE_MAX_VALUE;
    m_dev_ctx.temp_attr.tolerance                = ZB_ZCL_ATTR_TEMP_MEASUREMENT_TOLERANCE_MAX_VALUE;

    /* Pressure measurement cluster attributes data */
    m_dev_ctx.pres_attr.measure_value            = ZB_ZCL_ATTR_PRES_MEASUREMENT_VALUE_UNKNOWN;
    m_dev_ctx.pres_attr.min_measure_value        = ZB_ZCL_ATTR_PRES_MEASUREMENT_MIN_VALUE_MIN_VALUE;
    m_dev_ctx.pres_attr.max_measure_value        = ZB_ZCL_ATTR_PRES_MEASUREMENT_MAX_VALUE_MAX_VALUE;
    m_dev_ctx.pres_attr.tolerance                = ZB_ZCL_ATTR_PRES_MEASUREMENT_TOLERANCE_MAX_VALUE;
}





/**@brief  Task performing pressure measurement.
 *
 * @note What this task does could be done from @ref temperature_measurement_timer_handler.
 * This is just to show different methods of updating attributes outgoing from zigbee stack.
 *
 * @param pvParam  Not used, required by freertos api
 */
static void temperature_pressure_measurement_task(void *pvParam)
{
    /* Just to show that we are NOT in zigbee_main_task context */
    ASSERT(xTaskGetCurrentTaskHandle() != m_zigbee_main_task_handle);

    NRF_LOG_INFO("The pressure_measurement_task started.");

    TickType_t  last_update_wake_timestamp;
    last_update_wake_timestamp = xTaskGetTickCount();

    while (true)
    {
        zb_zcl_status_t zcl_status;
        zb_int16_t      new_pres_value;
        zb_int16_t new_temp_value;


        /* Get new pressure measured value */
      //  new_pres_value = (zb_int16_t)sensorsim_measure(&m_pressure_sim_state, &m_pressure_sim_cfg);

        
       hdc3021_trigger_measurement();

        // Read temperature and humidity
        float temperature, humidity;
        hdc3021_read_data(&temperature, &humidity);

        // Log the results
        NRF_LOG_INFO("Temperature: %d C, Humidity: %d %%", temperature, humidity);
      //  NRF_LOG_FLUSH();

        new_pres_value =(zb_int16_t)humidity;
        new_temp_value =(zb_int16_t)temperature*100;   //   *100  otherwise we get values in centidegrees !!!!


        if (xSemaphoreTakeRecursive(m_zigbee_main_task_mutex, 1000U) == pdTRUE)
        {
            /* Set new pressure value as zcl attribute
             * NOTE this is not thread-safe and locking is required
             */
            zcl_status = zb_zcl_set_attr_val(MULTI_SENSOR_ENDPOINT,
                                             ZB_ZCL_CLUSTER_ID_PRES_MEASUREMENT,
                                             ZB_ZCL_CLUSTER_SERVER_ROLE,
                                             ZB_ZCL_ATTR_PRES_MEASUREMENT_VALUE_ID,
                                             (zb_uint8_t *)&new_pres_value,
                                             ZB_FALSE);
           // UNUSED_RETURN_VALUE(xSemaphoreGiveRecursive(m_zigbee_main_task_mutex));

            if (zcl_status != ZB_ZCL_STATUS_SUCCESS)
            {
                NRF_LOG_INFO("Set pressure value fail. zcl_status: %d", zcl_status);
            }
            zcl_status = zb_zcl_set_attr_val(MULTI_SENSOR_ENDPOINT,
                                             ZB_ZCL_CLUSTER_ID_TEMP_MEASUREMENT,
                                             ZB_ZCL_CLUSTER_SERVER_ROLE,
                                             ZB_ZCL_ATTR_TEMP_MEASUREMENT_VALUE_ID,
                                             (zb_uint8_t *)&new_temp_value,
                                             ZB_FALSE);
            UNUSED_RETURN_VALUE(xSemaphoreGiveRecursive(m_zigbee_main_task_mutex));

            if (zcl_status != ZB_ZCL_STATUS_SUCCESS)
            {
                NRF_LOG_INFO("Set pressure value fail. zcl_status: %d", zcl_status);
            }



        }
        else
        {
            NRF_LOG_ERROR("Unable to take zigbee_task_mutex from pressure_measurement_task");
        }

        /* Let the task sleep for some time, consider it as pressure sample period  */
        vTaskDelayUntil(&last_update_wake_timestamp, pdMS_TO_TICKS(1000U));
    }
}


/**@brief Zigbee stack event handler.
 *
 * @param[in] bufid     Reference to the Zigbee stack buffer used to pass signal.
 */
void zboss_signal_handler(zb_bufid_t bufid)
{
    /* Just to show that we are in zigbee_main_task context */
    ASSERT(xTaskGetCurrentTaskHandle() == m_zigbee_main_task_handle);

    zb_zdo_app_signal_hdr_t  * p_sg_p      = NULL;
    zb_zdo_app_signal_type_t   sig         = zb_get_app_signal(bufid, &p_sg_p);
    zb_ret_t                   status      = ZB_GET_APP_SIGNAL_STATUS(bufid);

    /* Update network status LED */
    zigbee_led_status_update(bufid, ZIGBEE_NETWORK_STATE_LED);

    switch (sig)
    {
        case ZB_BDB_SIGNAL_DEVICE_REBOOT:
            /* fall-through */
        case ZB_BDB_SIGNAL_STEERING:
            /* Call default signal handler. */
            ZB_ERROR_CHECK(zigbee_default_signal_handler(bufid));
            if (status == RET_OK)
            {
                ret_code_t err_code = app_timer_start(temperature_measurement_timer, APP_TIMER_TICKS(1000), NULL);
                APP_ERROR_CHECK(err_code);
            }
            break;

        case ZB_COMMON_SIGNAL_CAN_SLEEP:
            /* When freertos is used zb_sleep_now must not be used, due to
             * zigbee communication being not the only task to be performed by node.
             */
            break;

        default:
            /* Call default signal handler. */
            ZB_ERROR_CHECK(zigbee_default_signal_handler(bufid));
            break;
    }

    if (bufid)
    {
        zb_buf_free(bufid);
    }
}


void zigbee_main_task(void *pvParameter)
{
    zb_ret_t       zb_err_code;

    UNUSED_PARAMETER(pvParameter);

    NRF_LOG_INFO("The zigbee_main_task started.");

    /* Start Zigbee Stack. */
    zb_err_code = zboss_start_no_autostart();
    ZB_ERROR_CHECK(zb_err_code);

    while (true)
    {
        if (xSemaphoreTakeRecursive(m_zigbee_main_task_mutex, 5) == pdTRUE)
        {
            zboss_main_loop_iteration();
            UNUSED_RETURN_VALUE(xSemaphoreGiveRecursive(m_zigbee_main_task_mutex));
        }
        vTaskDelay(1);
    }
}



/**@brief Function to handle identify notification events.
 *
 * @param[IN]   param   Parameter handler is called with.
 */
static void identify_handler(zb_uint8_t param)
{
    if (param)
    {
        NRF_LOG_INFO("Start identifying.");
    }
    else
    {
        NRF_LOG_INFO("Stop identifying.");
    }
}


#if (NRF_LOG_ENABLED && NRF_LOG_DEFERRED)
/**@brief Task function responsible for deferred log processing.
 *
 * @note It must be running on lower priority than any task generating logs.
 *
 * @param pvParameter     FreeRTOS task parameter, unused here, required by FreeRTOS API.
 */
static void logger_task(void *pvParameter)
{
    UNUSED_PARAMETER(pvParameter);

    while (true)
    {
        if (!(NRF_LOG_PROCESS()))
        {
            /* No more logs, let's sleep and wait for any */
            vTaskDelay(1);
        }
    }
}
#endif

/**@brief FreeRTOS hook function called from idle task */
void vApplicationIdleHook(void)
{
    /* No task is running, just idle on lowest priority, so we can lower power usage */
    __WFE();
}

/**@brief  FreeRTOS hook function called when stack overflow has been detected
 * @note   See FreeRTOS API
 */
void vApplicationStackOverflowHook(TaskHandle_t xTask, char *pcTaskName)
{
    NRF_LOG_ERROR("vApplicationStackOverflowHook(%x,\"%s\")", xTask, pcTaskName);
    APP_ERROR_HANDLER(NRF_ERROR_NO_MEM);
}

/**@brief Function which tries to sleep down the MCU
 *
 * @details This function is called from @ref zboss_main_loop_iteration, when there is no more
 * messages to process. Because @ref zigbee_main_task is not the only one, implementation found
 * in zb_nrf52840_common.c is not appropriate.
 *
 * @note    This function overrides implementation found in zb_nrf52840_common.c
 */
void zb_osif_go_idle(void)
{
    /* Intentionally empty implementation */
}

/**@brief Function for application main entry.
 */
int main(void)
{
    ret_code_t     err_code;
    zb_ieee_addr_t ieee_addr;

    /* Initialize logging system and GPIOs. */
    log_init();
    NRF_LOG_INFO("Application start");
    NRF_LOG_FLUSH();

    twi_init();

    

    /* Set Zigbee stack logging level and traffic dump subsystem. */
    ZB_SET_TRACE_LEVEL(ZIGBEE_TRACE_LEVEL);
    ZB_SET_TRACE_MASK(ZIGBEE_TRACE_MASK);
    ZB_SET_TRAF_DUMP_OFF();

    /* Initialize Zigbee stack. */
    ZB_INIT("multi_sensor");

    /* Set device address to the value read from FICR registers. */
    zb_osif_get_ieee_eui64(ieee_addr);
    zb_set_long_address(ieee_addr);

    /* Set static long IEEE address. */
    zb_set_network_ed_role(IEEE_CHANNEL_MASK);
    zigbee_erase_persistent_storage(ERASE_PERSISTENT_CONFIG);

    zb_set_ed_timeout(ED_AGING_TIMEOUT_64MIN);
    zb_set_keepalive_timeout(ZB_MILLISECONDS_TO_BEACON_INTERVAL(3000));
    zb_set_rx_on_when_idle(ZB_FALSE);

    /* Initialize application context structure. */
    UNUSED_RETURN_VALUE(ZB_MEMSET(&m_dev_ctx, 0, sizeof(m_dev_ctx)));

    /* Register temperature sensor device context (endpoints). */
    ZB_AF_REGISTER_DEVICE_CTX(&multi_sensor_ctx);

    /* Register handlers to identify notifications */
    ZB_AF_SET_IDENTIFY_NOTIFICATION_HANDLER(MULTI_SENSOR_ENDPOINT, identify_handler);

    /* Initialize sensor device attibutes */
    multi_sensor_clusters_attr_init();

    BaseType_t rtos_result;
#if (NRF_LOG_ENABLED && NRF_LOG_DEFERRED)
    rtos_result = xTaskCreate(logger_task, "LOG", LOG_TASK_STACK_SIZE,
            NULL, LOG_TASK_PRIORITY, &m_logger_task_handle);
    if (rtos_result != pdTRUE)
    {
        APP_ERROR_HANDLER(NRF_ERROR_NO_MEM);
    }
#endif

    
    rtos_result = xTaskCreate(temperature_pressure_measurement_task, "PM", TEMPERATURE_PRESSURE_MEASUREMENT_TASK_STACK_SIZE,
            NULL, TEMPERATURE_PRESSURE_MEASUREMENT_TASK_PRIORITY, &m_pressure_measurement_task_handle);
    if (rtos_result != pdPASS)
    {
        APP_ERROR_HANDLER(NRF_ERROR_NO_MEM);
    }

    
    m_zigbee_main_task_mutex = xSemaphoreCreateRecursiveMutex();
    if (m_zigbee_main_task_mutex == NULL)
    {
        APP_ERROR_HANDLER(NRF_ERROR_NO_MEM);
    }

    /* Create task where zboss_main_loop_iteration will be called from */
    rtos_result = xTaskCreate(zigbee_main_task, "ZB", ZIGBEE_MAIN_TASK_STACK_SIZE,
            NULL, ZIGBEE_MAIN_TASK_PRIORITY, &m_zigbee_main_task_handle);
    if (rtos_result != pdPASS)
    {
        APP_ERROR_HANDLER(NRF_ERROR_NO_MEM);
    }

    /* Start FreeRTOS scheduler. */
    NRF_LOG_INFO("Starting FreeRTOS scheduler");
    NRF_LOG_FLUSH();
    vTaskStartScheduler();

    while (true)
    {
        /* FreeRTOS should not be here... FreeRTOS goes back to the start of stack
         * in vTaskStartScheduler function. */
    }
}


/**
 * @}
 */
