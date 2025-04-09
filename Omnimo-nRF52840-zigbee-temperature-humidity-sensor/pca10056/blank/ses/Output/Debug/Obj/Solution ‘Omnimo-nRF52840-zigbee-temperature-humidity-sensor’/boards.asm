	.cpu cortex-m4
	.arch armv7e-m
	.fpu fpv4-sp-d16
	.eabi_attribute 27, 1
	.eabi_attribute 28, 1
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 1
	.eabi_attribute 30, 6
	.eabi_attribute 34, 1
	.eabi_attribute 38, 1
	.eabi_attribute 18, 4
	.file	"boards.c"
	.text
.Ltext0:
	.file 1 "D:\\OMNIO\\nrf5_sdk_for_thread_and_zigbee_v4.2.0_af27f76\\components\\boards\\boards.c"
	.section .rodata
	.align	2
.LC0:
	.ascii	"../../../../../../../modules/nrfx/hal/nrf_gpio.h\000"
	.section	.text.nrf_gpio_pin_port_decode,"ax",%progbits
	.align	1
	.syntax unified
	.thumb
	.thumb_func
	.type	nrf_gpio_pin_port_decode, %function
nrf_gpio_pin_port_decode:
.LFB167:
	.file 2 "../../../../../../../modules/nrfx/hal/nrf_gpio.h"
	.loc 2 460 1
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI0:
	sub	sp, sp, #12
