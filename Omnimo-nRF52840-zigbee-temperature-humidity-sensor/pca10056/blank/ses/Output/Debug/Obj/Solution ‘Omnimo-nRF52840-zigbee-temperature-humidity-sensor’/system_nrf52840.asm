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
	.file	"system_nrf52840.c"
	.text
.Ltext0:
	.file 1 "D:\\OMNIO\\nrf5_sdk_for_thread_and_zigbee_v4.2.0_af27f76\\modules\\nrfx\\mdk\\system_nrf52840.c"
	.section	.text.NVIC_SystemReset,"ax",%progbits
	.align	1
	.syntax unified
	.thumb
	.thumb_func
	.type	NVIC_SystemReset, %function
NVIC_SystemReset:
.LFB130:
	.file 2 "../../../../../../../components/toolchain/cmsis/include/core_cm4.h"
	.loc 2 1791 1
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
.LBB12:
.LBB13:
	.file 3 "../../../../../../../components/toolchain/cmsis/include/cmsis_gcc.h"
	.loc 3 429 3
	.syntax unified
@ 429 "../../../../../../../components/toolchain/cmsis/include/cmsis_gcc.h" 1
	dsb 0xF
@ 0 "" 2
	.loc 3 430 1
	.thumb
	.syntax unified
	nop
