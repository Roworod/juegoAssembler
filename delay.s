.global delay
delay:
@@-----------------------------------------------
@@delay
@@-----------------------------------------------
		mov r5,#0xff00
		wait:
		 	mov r0, #0xff00 @ big number
			sleepLoop:
		 	subs r0,#1
		 	bne sleepLoop @ loop delay
			sub r5,#1
			cmp r5,#0
			bgt wait
			mov pc,lr

