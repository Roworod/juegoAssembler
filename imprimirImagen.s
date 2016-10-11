.text
.global imprimirImagen

@@subrutina que imprime una imagen 
@@param: r0=posicionYInicial
@@	 	 r1=matriz de colores
@@		 r2=tamano X
@@		 r3=tamano y

imprimirImagen:
	push {lr}
	sizeX .req r10
	sizeY .req r11

	 @@guardando los tamanos
	 ldr r8,=tempSizeX
	 str r2,[r8]

	 ldr r8,=tempSizeY
	 str r3,[r8]

	 ldr r8,=posY
	 str r0,[r8]

	 push {r1}
	 mov r9,r2

	 recorrerFila:
	 	@@ya terminamos una fila??
	 	ldr sizeX,=tempSizeX
	 	ldr sizeX,[sizeX]
	 	sub sizeX,#1
	 	cmp sizeX,#0
	 	blt nextCol

	 	ldr r0,=tempSizeX
	 	str sizeX,[r0]

	 	@@imprimiendo la imagen
	 	ldr r0,=pixelAddr
	 	ldr r0,[r0]
	 	ldr r1,=posX
	 	ldr r1,[r1]
	 	ldr r2,=posY
	 	ldr r2,[r2]
	 	pop {r4}
	 	ldrb r3,[r4],#4
	 	push {r4}
	 	bl pixel

	 	@@moviendonos 1 en x
	 	ldr r0,=posX
	 	ldr r0,[r0]
	 	add r0,#1
	 	ldr r1,=posX
	 	str r0,[r1]
	 	b recorrerFila

	 nextCol:
	 	@@terminamos las columnas???
	 	ldr sizeY,=tempSizeY
	 	ldr sizeY,[sizeY]
	 	sub sizeY,#1
	 	cmp sizeY,#0
	 	beq fin

	 	ldr r0,=tempSizeY
	 	str sizeY,[r0]

	 	@@regresando en X
	 	ldr r0,=posX
	 	mov r1,#0
	 	str r1,[r0]

	 	@@denuevo el contador en x=inicial
	 	ldr r0,=tempSizeX
	 	str r9,[r0]

	 	@@bajando uno en y
	 	ldr r0,=posY
	 	ldr r0,[r0]
	 	add r0,#1
	 	ldr r1,=posY
	 	str r0,[r1]
	 	b recorrerFila

	 fin:
	 	pop {r9}
	 	pop {pc}
