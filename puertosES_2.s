@ puertosES_2.s prueba con puertos de entrada y salida
@ Funciona con cualquier puerto, utilizando biblioteca gpio0_2.s

 .text
 .align 2
 .global main
main:
	@utilizando la biblioteca GPIO (gpio0_2.s)
	bl GetGpioAddress @solo se llama una vez
	
	@GPIO para escritura puerto 15
	mov r0,#15
	mov r1,#1
	bl SetGpioFunction

	@GPIO para lectura puerto 14 
	mov r0,#14
	mov r1,#0
	bl SetGpioFunction
loop:
	@Apagar GPIO 15
	mov r0,#15
	mov r1,#0
	bl SetGpio

	@loop:
	@Revision del boton
	@Para revisar si el nivel de un GPIO esta en alto o bajo se revisa 
	@la direccion 0x3F20 0034 para los GPIO 0 - 31 */
	ldr r6, =myloc
 	ldr r0, [r6] @ obtener direccion 
	ldr r5,[r0,#0x34]
	mov r7,#1
	lsl r7,#14
	and r5,r7 

	@Si el boton esta en alto enciende GPIO 15
	teq r5,#0
	movne r0,#15
	movne r1,#1
	blne SetGpio
		
	b loop

@ brief pause routine
wait:
 mov r0, #0x4000000 @ big number
sleepLoop:
 subs r0,#1
 bne sleepLoop @ loop delay
 mov pc,lr

 .data
 .align 2
.global myloc
myloc: .word 0

 .end

