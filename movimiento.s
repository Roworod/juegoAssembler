/*********************************
*@aiuthor Robbin Woods Rodriguez 15201
*@version 1.0
*movimiento.s
************************************************/

@@suma una posicion en y
@@param: r0: 1 para subir, 0 para bajar u otro para omitir

.global movimiento
movimiento:
	parametro .req r9
	mov parametro, r9

	cmp parametro,#1
	beq arriba

	cmp parametro,#0
	beq abajo

	b finMovimiento

	arriba:
		ldr r0,=posCharacterY
		ldr r0,[r0]
		add r0,#1
		ldr r1,=posCharacterY
		str r0,[r1]
		b finMovimiento

	abajo:
		ldr r0,=posCharacterY
		ldr r0,[r0]
		sub r0,#1
		ldr r1,=posCharacterY
		str r0,[r1]
		b finMovimiento 

	finMovimiento:
		mov pc,lr



