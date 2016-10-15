
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

	loopMenu:
		ldr r0, =prueba
		bl puts

		/*Patalla de menu*/
		mov r0,#0
		ldr r1,=startScreenM
		ldr r2,=startScreenMWidth
		ldr r2,[r2]
		ldr r3,=startScreenMHeight
		ldr r3,[r3]
		mov r4, #0
		bl imprimirImagen

		/*Condiciones de botones*/
		mov r0, #17
		bl GetGpio
		mov r4, r0
		cmp r4, #0
		bne presionadoStartMenu
		beq	sinPresionarStartMenu

		sinPresionarStartMenu:
			@@Leemos boton Rojo (mover derecha)
			mov r0, #22
			bl GetGpio
			mov r4, r0
			cmp r4, #0
			bne presionadoRojoMenu
			beq	sinPresionarRojoMenu

					sinPresionarRojoMenu:
						b loopMenu

					presionadoRojoMenu:
						ldr r0, =mensajePresionadoRojo
						bl puts
						miniLoop:
							/*Patalla de Instrucciones*/
							mov r0,#0
							ldr r1,=instruccionesScreenM
							ldr r2,=instruccionesScreenMWidth
							ldr r2,[r2]
							ldr r3,=instruccionesScreenMHeight
							ldr r3,[r3]
							mov r4, #0
							bl imprimirImagen
							@@Leemos boton Azul 
							mov r0, #18	
							bl GetGpio
							mov r4, r0
							cmp r4, #0
							bne regresarMenu
							beq	seguirEnInstrucciones
							regresarMenu:
								b loopMenu
							seguirEnInstrucciones:
								b miniLoop
						b miniLoop
					b loopMenu

		presionadoStartMenu:
			ldr r0,=mensajePresionadoStart
			bl puts
			b loop
	b loopMenu

	loop:
		ldr r0,=booleanEndGame
		ldr r0,[r0]
		cmp r0,#1
		beq endGame

	/*IMPRIMIENDO IMAGENES DE FONDO SI NO SE HA HECHO NADA AUN*/
		ldr r0, =prueba
		bl puts
		
		/*background*/
		bl background

		/*Villano*/
		bl enemigo

		/*si la flecha esta en movimiento*/
		ldr r0,=disparoFlechaBoolean
		ldr r0,[r0]
		cmp r0,#0
		beq continue
		bl flecha

		continue:
		/*Personaje*/
		mov r0,#0
		bl personaje @lo mantiene en la posicion actual

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
						ldr r0,=disparoFlechaBoolean
						mov r1,#1
						str r1,[r0]
						ldr r1,=posYlink
						ldr r1,[r1]
						ldr r0,=posArrowY
						str r1,[r0]
						b loop

					presionadoRojo:
						ldr r0, =mensajePresionadoRojo
						bl puts
						mov r0,#1
						mov r1,#1
						mov r3,#1
						bl personaje @Imprime a personaje en la nueva poscision
					b loop

				presionadoVerde:
					ldr r0, =mensajePresionadoVerde
					bl puts
					mov r0,#1
					mov r1,#1
					mov r3,#0
					bl personaje @Imprime a personaje en la nueva poscision
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

	endGame:
		/*Imprimir pantalla de gano*/
		@@Leemos boton start
		ldr r0,=booleanEndGame
		ldr r0, [r0]
		mov r4,#0
		ldr r0,=booleanEndGame
		str r4,[r0]

		verificar:
		mov r0, #17
		bl GetGpio
		mov r4, r0
		cmp r4, #0
		bne comenzarOtraVez
		beq	noEstaPresionado
		noEstaPresionado:
			mov r0,#0
			ldr r1,=youWinScreenM
			ldr r2,=youWinScreenMWidth
			ldr r2,[r2]
			ldr r3,=youWinScreenMHeight
			ldr r3,[r3]
			mov r4, #0
			bl imprimirImagen
			b verificar
		comenzarOtraVez:
			bl wait
			bl wait
			b loopMenu
		mov r7,#1
		swi 0


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


