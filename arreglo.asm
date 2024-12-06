segment .data
arre db '45', '23', '11', '09' ; estos datos se almacenan
; como bytes en memoria, de forma consecutiva
len equ $-arre
ln db 10,13
lenln equ $-ln
segment .text
global _start
_start:
mov ebp, arre ;copia la dirección de memoria en el registro ebp
mov edi, 1 ; guarda el número que servirá de contador en el
; registro edi
ciclo:
mov eax, 4
mov ebx, 0
mov ecx, ebp ; copia a ecx la direccion de memoria que esta
; almacenado en el registro ebp, de esa direccion de memoria
; es de donde se comenzara a imprimir
mov edx, 2 ; envia a imprimir 2 bytes a la pantalla
int 80h
mov eax, 4
mov ebx, 0
mov ecx, ln
mov edx, lenln
int 80h
add ebp, 2 ; aumenta en dos el valor de la dirección de
; memoria con el fin de obtener el "segundo" elemento
; del arreglo "23" esto porque el "primer" elemento es
; "45" un número de dos elementos
add edi, 2 ; aumenta en dos el valor del contador
cmp edi,len ; pregunta si ya se han impreso todos los
; datos del arreglo
jb ciclo ; si aun faltan datos por imprimir se repite
; el ciclo nuevamente
salir:
mov eax, 1
xor ebx, ebx
int 0x80