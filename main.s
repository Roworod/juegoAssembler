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

	@@pintando la linea del suelo
	start:
		ldr r1,=mover
		ldr r1,[r1]
		cmp r1,#200
		bgt character
		ldr r0,=pixelAddr
		ldr r0,[r0]
		ldr r1,=mover
		ldr r1,[r1]
		mov r2,#400
		mov r3,#7

		bl pixel
		ldr r0,=mover
		ldr r0,[r0]
		add r0,#1
		ldr r1,=mover
		str r0,[r1]
		b fila

	character:
	@@comienzo de impresion imagen 1
	ldr r0,=salto
	ldr r0,[r0]
	ldr r1,=lttp1M
	ldr r2,=lttp1MWidth
	ldr r2,[r2]
	ldr r3,=lttp1MHeight
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
.global bienvenida
pixelAddr: .word 0
bienvenida: .asciz "Bienvenido nuevo usuario"
posX: .word 30
posY: .word 200
tempSizeX: .word 0
tempSizeY: .word 0
mover: .word 0
salto: .word 200
.end