.LCFI1:
	str	r0, [sp, #4]
	.loc 2 461 5
	ldr	r3, [sp, #4]
	ldr	r3, [r3]
	cmp	r3, #47
	bls	.L2
	.loc 2 461 5 is_stmt 0 discriminator 2
	ldr	r1, .L5
	movw	r0, #461
	bl	assert_nrf_callback
.L2:
	.loc 2 465 9 is_stmt 1
	ldr	r3, [sp, #4]
	ldr	r3, [r3]
	.loc 2 465 8
	cmp	r3, #31
	bhi	.L3
	.loc 2 467 16
	mov	r3, #1342177280
	b	.L4
.L3:
	.loc 2 471 18
	ldr	r3, [sp, #4]
	ldr	r3, [r3]
	.loc 2 471 25
	and	r2, r3, #31
	.loc 2 471 16
	ldr	r3, [sp, #4]
	str	r2, [r3]
	.loc 2 472 16
	ldr	r3, .L5+4
.L4:
	.loc 2 475 1
	mov	r0, r3
	add	sp, sp, #12
.LCFI2:
	@ sp needed
	ldr	pc, [sp], #4
.L6:
	.align	2
.L5:
	.word	.LC0
	.word	1342178048
.LFE167:
	.size	nrf_gpio_pin_port_decode, .-nrf_gpio_pin_port_decode
	.section	.text.nrf_gpio_cfg,"ax",%progbits
	.align	1
	.syntax unified
	.thumb
	.thumb_func
	.type	nrf_gpio_cfg, %function
nrf_gpio_cfg:
.LFB170:
	.loc 2 507 1
	@ args = 8, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI3:
	sub	sp, sp, #20
.LCFI4:
	str	r0, [sp, #4]
	mov	r0, r1
	mov	r1, r2
	mov	r2, r3
	mov	r3, r0
	strb	r3, [sp, #3]
	mov	r3, r1
	strb	r3, [sp, #2]
	mov	r3, r2
	strb	r3, [sp, #1]
	.loc 2 508 27
	add	r3, sp, #4
	mov	r0, r3
	bl	nrf_gpio_pin_port_decode
	str	r0, [sp, #12]
	.loc 2 510 47
	ldrb	r2, [sp, #3]	@ zero_extendqisi2
	.loc 2 511 35
	ldrb	r3, [sp, #2]	@ zero_extendqisi2
	.loc 2 511 51
	lsls	r3, r3, #1
	.loc 2 511 32
	orrs	r2, r2, r3
	.loc 2 512 35
	ldrb	r3, [sp, #1]	@ zero_extendqisi2
	.loc 2 512 50
	lsls	r3, r3, #2
	.loc 2 512 32
	orrs	r2, r2, r3
	.loc 2 513 35
	ldrb	r3, [sp, #24]	@ zero_extendqisi2
	.loc 2 513 51
	lsls	r3, r3, #8
	.loc 2 513 32
	orr	r1, r2, r3
	.loc 2 514 35
	ldrb	r3, [sp, #28]	@ zero_extendqisi2
	.loc 2 514 51
	lsls	r3, r3, #16
	.loc 2 510 17
	ldr	r2, [sp, #4]
	.loc 2 514 32
	orrs	r1, r1, r3
	.loc 2 510 30
	ldr	r3, [sp, #12]
	add	r2, r2, #448
	str	r1, [r3, r2, lsl #2]
	.loc 2 515 1
	nop
	add	sp, sp, #20
.LCFI5:
	@ sp needed
	ldr	pc, [sp], #4
.LFE170:
	.size	nrf_gpio_cfg, .-nrf_gpio_cfg
	.section	.text.nrf_gpio_cfg_output,"ax",%progbits
	.align	1
	.syntax unified
	.thumb
	.thumb_func
	.type	nrf_gpio_cfg_output, %function
nrf_gpio_cfg_output:
.LFB171:
	.loc 2 519 1
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI6:
	sub	sp, sp, #20
.LCFI7:
	str	r0, [sp, #12]
	.loc 2 520 5
	movs	r3, #0
	str	r3, [sp, #4]
	movs	r3, #0
	str	r3, [sp]
	movs	r3, #0
	movs	r2, #1
	movs	r1, #1
	ldr	r0, [sp, #12]
	bl	nrf_gpio_cfg
	.loc 2 527 1
	nop
	add	sp, sp, #20
.LCFI8:
	@ sp needed
	ldr	pc, [sp], #4
.LFE171:
	.size	nrf_gpio_cfg_output, .-nrf_gpio_cfg_output
	.section	.text.nrf_gpio_cfg_input,"ax",%progbits
	.align	1
	.syntax unified
	.thumb
	.thumb_func
	.type	nrf_gpio_cfg_input, %function
nrf_gpio_cfg_input:
.LFB172:
	.loc 2 531 1
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI9:
	sub	sp, sp, #20
.LCFI10:
	str	r0, [sp, #12]
	mov	r3, r1
	strb	r3, [sp, #11]
	.loc 2 532 5
	ldrb	r3, [sp, #11]	@ zero_extendqisi2
	movs	r2, #0
	str	r2, [sp, #4]
	movs	r2, #0
	str	r2, [sp]
	movs	r2, #0
	movs	r1, #0
	ldr	r0, [sp, #12]
	bl	nrf_gpio_cfg
	.loc 2 539 1
	nop
	add	sp, sp, #20
.LCFI11:
	@ sp needed
	ldr	pc, [sp], #4
.LFE172:
	.size	nrf_gpio_cfg_input, .-nrf_gpio_cfg_input
	.section	.text.nrf_gpio_pin_set,"ax",%progbits
	.align	1
	.syntax unified
	.thumb
	.thumb_func
	.type	nrf_gpio_pin_set, %function
nrf_gpio_pin_set:
.LFB179:
	.loc 2 619 1
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI12:
	sub	sp, sp, #20
.LCFI13:
	str	r0, [sp, #4]
	.loc 2 620 27
	add	r3, sp, #4
	mov	r0, r3
	bl	nrf_gpio_pin_port_decode
	str	r0, [sp, #12]
	.loc 2 622 5
	ldr	r3, [sp, #4]
	movs	r2, #1
	lsl	r3, r2, r3
	mov	r1, r3
	ldr	r0, [sp, #12]
	bl	nrf_gpio_port_out_set
	.loc 2 623 1
	nop
	add	sp, sp, #20
.LCFI14:
	@ sp needed
	ldr	pc, [sp], #4
.LFE179:
	.size	nrf_gpio_pin_set, .-nrf_gpio_pin_set
	.section	.text.nrf_gpio_pin_clear,"ax",%progbits
	.align	1
	.syntax unified
	.thumb
	.thumb_func
	.type	nrf_gpio_pin_clear, %function
nrf_gpio_pin_clear:
.LFB180:
	.loc 2 627 1
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI15:
	sub	sp, sp, #20
.LCFI16:
	str	r0, [sp, #4]
	.loc 2 628 27
	add	r3, sp, #4
	mov	r0, r3
	bl	nrf_gpio_pin_port_decode
	str	r0, [sp, #12]
	.loc 2 630 5
	ldr	r3, [sp, #4]
	movs	r2, #1
	lsl	r3, r2, r3
	mov	r1, r3
	ldr	r0, [sp, #12]
	bl	nrf_gpio_port_out_clear
	.loc 2 631 1
	nop
	add	sp, sp, #20
.LCFI17:
	@ sp needed
	ldr	pc, [sp], #4
.LFE180:
	.size	nrf_gpio_pin_clear, .-nrf_gpio_pin_clear
	.section	.text.nrf_gpio_pin_toggle,"ax",%progbits
	.align	1
	.syntax unified
	.thumb
	.thumb_func
	.type	nrf_gpio_pin_toggle, %function
nrf_gpio_pin_toggle:
.LFB181:
	.loc 2 635 1
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI18:
	sub	sp, sp, #20
.LCFI19:
	str	r0, [sp, #4]
	.loc 2 636 34
	add	r3, sp, #4
	mov	r0, r3
	bl	nrf_gpio_pin_port_decode
	str	r0, [sp, #12]
	.loc 2 637 21
	ldr	r3, [sp, #12]
	ldr	r3, [r3, #1284]
	str	r3, [sp, #8]
	.loc 2 639 20
	ldr	r3, [sp, #8]
	mvns	r2, r3
	.loc 2 639 39
	ldr	r3, [sp, #4]
	movs	r1, #1
	lsl	r3, r1, r3
	.loc 2 639 32
	ands	r2, r2, r3
	.loc 2 639 17
	ldr	r3, [sp, #12]
	str	r2, [r3, #1288]
	.loc 2 640 38
	ldr	r3, [sp, #4]
	movs	r2, #1
	lsls	r2, r2, r3
	.loc 2 640 31
	ldr	r3, [sp, #8]
	ands	r2, r2, r3
	.loc 2 640 17
	ldr	r3, [sp, #12]
	str	r2, [r3, #1292]
	.loc 2 641 1
	nop
	add	sp, sp, #20
.LCFI20:
	@ sp needed
	ldr	pc, [sp], #4
.LFE181:
	.size	nrf_gpio_pin_toggle, .-nrf_gpio_pin_toggle
	.section	.text.nrf_gpio_pin_write,"ax",%progbits
	.align	1
	.syntax unified
	.thumb
	.thumb_func
	.type	nrf_gpio_pin_write, %function
nrf_gpio_pin_write:
.LFB182:
	.loc 2 645 1
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI21:
	sub	sp, sp, #12
.LCFI22:
	str	r0, [sp, #4]
	str	r1, [sp]
	.loc 2 646 8
	ldr	r3, [sp]
	cmp	r3, #0
	bne	.L14
	.loc 2 648 9
	ldr	r0, [sp, #4]
	bl	nrf_gpio_pin_clear
	.loc 2 654 1
	b	.L16
.L14:
	.loc 2 652 9
	ldr	r0, [sp, #4]
	bl	nrf_gpio_pin_set
.L16:
	.loc 2 654 1
	nop
	add	sp, sp, #12
.LCFI23:
	@ sp needed
	ldr	pc, [sp], #4
.LFE182:
	.size	nrf_gpio_pin_write, .-nrf_gpio_pin_write
	.section	.text.nrf_gpio_pin_read,"ax",%progbits
	.align	1
	.syntax unified
	.thumb
	.thumb_func
	.type	nrf_gpio_pin_read, %function
nrf_gpio_pin_read:
.LFB183:
	.loc 2 658 1
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI24:
	sub	sp, sp, #20
.LCFI25:
	str	r0, [sp, #4]
	.loc 2 659 27
	add	r3, sp, #4
	mov	r0, r3
	bl	nrf_gpio_pin_port_decode
	str	r0, [sp, #12]
	.loc 2 661 14
	ldr	r0, [sp, #12]
	bl	nrf_gpio_port_in_read
	mov	r2, r0
	.loc 2 661 41
	ldr	r3, [sp, #4]
	lsr	r3, r2, r3
	.loc 2 661 56
	and	r3, r3, #1
	.loc 2 662 1
	mov	r0, r3
	add	sp, sp, #20
.LCFI26:
	@ sp needed
	ldr	pc, [sp], #4
.LFE183:
	.size	nrf_gpio_pin_read, .-nrf_gpio_pin_read
	.section	.text.nrf_gpio_pin_out_read,"ax",%progbits
	.align	1
	.syntax unified
	.thumb
	.thumb_func
	.type	nrf_gpio_pin_out_read, %function
nrf_gpio_pin_out_read:
.LFB184:
	.loc 2 666 1
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI27:
	sub	sp, sp, #20
.LCFI28:
	str	r0, [sp, #4]
	.loc 2 667 27
	add	r3, sp, #4
	mov	r0, r3
	bl	nrf_gpio_pin_port_decode
	str	r0, [sp, #12]
	.loc 2 669 14
	ldr	r0, [sp, #12]
	bl	nrf_gpio_port_out_read
	mov	r2, r0
	.loc 2 669 42
	ldr	r3, [sp, #4]
	lsr	r3, r2, r3
	.loc 2 669 57
	and	r3, r3, #1
	.loc 2 670 1
	mov	r0, r3
	add	sp, sp, #20
.LCFI29:
	@ sp needed
	ldr	pc, [sp], #4
.LFE184:
	.size	nrf_gpio_pin_out_read, .-nrf_gpio_pin_out_read
	.section	.text.nrf_gpio_port_in_read,"ax",%progbits
	.align	1
	.syntax unified
	.thumb
	.thumb_func
	.type	nrf_gpio_port_in_read, %function
nrf_gpio_port_in_read:
.LFB193:
	.loc 2 732 1
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	sub	sp, sp, #8
.LCFI30:
	str	r0, [sp, #4]
	.loc 2 733 17
	ldr	r3, [sp, #4]
	ldr	r3, [r3, #1296]
	.loc 2 734 1
	mov	r0, r3
	add	sp, sp, #8
.LCFI31:
	@ sp needed
	bx	lr
.LFE193:
	.size	nrf_gpio_port_in_read, .-nrf_gpio_port_in_read
	.section	.text.nrf_gpio_port_out_read,"ax",%progbits
	.align	1
	.syntax unified
	.thumb
	.thumb_func
	.type	nrf_gpio_port_out_read, %function
nrf_gpio_port_out_read:
.LFB194:
	.loc 2 738 1
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	sub	sp, sp, #8
.LCFI32:
	str	r0, [sp, #4]
	.loc 2 739 17
	ldr	r3, [sp, #4]
	ldr	r3, [r3, #1284]
	.loc 2 740 1
	mov	r0, r3
	add	sp, sp, #8
.LCFI33:
	@ sp needed
	bx	lr
.LFE194:
	.size	nrf_gpio_port_out_read, .-nrf_gpio_port_out_read
	.section	.text.nrf_gpio_port_out_set,"ax",%progbits
	.align	1
	.syntax unified
	.thumb
	.thumb_func
	.type	nrf_gpio_port_out_set, %function
nrf_gpio_port_out_set:
.LFB196:
	.loc 2 750 1
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	sub	sp, sp, #8
.LCFI34:
	str	r0, [sp, #4]
	str	r1, [sp]
	.loc 2 751 19
	ldr	r3, [sp, #4]
	ldr	r2, [sp]
	str	r2, [r3, #1288]
	.loc 2 752 1
	nop
	add	sp, sp, #8
.LCFI35:
	@ sp needed
	bx	lr
.LFE196:
	.size	nrf_gpio_port_out_set, .-nrf_gpio_port_out_set
	.section	.text.nrf_gpio_port_out_clear,"ax",%progbits
	.align	1
	.syntax unified
	.thumb
	.thumb_func
	.type	nrf_gpio_port_out_clear, %function
nrf_gpio_port_out_clear:
.LFB197:
	.loc 2 756 1
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	sub	sp, sp, #8
.LCFI36:
	str	r0, [sp, #4]
	str	r1, [sp]
	.loc 2 757 19
	ldr	r3, [sp, #4]
	ldr	r2, [sp]
	str	r2, [r3, #1292]
	.loc 2 758 1
	nop
	add	sp, sp, #8
.LCFI37:
	@ sp needed
	bx	lr
.LFE197:
	.size	nrf_gpio_port_out_clear, .-nrf_gpio_port_out_clear
	.section	.rodata.m_board_led_list,"a"
	.align	2
	.type	m_board_led_list, %object
	.size	m_board_led_list, 4
m_board_led_list:
	.ascii	"\015\016\017\020"
	.section	.rodata.m_board_btn_list,"a"
	.align	2
	.type	m_board_btn_list, %object
	.size	m_board_btn_list, 4
m_board_btn_list:
	.ascii	"\013\014\030\031"
	.section .rodata
	.align	2
.LC1:
	.ascii	"D:\\OMNIO\\nrf5_sdk_for_thread_and_zigbee_v4.2.0_af"
	.ascii	"27f76\\components\\boards\\boards.c\000"
	.section	.text.bsp_board_led_state_get,"ax",%progbits
	.align	1
	.global	bsp_board_led_state_get
	.syntax unified
	.thumb
	.thumb_func
	.type	bsp_board_led_state_get, %function
bsp_board_led_state_get:
.LFB202:
	.loc 1 57 1
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI38:
	sub	sp, sp, #20
.LCFI39:
	str	r0, [sp, #4]
	.loc 1 58 5
	ldr	r3, [sp, #4]
	cmp	r3, #3
	bls	.L28
	.loc 1 58 5 is_stmt 0 discriminator 2
	ldr	r1, .L30
	movs	r0, #58
	bl	assert_nrf_callback
.L28:
	.loc 1 59 58 is_stmt 1
	ldr	r2, .L30+4
	ldr	r3, [sp, #4]
	add	r3, r3, r2
	ldrb	r3, [r3]	@ zero_extendqisi2
	.loc 1 59 20
	mov	r0, r3
	bl	nrf_gpio_pin_out_read
	mov	r3, r0
	.loc 1 59 10
	cmp	r3, #0
	ite	ne
	movne	r3, #1
	moveq	r3, #0
	strb	r3, [sp, #15]
	.loc 1 60 5
	ldrb	r3, [sp, #15]	@ zero_extendqisi2
	cmp	r3, #0
	ite	ne
	movne	r3, #1
	moveq	r3, #0
	uxtb	r3, r3
	eor	r3, r3, #1
	uxtb	r3, r3
	.loc 1 60 21
	and	r3, r3, #1
	uxtb	r3, r3
	.loc 1 61 1
	mov	r0, r3
	add	sp, sp, #20
.LCFI40:
	@ sp needed
	ldr	pc, [sp], #4
.L31:
	.align	2
.L30:
	.word	.LC1
	.word	m_board_led_list
.LFE202:
	.size	bsp_board_led_state_get, .-bsp_board_led_state_get
	.section	.text.bsp_board_led_on,"ax",%progbits
	.align	1
	.global	bsp_board_led_on
	.syntax unified
	.thumb
	.thumb_func
	.type	bsp_board_led_on, %function
bsp_board_led_on:
.LFB203:
	.loc 1 64 1
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI41:
	sub	sp, sp, #12
.LCFI42:
	str	r0, [sp, #4]
	.loc 1 65 9
	ldr	r3, [sp, #4]
	cmp	r3, #3
	bls	.L33
	.loc 1 65 9 is_stmt 0 discriminator 2
	ldr	r1, .L34
	movs	r0, #65
	bl	assert_nrf_callback
.L33:
	.loc 1 66 44 is_stmt 1
	ldr	r2, .L34+4
	ldr	r3, [sp, #4]
	add	r3, r3, r2
	ldrb	r3, [r3]	@ zero_extendqisi2
	.loc 1 66 9
	movs	r1, #0
	mov	r0, r3
	bl	nrf_gpio_pin_write
	.loc 1 67 1
	nop
	add	sp, sp, #12
.LCFI43:
	@ sp needed
	ldr	pc, [sp], #4
.L35:
	.align	2
.L34:
	.word	.LC1
	.word	m_board_led_list
.LFE203:
	.size	bsp_board_led_on, .-bsp_board_led_on
	.section	.text.bsp_board_led_off,"ax",%progbits
	.align	1
	.global	bsp_board_led_off
	.syntax unified
	.thumb
	.thumb_func
	.type	bsp_board_led_off, %function
bsp_board_led_off:
.LFB204:
	.loc 1 70 1
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI44:
	sub	sp, sp, #12
.LCFI45:
	str	r0, [sp, #4]
	.loc 1 71 5
	ldr	r3, [sp, #4]
	cmp	r3, #3
	bls	.L37
	.loc 1 71 5 is_stmt 0 discriminator 2
	ldr	r1, .L38
	movs	r0, #71
	bl	assert_nrf_callback
.L37:
	.loc 1 72 40 is_stmt 1
	ldr	r2, .L38+4
	ldr	r3, [sp, #4]
	add	r3, r3, r2
	ldrb	r3, [r3]	@ zero_extendqisi2
	.loc 1 72 5
	movs	r1, #1
	mov	r0, r3
	bl	nrf_gpio_pin_write
	.loc 1 73 1
	nop
	add	sp, sp, #12
.LCFI46:
	@ sp needed
	ldr	pc, [sp], #4
.L39:
	.align	2
.L38:
	.word	.LC1
	.word	m_board_led_list
.LFE204:
	.size	bsp_board_led_off, .-bsp_board_led_off
	.section	.text.bsp_board_leds_off,"ax",%progbits
	.align	1
	.global	bsp_board_leds_off
	.syntax unified
	.thumb
	.thumb_func
	.type	bsp_board_leds_off, %function
bsp_board_leds_off:
.LFB205:
	.loc 1 76 1
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI47:
	sub	sp, sp, #12
.LCFI48:
	.loc 1 78 12
	movs	r3, #0
	str	r3, [sp, #4]
	.loc 1 78 5
	b	.L41
.L42:
	.loc 1 80 9 discriminator 3
	ldr	r0, [sp, #4]
	bl	bsp_board_led_off
	.loc 1 78 34 discriminator 3
	ldr	r3, [sp, #4]
	adds	r3, r3, #1
	str	r3, [sp, #4]
.L41:
	.loc 1 78 19 discriminator 1
	ldr	r3, [sp, #4]
	cmp	r3, #3
	bls	.L42
	.loc 1 82 1
	nop
	nop
	add	sp, sp, #12
.LCFI49:
	@ sp needed
	ldr	pc, [sp], #4
.LFE205:
	.size	bsp_board_leds_off, .-bsp_board_leds_off
	.section	.text.bsp_board_leds_on,"ax",%progbits
	.align	1
	.global	bsp_board_leds_on
	.syntax unified
	.thumb
	.thumb_func
	.type	bsp_board_leds_on, %function
bsp_board_leds_on:
.LFB206:
	.loc 1 85 1
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI50:
	sub	sp, sp, #12
.LCFI51:
	.loc 1 87 12
	movs	r3, #0
	str	r3, [sp, #4]
	.loc 1 87 5
	b	.L44
.L45:
	.loc 1 89 9 discriminator 3
	ldr	r0, [sp, #4]
	bl	bsp_board_led_on
	.loc 1 87 34 discriminator 3
	ldr	r3, [sp, #4]
	adds	r3, r3, #1
	str	r3, [sp, #4]
.L44:
	.loc 1 87 19 discriminator 1
	ldr	r3, [sp, #4]
	cmp	r3, #3
	bls	.L45
	.loc 1 91 1
	nop
	nop
	add	sp, sp, #12
.LCFI52:
	@ sp needed
	ldr	pc, [sp], #4
.LFE206:
	.size	bsp_board_leds_on, .-bsp_board_leds_on
	.section	.text.bsp_board_led_invert,"ax",%progbits
	.align	1
	.global	bsp_board_led_invert
	.syntax unified
	.thumb
	.thumb_func
	.type	bsp_board_led_invert, %function
bsp_board_led_invert:
.LFB207:
	.loc 1 94 1
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI53:
	sub	sp, sp, #12
.LCFI54:
	str	r0, [sp, #4]
	.loc 1 95 5
	ldr	r3, [sp, #4]
	cmp	r3, #3
	bls	.L47
	.loc 1 95 5 is_stmt 0 discriminator 2
	ldr	r1, .L48
	movs	r0, #95
	bl	assert_nrf_callback
.L47:
	.loc 1 96 41 is_stmt 1
	ldr	r2, .L48+4
	ldr	r3, [sp, #4]
	add	r3, r3, r2
	ldrb	r3, [r3]	@ zero_extendqisi2
	.loc 1 96 5
	mov	r0, r3
	bl	nrf_gpio_pin_toggle
	.loc 1 97 1
	nop
	add	sp, sp, #12
.LCFI55:
	@ sp needed
	ldr	pc, [sp], #4
.L49:
	.align	2
.L48:
	.word	.LC1
	.word	m_board_led_list
.LFE207:
	.size	bsp_board_led_invert, .-bsp_board_led_invert
	.section	.text.bsp_board_leds_init,"ax",%progbits
	.align	1
	.syntax unified
	.thumb
	.thumb_func
	.type	bsp_board_leds_init, %function
bsp_board_leds_init:
.LFB208:
	.loc 1 126 1
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI56:
	sub	sp, sp, #12
.LCFI57:
	.loc 1 140 12
	movs	r3, #0
	str	r3, [sp, #4]
	.loc 1 140 5
	b	.L51
.L52:
	.loc 1 142 45 discriminator 3
	ldr	r2, .L53
	ldr	r3, [sp, #4]
	add	r3, r3, r2
	ldrb	r3, [r3]	@ zero_extendqisi2
	.loc 1 142 9 discriminator 3
	mov	r0, r3
	bl	nrf_gpio_cfg_output
	.loc 1 140 34 discriminator 3
	ldr	r3, [sp, #4]
	adds	r3, r3, #1
	str	r3, [sp, #4]
.L51:
	.loc 1 140 19 discriminator 1
	ldr	r3, [sp, #4]
	cmp	r3, #3
	bls	.L52
	.loc 1 144 5
	bl	bsp_board_leds_off
	.loc 1 145 1
	nop
	add	sp, sp, #12
.LCFI58:
	@ sp needed
	ldr	pc, [sp], #4
.L54:
	.align	2
.L53:
	.word	m_board_led_list
.LFE208:
	.size	bsp_board_leds_init, .-bsp_board_leds_init
	.section	.text.bsp_board_led_idx_to_pin,"ax",%progbits
	.align	1
	.global	bsp_board_led_idx_to_pin
	.syntax unified
	.thumb
	.thumb_func
	.type	bsp_board_led_idx_to_pin, %function
bsp_board_led_idx_to_pin:
.LFB209:
	.loc 1 148 1
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI59:
	sub	sp, sp, #12
.LCFI60:
	str	r0, [sp, #4]
	.loc 1 149 5
	ldr	r3, [sp, #4]
	cmp	r3, #3
	bls	.L56
	.loc 1 149 5 is_stmt 0 discriminator 2
	ldr	r1, .L58
	movs	r0, #149
	bl	assert_nrf_callback
.L56:
	.loc 1 150 28 is_stmt 1
	ldr	r2, .L58+4
	ldr	r3, [sp, #4]
	add	r3, r3, r2
	ldrb	r3, [r3]	@ zero_extendqisi2
	.loc 1 151 1
	mov	r0, r3
	add	sp, sp, #12
.LCFI61:
	@ sp needed
	ldr	pc, [sp], #4
.L59:
	.align	2
.L58:
	.word	.LC1
	.word	m_board_led_list
.LFE209:
	.size	bsp_board_led_idx_to_pin, .-bsp_board_led_idx_to_pin
	.section	.text.bsp_board_pin_to_led_idx,"ax",%progbits
	.align	1
	.global	bsp_board_pin_to_led_idx
	.syntax unified
	.thumb
	.thumb_func
	.type	bsp_board_pin_to_led_idx, %function
bsp_board_pin_to_led_idx:
.LFB210:
	.loc 1 154 1
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	sub	sp, sp, #16
.LCFI62:
	str	r0, [sp, #4]
	.loc 1 155 14
	mov	r3, #-1
	str	r3, [sp, #12]
	.loc 1 157 12
	movs	r3, #0
	str	r3, [sp, #8]
	.loc 1 157 5
	b	.L61
.L64:
	.loc 1 159 29
	ldr	r2, .L66
	ldr	r3, [sp, #8]
	add	r3, r3, r2
	ldrb	r3, [r3]	@ zero_extendqisi2
	mov	r2, r3
	.loc 1 159 12
	ldr	r3, [sp, #4]
	cmp	r3, r2
	bne	.L62
	.loc 1 161 17
	ldr	r3, [sp, #8]
	str	r3, [sp, #12]
	.loc 1 162 13
	b	.L63
.L62:
	.loc 1 157 34 discriminator 2
	ldr	r3, [sp, #8]
	adds	r3, r3, #1
	str	r3, [sp, #8]
.L61:
	.loc 1 157 19 discriminator 1
	ldr	r3, [sp, #8]
	cmp	r3, #3
	bls	.L64
.L63:
	.loc 1 165 12
	ldr	r3, [sp, #12]
	.loc 1 166 1
	mov	r0, r3
	add	sp, sp, #16
.LCFI63:
	@ sp needed
	bx	lr
.L67:
	.align	2
.L66:
	.word	m_board_led_list
.LFE210:
	.size	bsp_board_pin_to_led_idx, .-bsp_board_pin_to_led_idx
	.section	.text.bsp_board_button_state_get,"ax",%progbits
	.align	1
	.global	bsp_board_button_state_get
	.syntax unified
	.thumb
	.thumb_func
	.type	bsp_board_button_state_get, %function
bsp_board_button_state_get:
.LFB211:
	.loc 1 171 1
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI64:
	sub	sp, sp, #20
.LCFI65:
	str	r0, [sp, #4]
	.loc 1 172 5
	ldr	r3, [sp, #4]
	cmp	r3, #3
	bls	.L69
	.loc 1 172 5 is_stmt 0 discriminator 2
	ldr	r1, .L71
	movs	r0, #172
	bl	assert_nrf_callback
.L69:
	.loc 1 173 54 is_stmt 1
	ldr	r2, .L71+4
	ldr	r3, [sp, #4]
	add	r3, r3, r2
	ldrb	r3, [r3]	@ zero_extendqisi2
	.loc 1 173 20
	mov	r0, r3
	bl	nrf_gpio_pin_read
	mov	r3, r0
	.loc 1 173 10
	cmp	r3, #0
	ite	ne
	movne	r3, #1
	moveq	r3, #0
	strb	r3, [sp, #15]
	.loc 1 174 5
	ldrb	r3, [sp, #15]	@ zero_extendqisi2
	cmp	r3, #0
	ite	ne
	movne	r3, #1
	moveq	r3, #0
	uxtb	r3, r3
	eor	r3, r3, #1
	uxtb	r3, r3
	.loc 1 174 21
	and	r3, r3, #1
	uxtb	r3, r3
	.loc 1 175 1
	mov	r0, r3
	add	sp, sp, #20
.LCFI66:
	@ sp needed
	ldr	pc, [sp], #4
.L72:
	.align	2
.L71:
	