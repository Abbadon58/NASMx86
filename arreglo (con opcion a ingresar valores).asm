segment .data
    arre db 0, 0, 0, 0 ; Almacena los valores dentro del rango del cero al nueve para evitar imprimir símbolos
    len equ $-arre
    msg1 db "Ingrese un número y presione enter, cuatro veces:", 0xA
    len1 equ $-msg1
    ln db 10, 13
    lenln equ $-ln

segment .bss
    dato resb 2 ; Se reservan dos bytes debido a que al leer un dato del teclado se almacenará también el enter (\n) o salto de línea

segment .text
    global _start

_start:
    ; Mostrar mensaje de entrada
    mov eax, 4
    mov ebx, 1
    mov ecx, msg1
    mov edx, len1
    int 0x80

    ; Inicializar punteros y contadores
    mov esi, arre ; Coloca la dirección de memoria en el registro esi, para mejorar la velocidad del programa
    mov edi, 0 ; Se coloca el número cero en el registro edi que servirá de contador

ciclo_lectura:
    ; Leer datos del teclado
    mov eax, 3 ; Lee datos de un dispositivo
    mov ebx, 0 ; Especifica que el dispositivo es el teclado
    mov ecx, dato ; Dirección de memoria donde se almacenarán los caracteres leídos
    mov edx, 2 ; Lee dos bytes del teclado, el dato y el salto de línea (\n)
    int 0x80

    ; Procesar el dato leído
    mov al, [dato] ; Accede al dato introducido desde el teclado y se guarda en el registro al
    sub al, '0' ; Convierte el carácter a su valor numérico restando 30h (48 o el carácter '0')
    mov [esi+edi], al ; Coloca el dato dentro del arreglo en la posición edi (0,1,2,....) en bytes
    add edi, 1 ; Incrementa edi en uno
    cmp edi, len ; Pregunta si ya se han leído todos los números del arreglo
    jb ciclo_lectura ; Si aún faltan datos por leer, vuelve al ciclo de nuevo

    ; Reiniciar contador para impresión
    mov edi, 0 ; Coloca el número cero en el registro edi que servirá de contador

ciclo_impresion:
    ; Obtener y convertir el dato para impresión
    mov al, [esi+edi] ; Obtiene el dato dentro del arreglo en la posición edi (0,1,2,....)
    add al, '0' ; Convierte el número entero a carácter
    mov [dato], al ; Mueve el dato obtenido a la posición de memoria dato
    add edi, 1 ; Incrementa edi en uno

    ; Imprimir el dato
    mov eax, 4
    mov ebx, 0
    mov ecx, dato
    mov edx, 1
    int 0x80 ; Se imprime el valor de los elementos del arreglo en pantalla
    cmp edi, len ; Pregunta si ya se han impreso todos los datos del arreglo
    jb ciclo_impresion ; Si aún faltan datos por imprimir, vuelve al ciclo de nuevo

    ; Imprimir nueva línea
    mov eax, 4
    mov ebx, 1
    mov ecx, ln
    mov edx, lenln
    int 0x80

salir:
    ; Salir del programa
    mov eax, 1
    xor ebx, ebx
    int 0x80
