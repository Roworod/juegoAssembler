
.text
.align 2
.global main
main:
	/*Screen adress*/
	bl getScreenAddr
	ldr r1,=pixelAddr
	str r0,[r1]

	/*Direccion del gpio*/
	bl GetGpioAddress

	/*Lectura del puerto que se va a usar para los botones*/

	@@puerto 17 ACEPTAR
	mov r0,#17
	mov r1, #0
	bl SetGpioFunction

	@@puerto 18 AZUL
	mov r0,#18
	mov r1, #0
	bl SetGpioFunction

	@@puerto 27 VERDE
	mov r0,#27
	mov r1, #0
	bl SetGpioFunction

	@@puerto 22 ROJO
	mov r0,#22
	mov r1, #0
	bl SetGpioFunction

	@@puerto 23 AMARILLO
	mov r0,#23
	mov r1, #0
	bl SetGpioFunction




	loop:
	/*IMPRIMIENDO IMAGENES DE FONDO SI NO SE HA HECHO NADA AUN*/
		ldr r0, =prueba
		bl puts
		
		bl background

		/*Personaje*/
		mov r0, #10
		ldr r1,=run1
		ldr r2,=run1Width
		ldr r2,[r2]
		ldr r3,=run1Height
		ldr r3,[r3]
		mov r4,#50
		bl imprimirImagen

		/*delay para ver mas tiempo al personaje*/
		bl wait

		/*COMPARACIONES DE LOS BOTONES Y MOVIMIENTOS*/
		@@NOTA: HAY QUE ARREGLAR TODOS LOS B LOOPS SI ES QUE ESTAN PRESIONADOS
		@@Leemos boton start
		mov r0, #17
		bl GetGpio
		mov r4, r0
		cmp r4, #0
		bne presionadoStart
		beq	sinPresionarStart

		sinPresionarStart:
			@@Leemos boton Azul (mover derecha)
			mov r0, #18
			bl GetGpio
			mov r4, r0
			cmp r4, #0
			bne presionadoAzul
			beq	sinPresionarAzul

			sinPresionarAzul:
				@@Leemos boton Verde (mover abajo)
				mov r0, #27
				bl GetGpio
				mov r4, r0
				cmp r4, #0
				bne presionadoVerde
				beq	sinPresionarVerde

				sinPresionarVerde:
					@@Leemos boton Rojo (mover arriba)
					mov r0, #22
					bl GetGpio
					mov r4, r0
					cmp r4, #0
					bne presionadoRojo
					beq	sinPresionarRojo

					sinPresionarRojo:
						@@Leemos boton Amarillo (mover arriba)
						mov r0, #23
						bl GetGpio
						mov r4, r0
						cmp r4, #0
						bne presionadoAmarillo 
						beq	sinPresionarAmarillo

						sinPresionarAmarillo:
						ldr r0,=mensajeNoPresionado
						bl puts
						b loop

						presionadoAmarillo:
						ldr r0,=mensajePresionadoAmarillo
						bl puts
						b loop

					presionadoRojo:
					ldr r0, =mensajePresionadoRojo
					bl puts
					b loop

				presionadoVerde:
				ldr r0, =mensajePresionadoVerde
				bl puts
				b loop

			presionadoAzul:
			ldr r0,=mensajePresionadoAzul
			bl puts
			b loop

		presionadoStart:
			ldr r0,=mensajePresionadoStart
			bl puts
			b loop

	b loop


/*******************SUBRUTINAS******************/

/*Para obtener el valor si esta presionado o no el boton*/
GetGpio:
	push {lr}
	mov r9, r0
	ldr r6, =myloc
 	ldr r0, [r6] @ obtener direccion 
	ldr r5,[r0,#0x34]
	mov r7,#1
	lsl r7,r9
	and r5,r7 

	teq r5, #0
	movne r5, #1
	mov r0, r5
	pop {pc}

/*DELAY*/
wait:
	push {lr}
		mov r0, #0x6000000 @ big number
			sleepLoop:
			subs r0,#1
			bne sleepLoop @ loop delay
	pop {pc}

/*Imprimir background*/
background:
	push {lr}
		mov r0,#0
		ldr r1,=fondoM
		ldr r2,=fondoMWidth
		ldr r2,[r2]
		ldr r3,=fondoMHeight
		ldr r3,[r3]
		mov r4, #0
		bl imprimirImagen
	pop {pc}

.data
.align 2
.global pixelAddr
.global posX
.global posY
.global tempSizeY
.global tempSizeX
.global posCharacterY
.global posArrowX
.global posArrowY
.global myloc
mensajePresionadoStart: .asciz "Boton start esta siendo presionado... \n"
mensajePresionadoAzul: .asciz "Boton Azul esta siendo presionado... \n"
mensajePresionadoVerde: .asciz "Boton Verde esta siendo presionado... \n"
mensajePresionadoRojo: .asciz "Boton Rojo esta siendo presionado... \n"
mensajePresionadoAmarillo: .asciz "Boton Amarillo esta siendo presionado... \n"
mensajeNoPresionado: .asciz "NINGUN boton esta siendo presionado... \n"
myloc: 
	.word 0
pixelAddr: .word 0
masmenosX: .word 20
masmenosY: .word 20
posX: .word 0
posY: .word 200

posXlink: .word 0
posYlink: .word 0

tempSizeX: .word 0
tempSizeY: .word 0
posCharacterY: .word 200
usuario: .asciz " "
posArrowY: .word 0
posArrowX: .word 0
prueba: .asciz "PRUEBA \n"
prueba2: .asciz "PRUEBA wait \n"
.end
