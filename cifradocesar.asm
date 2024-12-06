section .data
    msg db 'Mi nombre es mario', 0 ; Cadena de texto original
    len equ $ - msg
    shift db 3 ; Número de posiciones a desplazar (cifrado César)
    newline db 10, 0

section .bss
    encrypted resb len ; Espacio para la cadena cifrada

section .text
    global _start

_start:
    ; Inicializar registros
    mov esi, msg ; Dirección de la cadena original
    mov edi, encrypted ; Dirección de la cadena cifrada
    mov ecx, len ; Longitud de la cadena

cifrado:
    lodsb ; Cargar el siguiente byte de la cadena original en AL
    cmp al, 0 ; Comprobar si es el final de la cadena
    je fin_cifrado ; Si es el final, saltar a fin_cifrado

    ; Comprobar si el carácter es una letra mayúscula
    cmp al, 'A'
    jb no_cifrar
    cmp al, 'Z'
    ja comprobar_minuscula

    ; Cifrar letra mayúscula
    add al, [shift]
    cmp al, 'Z'
    jbe almacenar
    sub al, 26
    jmp almacenar

comprobar_minuscula:
    ; Comprobar si el carácter es una letra minúscula
    cmp al, 'a'
    jb no_cifrar
    cmp al, 'z'
    ja no_cifrar

    ; Cifrar letra minúscula
    add al, [shift]
    cmp al, 'z'
    jbe almacenar
    sub al, 26

almacenar:
    stosb ; Almacenar el carácter cifrado en la cadena cifrada
    loop cifrado ; Repetir para el siguiente carácter
    jmp cifrado

no_cifrar:
    stosb ; Almacenar el carácter sin cifrar
    loop cifrado ; Repetir para el siguiente carácter

fin_cifrado:
    ; Imprimir la cadena cifrada
    mov eax, 4
    mov ebx, 1
    mov ecx, encrypted
    mov edx, len
    int 0x80

    ; Imprimir nueva línea
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    ; Salir del programa
    mov eax, 1
    xor ebx, ebx
    int 0x80
