# juegoAssembler
para poder correr este codigo es necesario hacer lo siguiente desde la consola de la quemu o la rasp (hay que estar en la direccion de la carpeta del juego)
1. gcc -0 phys_to_virt.c pixel.c
2. as -o mian1.o main1.s arrowM.s fondoM.s getGpio.s gpioO_2.s imprimirImagen.s movimientoX.s movimientoY.s run1.s
3. gcc -0 main1 main1.o phys_to_virt.o pixel.o
4. sudo ./main1

Si se edita algo de algun archivo hay que volver a compilar desde el punto 2 de las instrucciones anteriores...
