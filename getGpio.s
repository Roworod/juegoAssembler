.global getGpio

getGpio:
	@@ Subrutina revisa el nivel (alto o bajo) del GPIO.
	
	@@ r0 -- myloc
	
	mov r6,r0
	mov r1,r9	

	ldr r0,[r6]
	ldr r5,[r0,#0x34]
	
	mov r7,#1
	lsl r7,r9
	and r5,r7
	
	mov r0,r5

