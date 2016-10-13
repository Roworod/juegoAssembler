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
		mov r4,#0
		push {r4}

		bl imprimirImagen

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
	mov r4,#0
	push {r4}

	bl imprimirImagen

	/*ldr r0,=posCharacterY
	ldr r0,[r0]
	add r0,#1
	ldr r1,=posCharacterY
	str r0,[r1]*/

disparo:
@@------------------------------------------------
@@si hubo un disparo
@@------------------------------------------------
	ldr r0,=posArrowY
	ldr r0,[r0]
	ldr r1,=arrowM
	ldr r2,=arrowMWidth
	ldr r2,[r2]
	ldr r3,=arrowMHeight
	ldr r3,[r3]
	ldr r4,=posArrowX
	ldr r4,[r4]

	push {r4}

	bl imprimirImagen
	ldr r0,=posArrowX
	ldr r0,[r0]
	add r0,#35
	ldr r1,=posArrowX
	str r0,[r1]

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
		cmp r1,#119
		moveq r0,#1
		cmp r1,#118
		moveq r1,#0
		cmp r1,#2
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
.global bienvenida
.global topePantalla
pixelAddr: .word 0
posX: .word 0
posY: .word 200
tempSizeX: .word 0
tempSizeY: .word 0
posCharacterY: .word 200
usuario: .asciz " "
posArrowY: .word 0
posArrowX: .word 0
bienvenida: .asciz "bienvenido"
topeFlecha: .word 390
topePantalla: .word 679
.end
