/*********************************
*@aiuthor Robbin Woods Rodriguez 15201
*@version 1.0
*main.s
************************************************/
.text
.align 2
.global main
main:	

	#-------------------------
	#get screen address
	#-------------------------
	bl getScreenAddr
	ldr r1,=pixelAddr
	str r0,[r1]

infiniteLoopTotal:
@@--------------------------------------------
@@aqui se imprime el fondo
@@--------------------------------------------

		mov r0,#0
		ldr r1,=fondoM
		ldr r2,=fondoMWidth
		ldr r2,[r2]
		ldr r3,=fondoMHeight
		ldr r3,[r3]

		bl imprimirImagen


@@-----------------------------------------------
@@delay
@@-----------------------------------------------
		/*mov r5,#0x4000000
		wait:
		 	mov r0, #0x4000000 @ big number
			sleepLoop:
		 	subs r0,#1
		 	bne sleepLoop @ loop delay
			sub r5,#1
			cmp r5,#0
			bgt wait*/

@@---------------------------------------------
@@aqui se imprime el personaje
@@--------------------------------------------		
	character:
	@@comienzo de impresion imagen 1
	ldr r0,=posX
	ldr r0,[r0]
	push {r0}
	ldr r0,=posCharacterY
	ldr r0,[r0]
	ldr r1,=run1
	ldr r2,=run1Width
	ldr r2,[r2]
	ldr r3,=run1Height
	ldr r3,[r3]

	bl imprimirImagen

	ldr r0,=posCharacterY
	ldr r0,[r0]
	add r0,#1
	ldr r1,=posCharacterY
	str r0,[r1]

	b leerUsuario



leerUsuario:
@@---------------------------------------------
@@aqui se decide la posicion en y del personaje
@@---------------------------------------------
		MOV R7,#3
		MOV R0,#0
		MOV R2,#1
		LDR R1,=usuario
		SWI 0

		ldr r1,=usuario
		ldr r1,[r1]
		mov r0,#99
		cmp r1,"w"
		moveq r0,#1
		cmp r1,"s"
		moveq r0,#0
		cmp r1,"v"
		moveq r1,#2
		cmp r1,#2
		blne movimiento
		bne infiniteLoopTotal
		beq disparo

disparo:
@@------------------------------------------------
@@si hubo un disparo
@@------------------------------------------------
	bl movimientoX

	ldr r0,=posX
	ldr r0,[r0]
	push {r0}
	ldr r0,=posArrowY
	ldr r0,[r0]
	ldr r1,=arrowM
	ldr r2,=arrowMWidth
	ldr r2,[r2]
	ldr r3,=arrowMHeight
	ldr r3,[r3]
	bl movimiento

	b infiniteLoopTotal

	mov r7,#1
	swi 0


.data
.balign 4
.global pixelAddr
.global posX
.global posY
.global tempSizeY
.global tempSizeX
.global posCharacterY
.global posArrowX
.global posArrowY
pixelAddr: .word 0
posX: .word 0
posY: .word 200
tempSizeX: .word 0
tempSizeY: .word 0
posCharacterY: .word 200
usuario: .asciz " "
posArrowY: .word 0
posArrowX: .word 0
.end
