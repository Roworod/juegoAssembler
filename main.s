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


infiniteLoop:
@@--------------------------------------------
@@aqui se imprime el fondo
@@--------------------------------------------
/*
		mov r0,#0
		ldr r1,=fondoM
		ldr r2,=fondoMWidth
		ldr r2,[r2]
		ldr r3,=fondoMHeight
		ldr r3,[r3]

		bl imprimirImagen*/


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
		cmp r1,#119
		moveq r0,#1
		cmp r1,#115
		moveq r0,#0
		bl movimiento

@@-----------------------------------------------
@@delay
@@-----------------------------------------------
		mov r5,#0x4000000
		wait:
		 	mov r0, #0x4000000 @ big number
			sleepLoop:
		 	subs r0,#1
		 	bne sleepLoop @ loop delay
			sub r5,#1
			cmp r5,#0
			bgt wait

@@---------------------------------------------
@@aqui se imprime el personaje
@@--------------------------------------------		
	character:
	@@comienzo de impresion imagen 1
	ldr r0,=posCharacterY
	ldr r0,[r0]
	ldr r1,=run1
	ldr r2,=run1Width
	ldr r2,[r2]
	ldr r3,=run1Height
	ldr r3,[r3]

	bl imprimirImagen	


	close:
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
pixelAddr: .word 0
posX: .word 0
posY: .word 200
tempSizeX: .word 0
tempSizeY: .word 0
posCharacterY: .word 400
usuario: .asciz " "
.end
