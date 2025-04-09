# Omnimo-nRF52840-zigbee-temperature-humidity-sensor



This example demonstrating the use of zigbee capabilities of the  Omnimo nRF52840 dev board with the Temp&Hum 24 Click (HDC3021 Sensor) to broadcast 
measurements of temperature and humidity to Home Assistant using the Zigbee protocol. This code mainly 


This code is mainly inspired from Zigbee Multi Sensor with FreeRTOS Example found in  nRF5 SDK for Thread and Zigbee v4.2.0.

Currently, this project was only tested with Segger Embedded Studio as IDE.

## Materials

1. [omnimo nRF52840](https://www.crowdsupply.com/eafaq/omnimo-nrf52840)
2. [TEMP&HUM 24 CLICK](https://www.mikroe.com/temphum-24-click)


## Compiling and Flashing
1. Download nRF5 SDK for Thread and Zigbee v4.2.0\
https://www.nordicsemi.com/Products/Development-software/nRF5-SDK-for-Thread-and-Zigbee/Download


2. Clone this repo inside examples/zigbee/experimental

3. Use Embedded Studio for ARM (V7.32a) for compiling and flashing


## Home Assistant

Tests conducted on HomeAssistant using the ZHA integration have been successful.