/*Imprimir la imagen del personaje con su respectivo movieminto en x o y*/
@@PARAMETROS
@@R0= 1(en realidad puede ser otro) / 0... 1 para saber si se movio el personaje durante el ciclo, 0 para dejarlo en la misma posicion
@@R1= 1(en realidad puede ser otro) / 0... 1 si hubo moviemiento en Y, 0 no hubo movimiento en Y por lo tanto fue en X
@@R2= 1(en realidad puede ser otro) / 0... Este parametro aplica solo si es que se movio durante el ciclo en X, 1 para la derecha en X, 0 para la izquierda en X
@@R3= 1(en realidad puede ser otro) / 0... Este parametro aplica solo si es que se movio durante el ciclo en Y, 1 para la Arriba en Y, 0 para abajo en Y 

personaje:
	push {lr}
		cmp r0, #0
		beq noSeMovioLink
		bne siSeMovioLink

		siSeMovioLink:
		cmp r1, #0
		beq fueEnX
		bne fueEnY

			fueEnX:
			cmp r2,#0
			beq izquierda1
			bne derecha1

				izquierda1:
					ldr r5,=posYlink
					ldr r5,[r5] @R5 tiene la pos actuar de link en Y
					mov r0, r5
					ldr r1,=run1
					ldr r2,=run1Width
					ldr r2,[r2]
					ldr r3,=run1Height
					ldr r3,[r3]
					ldr r6, =posXlink
					ldr r6,[r6] @R6 tiene la pos actual de link en X
					sub r6, r6, #20
					mov r4, r6
					ldr r7,=posXlink
					str r6,[r7]
					bl imprimirImagen
				b siga

				derecha1:
					ldr r5,=posYlink
					ldr r5,[r5] @R5 tiene la pos actuar de link en Y
					mov r0, r5
					ldr r1,=run1
					ldr r2,=run1Width
					ldr r2,[r2]
					ldr r3,=run1Height
					ldr r3,[r3]
					ldr r6, =posXlink
					ldr r6,[r6] @R6 tiene la pos actual de link en X
					add r6, r6, #20
					mov r4, r6
					ldr r7,=posXlink
					str r6,[r7]
					bl imprimirImagen
				b siga

			fueEnY:
			cmp r3, #0
			beq abajo1
			bne arriba1

				abajo1:
					ldr r5,=posYlink
					ldr r5,[r5] @R5 tiene la pos actuar de link en Y
					add r5, r5, #20
					@@ya topo
					ldr r1,=topePantalla
					ldr r1,[r1]
					cmp r5,r1
					bgt siga
					mov r0, r5
					ldr r7,=posYlink
					str r5,[r7]
					ldr r1,=run1
					ldr r2,=run1Width
					ldr r2,[r2]
					ldr r3,=run1Height
					ldr r3,[r3]
					ldr r6, =posXlink
					ldr r6,[r6] @R6 tiene la pos actual de link en X
					mov r4, r6
					bl imprimirImagen
				b siga

				arriba1:
					ldr r5,=posYlink
					ldr r5,[r5] @R5 tiene la pos actuar de link en Y
					sub r5, r5, #20
					cmp r5,#1
					blt siga
					mov r0, r5
					ldr r7,=posYlink
					str r5,[r7]
					ldr r1,=run1
					ldr r2,=run1Width
					ldr r2,[r2]
					ldr r3,=run1Height
					ldr r3,[r3]
					ldr r6, =posXlink
					ldr r6,[r6] @R6 tiene la pos actual de link en X
					mov r4, r6
					bl imprimirImagen
				b siga

		noSeMovioLink:
			ldr r5,=posYlink
			ldr r5,[r5] @R5 tiene la pos actuar de link en Y
			mov r0, r5
			ldr r1,=run1
			ldr r2,=run1Width
			ldr r2,[r2]
			ldr r3,=run1Height
			ldr r3,[r3]
			ldr r6,=posXlink
			ldr r6,[r6] @R6 tiene la pos actual de link en X
			mov r4,r6
			bl imprimirImagen
		b siga
	siga:
	pop {pc}