.LBE13:
.LBE12:
	.loc 2 1795 32
	ldr	r3, .L3
	ldr	r3, [r3, #12]
	.loc 2 1795 40
	and	r2, r3, #1792
	.loc 2 1794 6
	ldr	r1, .L3
	.loc 2 1794 17
	ldr	r3, .L3+4
	orrs	r3, r3, r2
	.loc 2 1794 15
	str	r3, [r1, #12]
.LBB14:
.LBB15:
	.loc 3 429 3
	.syntax unified
@ 429 "../../../../../../../components/toolchain/cmsis/include/cmsis_gcc.h" 1
	dsb 0xF
@ 0 "" 2
	.loc 3 430 1
	.thumb
	.syntax unified
	nop
.L2:
.LBE15:
.LBE14:
.LBB16:
.LBB17:
	.loc 3 375 3 discriminator 1
	.syntax unified
@ 375 "../../../../../../../components/toolchain/cmsis/include/cmsis_gcc.h" 1
	nop
@ 0 "" 2
	.loc 3 376 1 discriminator 1
	.thumb
	.syntax unified
	nop
.LBE17:
.LBE16:
	.loc 2 1801 5 discriminator 1
	b	.L2
.L4:
	.align	2
.L3:
	.word	-536810240
	.word	100270084
.LFE130:
	.size	NVIC_SystemReset, .-NVIC_SystemReset
	.global	SystemCoreClock
	.section	.data.SystemCoreClock,"aw"
	.align	2
	.type	SystemCoreClock, %object
	.size	SystemCoreClock, 4
SystemCoreClock:
	.word	64000000
	.section	.text.SystemCoreClockUpdate,"ax",%progbits
	.align	1
	.global	SystemCoreClockUpdate
	.syntax unified
	.thumb
	.thumb_func
	.type	SystemCoreClockUpdate, %function
SystemCoreClockUpdate:
.LFB136:
	.loc 1 53 1
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	.loc 1 54 21
	ldr	r3, .L6
	ldr	r2, .L6+4
	str	r2, [r3]
	.loc 1 55 1
	nop
	bx	lr
.L7:
	.align	2
.L6:
	.word	SystemCoreClock
	.word	64000000
.LFE136:
	.size	SystemCoreClockUpdate, .-SystemCoreClockUpdate
	.section	.text.SystemInit,"ax",%progbits
	.align	1
	.global	SystemInit
	.syntax unified
	.thumb
	.thumb_func
	.type	SystemInit, %function
SystemInit:
.LFB137:
	.loc 1 58 1
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r3, lr}
.LCFI0:
	.loc 1 81 9
	bl	errata_36
	mov	r3, r0
	.loc 1 81 8
	cmp	r3, #0
	beq	.L9
	.loc 1 82 18
	mov	r3, #1073741824
	.loc 1 82 32
	movs	r2, #0
	str	r2, [r3, #268]
	.loc 1 83 18
	mov	r3, #1073741824
	.loc 1 83 32
	movs	r2, #0
	str	r2, [r3, #272]
	.loc 1 84 18
	mov	r3, #1073741824
	.loc 1 84 25
	movs	r2, #0
	str	r2, [r3, #1336]
.L9:
	.loc 1 89 9
	bl	errata_66
	mov	r3, r0
	.loc 1 89 8
	cmp	r3, #0
	beq	.L10
	.loc 1 90 32
	mov	r3, #268435456
	.loc 1 90 17
	ldr	r2, .L22
	.loc 1 90 38
	ldr	r3, [r3, #1028]
	.loc 1 90 22
	str	r3, [r2, #1312]
	.loc 1 91 32
	mov	r3, #268435456
	.loc 1 91 17
	ldr	r2, .L22
	.loc 1 91 38
	ldr	r3, [r3, #1032]
	.loc 1 91 22
	str	r3, [r2, #1316]
	.loc 1 92 32
	mov	r3, #268435456
	.loc 1 92 17
	ldr	r2, .L22
	.loc 1 92 38
	ldr	r3, [r3, #1036]
	.loc 1 92 22
	str	r3, [r2, #1320]
	.loc 1 93 32
	mov	r3, #268435456
	.loc 1 93 17
	ldr	r2, .L22
	.loc 1 93 38
	ldr	r3, [r3, #1040]
	.loc 1 93 22
	str	r3, [r2, #1324]
	.loc 1 94 32
	mov	r3, #268435456
	.loc 1 94 17
	ldr	r2, .L22
	.loc 1 94 38
	ldr	r3, [r3, #1044]
	.loc 1 94 22
	str	r3, [r2, #1328]
	.loc 1 95 32
	mov	r3, #268435456
	.loc 1 95 17
	ldr	r2, .L22
	.loc 1 95 38
	ldr	r3, [r3, #1048]
	.loc 1 95 22
	str	r3, [r2, #1332]
	.loc 1 96 32
	mov	r3, #268435456
	.loc 1 96 17
	ldr	r2, .L22
	.loc 1 96 38
	ldr	r3, [r3, #1052]
	.loc 1 96 22
	str	r3, [r2, #1344]
	.loc 1 97 32
	mov	r3, #268435456
	.loc 1 97 17
	ldr	r2, .L22
	.loc 1 97 38
	ldr	r3, [r3, #1056]
	.loc 1 97 22
	str	r3, [r2, #1348]
	.loc 1 98 32
	mov	r3, #268435456
	.loc 1 98 17
	ldr	r2, .L22
	.loc 1 98 38
	ldr	r3, [r3, #1060]
	.loc 1 98 22
	str	r3, [r2, #1352]
	.loc 1 99 32
	mov	r3, #268435456
	.loc 1 99 17
	ldr	r2, .L22
	.loc 1 99 38
	ldr	r3, [r3, #1064]
	.loc 1 99 22
	str	r3, [r2, #1356]
	.loc 1 100 32
	mov	r3, #268435456
	.loc 1 100 17
	ldr	r2, .L22
	.loc 1 100 38
	ldr	r3, [r3, #1068]
	.loc 1 100 22
	str	r3, [r2, #1360]
	.loc 1 101 32
	mov	r3, #268435456
	.loc 1 101 17
	ldr	r2, .L22
	.loc 1 101 38
	ldr	r3, [r3, #1072]
	.loc 1 101 22
	str	r3, [r2, #1364]
	.loc 1 102 32
	mov	r3, #268435456
	.loc 1 102 17
	ldr	r2, .L22
	.loc 1 102 38
	ldr	r3, [r3, #1076]
	.loc 1 102 22
	str	r3, [r2, #1376]
	.loc 1 103 32
	mov	r3, #268435456
	.loc 1 103 17
	ldr	r2, .L22
	.loc 1 103 38
	ldr	r3, [r3, #1080]
	.loc 1 103 22
	str	r3, [r2, #1380]
	.loc 1 104 32
	mov	r3, #268435456
	.loc 1 104 17
	ldr	r2, .L22
	.loc 1 104 38
	ldr	r3, [r3, #1084]
	.loc 1 104 22
	str	r3, [r2, #1384]
	.loc 1 105 32
	mov	r3, #268435456
	.loc 1 105 17
	ldr	r2, .L22
	.loc 1 105 38
	ldr	r3, [r3, #1088]
	.loc 1 105 22
	str	r3, [r2, #1388]
	.loc 1 106 32
	mov	r3, #268435456
	.loc 1 106 17
	ldr	r2, .L22
	.loc 1 106 38
	ldr	r3, [r3, #1092]
	.loc 1 106 22
	str	r3, [r2, #1392]
.L10:
	.loc 1 111 9
	bl	errata_98
	mov	r3, r0
	.loc 1 111 8
	cmp	r3, #0
	beq	.L11
	.loc 1 112 9
	ldr	r3, .L22+4
	.loc 1 112 44
	ldr	r2, .L22+8
	str	r2, [r3]
.L11:
	.loc 1 117 9
	bl	errata_103
	mov	r3, r0
	.loc 1 117 8
	cmp	r3, #0
	beq	.L12
	.loc 1 118 16
	ldr	r3, .L22+12
	.loc 1 118 32
	movs	r2, #251
	str	r2, [r3, #1304]
.L12:
	.loc 1 123 9
	bl	errata_115
	mov	r3, r0
	.loc 1 123 8
	cmp	r3, #0
	beq	.L13
	.loc 1 124 47
	ldr	r3, .L22+16
	ldr	r3, [r3]
	.loc 1 124 82
	bic	r2, r3, #15
	.loc 1 124 101
	ldr	r3, .L22+20
	ldr	r3, [r3]
	.loc 1 124 127
	and	r3, r3, #15
	.loc 1 124 9
	ldr	r1, .L22+16
	.loc 1 124 98
	orrs	r3, r3, r2
	.loc 1 124 44
	str	r3, [r1]
.L13:
	.loc 1 129 9
	bl	errata_120
	mov	r3, r0
	.loc 1 129 8
	cmp	r3, #0
	beq	.L14
	.loc 1 130 9
	ldr	r3, .L22+24
	.loc 1 130 44
	mov	r2, #512
	str	r2, [r3]
.L14:
	.loc 1 135 9
	bl	errata_136
	mov	r3, r0
	.loc 1 135 8
	cmp	r3, #0
	beq	.L15
	.loc 1 136 22
	mov	r3, #1073741824
	ldr	r3, [r3, #1024]
	.loc 1 136 34
	and	r3, r3, #1
	.loc 1 136 12
	cmp	r3, #0
	beq	.L15
	.loc 1 137 22
	mov	r3, #1073741824
	.loc 1 137 34
	mvn	r2, #1
	str	r2, [r3, #1024]
.L15:
	.loc 1 145 12
	ldr	r3, .L22+28
	ldr	r3, [r3, #136]
	ldr	r2, .L22+28
	.loc 1 145 20
	orr	r3, r3, #15728640
	str	r3, [r2, #136]
.LBB18:
.LBB19:
	.loc 3 429 3
	.syntax unified
@ 429 "../../../../../../../components/toolchain/cmsis/include/cmsis_gcc.h" 1
	dsb 0xF
@ 0 "" 2
	.loc 3 430 1
	.thumb
	.syntax unified
	nop
.LBE19:
.LBE18:
.LBB20:
.LBB21:
	.loc 3 418 3
	.syntax unified
@ 418 "../../../../../../../components/toolchain/cmsis/include/cmsis_gcc.h" 1
	isb 0xF
@ 0 "" 2
	.loc 3 419 1
	.thumb
	.syntax unified
	nop
.LBE21:
.LBE20:
	.loc 1 169 23
	mov	r3, #268439552
	.loc 1 169 34
	ldr	r3, [r3, #512]
	.loc 1 169 12
	cmp	r3, #0
	blt	.L16
	.loc 1 170 23 discriminator 1
	mov	r3, #268439552
	.loc 1 170 34 discriminator 1
	ldr	r3, [r3, #516]
	.loc 1 169 137 discriminator 1
	cmp	r3, #0
	bge	.L17
.L16:
	.loc 1 171 21
	ldr	r3, .L22+32
	.loc 1 171 30
	movs	r2, #1
	str	r2, [r3, #1284]
	.loc 1 172 19
	nop
.L18:
	.loc 1 172 28 discriminator 1
	ldr	r3, .L22+32
	ldr	r3, [r3, #1024]
	.loc 1 172 36 discriminator 1
	cmp	r3, #0
	beq	.L18
	.loc 1 173 21
	mov	r3, #268439552
	.loc 1 173 36
	movs	r2, #18
	str	r2, [r3, #512]
	.loc 1 174 19
	nop
.L19:
	.loc 1 174 28 discriminator 1
	ldr	r3, .L22+32
	ldr	r3, [r3, #1024]
	.loc 1 174 36 discriminator 1
	cmp	r3, #0
	beq	.L19
	.loc 1 175 21
	mov	r3, #268439552
	.loc 1 175 36
	movs	r2, #18
	str	r2, [r3, #516]
	.loc 1 176 19
	nop
.L20:
	.loc 1 176 28 discriminator 1
	ldr	r3, .L22+32
	ldr	r3, [r3, #1024]
	.loc 1 176 36 discriminator 1
	cmp	r3, #0
	beq	.L20
	.loc 1 177 21
	ldr	r3, .L22+32
	.loc