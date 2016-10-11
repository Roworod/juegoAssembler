/*********************************
*@aiuthor Robbin Woods Rodriguez 15201
*@version 1.0
*movimientoX.s
************************************************/

@@suma una posicion en X
@@param: none

.global movimientoX
movimientoX:
	@@guardando la y
	ldr r0,=posArrowY
	ldr r1,=posCharacterY
	ldr r1,[r1]
	str r1,[r0]

	ldr r0,=posArrowX
	ldr r0,[r0]
	add r0,#10
	ldr r1,= posArrowX
	str r0,[r1]

	mov pc,lr