/*Imprimir la imagen de la flecha con su respectivo movieminto en x o y*/
@@Parametros
flecha:
	push {lr}

		ldr r0,=posArrowY
		ldr r0,[r0]
		ldr r1,=arrowM
		ldr r2,=arrowMWidth
		ldr r2,[r2]
		ldr r3,=arrowMHeight
		ldr r3,[r3]
		ldr r4,=posArrowX
		ldr r4,[r4]

		bl imprimirImagen

		ldr r1,=posArrowX
		ldr r1,[r1]
		add r1,#40
		ldr r0,=posArrowX
		str r1,[r0]

		ldr r0,=topePantallaX
		ldr r0,[r0]
		cmp r1,r0
		blt finFlecha

		ldr r0,=disparoFlechaBoolean
		mov r1,#0
		str r1,[r0]
		ldr r0,=posArrowX
		mov r1,#30
		str r1,[r0]
		bl terminoElJuego

		finFlecha:
		pop {pc}

/*Imprimiendo el enemigo Ganondorf*/
		@@impresion del enemigo
		enemigo:
		push {lr}

		ldr r0,=caminataGanodorfBoolean
		ldr r0,[r0]
		cmp r0,#0
		beq ganondorfBaja
		cmp r0,#1
		beq ganondorfSube

		ganondorfBaja:
			ldr r0,=posYGanondorf
			ldr r0,[r0]
			add r0,#10
			ldr r1,=posYGanondorf
			str r0,[r1]
			ldr r1,=topeGanondorf
			ldr r1,[r1]
			ldr r2,=caminataGanodorfBoolean
			mov r3,#1
			cmp r0,r1
			strgt r3,[r2]
			b finGanondorf

		ganondorfSube:
			ldr r0,=posYGanondorf
			ldr r0,[r0]
			sub r0,#10
			ldr r1,=posYGanondorf
			str r0,[r1]
			ldr r1,=topeGanondorf
			ldr r1,[r1]
			ldr r2,=caminataGanodorfBoolean
			mov r3,#0
			cmp r0,#20
			strlt r3,[r2]
			b finGanondorf

		finGanondorf:
			ldr r1,=ganondorfM
			ldr r2,=width
			ldr r2,[r2]
			ldr r3,=height
			ldr r3,[r3]
			ldr r4,=posXGanondorf
			ldr r4,[r4]
			bl imprimirImagen
	pop {pc}

@@viendo si el juego ya termino
terminoElJuego:
	push {lr}
	ganondorfInicio .req r0
	ganondorfFinal .req r1
	posicionFlecha .req r2
	
	ldr r5,=booleanEndGame
	mov r6,#1
	
	ldr ganondorfInicio,=posYGanondorf
	ldr ganondorfInicio,[ganondorfInicio]
	add ganondorfFinal,ganondorfInicio,#68

	ldr posicionFlecha,=posArrowY
	ldr posicionFlecha,[posicionFlecha]

	cmp posicionFlecha,ganondorfInicio
	blt finComprobacion
	cmp posicionFlecha,ganondorfFinal
	bgt finComprobacion

	str r6,[r5]

	finComprobacion:
		.unreq ganondorfInicio
		.unreq ganondorfFinal
		.unreq posicionFlecha
		pop {pc}


@@--------------------------------------------------------------
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
.global posXGanondorf
.global posYGanondorf
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
posYlink: .word 140


tempSizeX: .word 0
tempSizeY: .word 0
posCharacterY: .word 200
usuario: .asciz " "
posArrowY: .word 0
posArrowX: .word 0
topePantalla: .word 390
prueba: .asciz "PRUEBA \n"
prueba2: .asciz "PRUEBA wait \n"
disparoFlechaBoolean: .word 0
posYGanondorf: .word 10
posXGanondorf: .word 595
topePantallaX: .word 550
topeGanondorf: .word 400
caminataGanodorfBoolean: .word 0
booleanEndGame: .word 0

.end
