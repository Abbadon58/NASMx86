section .data
    menu_principal db 10,'=== Menu Principal ===',10
                   db '1. Operaciones Aritmeticas',10
                   db '2. Operaciones Binarias',10
                   db '3. Salir',10
                   db 'Seleccione una opcion: '
    len_menu_principal equ $ - menu_principal
    
    menu_aritmetico db 10,'=== Operaciones Aritmeticas ===',10
                    db '1. Suma',10
                    db '2. Resta',10
                    db '3. Multiplicacion',10
                    db '4. Division',10
                    db '5. Regresar',10
                    db 'Seleccione una opcion: '
    len_menu_aritmetico equ $ - menu_aritmetico

    menu_binario db 10,'=== Operaciones Binarias ===',10
                 db '1. AND',10
                 db '2. OR',10
                 db '3. XOR',10
                 db '4. Regresar',10
                 db 'Seleccione una opcion: '
    len_menu_binario equ $ - menu_binario

    msg_num1 db 10,'Ingrese 1er numero :  '
    msg_num2 db 10,'Ingrese 2do numero :  '
    msg_resultado db 10,'El resultado es : '
    nueva_linea db 10,10,0
    msg_error db 10,'Error: Division por cero',10,0

section .bss
    num1 resb 6      
    num2 resb 6      
    resultado resb 7  
    opcion resb 2
    numero1 resd 1   
    numero2 resd 1   
    buffer resb 6    

section .text
    global _start

%macro print_menu 2
    mov eax, 4
    mov ebx, 1
    mov ecx, %1
    mov edx, %2
    int 0x80
%endmacro
    
leer_entrada:
    push ebp
    mov ebp, esp
    mov edi, [ebp+8]   

    ; Completely clear the buffer with zeros
    mov edi, buffer
    mov ecx, 6
    mov al, 0
    rep stosb

    ; Leer entrada
    mov eax, 3         
    mov ebx, 0         
    mov ecx, buffer    
    mov edx, 6         
    int 0x80

    ; Eliminar salto de línea y asegurar terminación
    mov esi, buffer
    mov ecx, 6
.eliminar_nl:
    lodsb              
    cmp al, 10         
    je .encontro_nl
    cmp al, 0
    jne .continuar
    loop .eliminar_nl
    jmp .copiar

.encontro_nl:
    dec esi            
    mov byte [esi], 0  

.continuar:
    ; Verificar y limpiar caracteres no deseados
    mov esi, buffer
    mov ecx, 6
.limpiar_basura:
    lodsb
    cmp al, '0'
    jb .limpiar_caracter
    cmp al, '9'
    ja .limpiar_caracter
    loop .limpiar_basura
    jmp .copiar

.limpiar_caracter:
    mov byte [esi-1], 0

.copiar:
    ; Copiar al buffer destino
    mov esi, buffer
    mov edi, [ebp+8]
    mov ecx, 6
    rep movsb

    pop ebp
    ret

string_to_int:
    push ebp
    mov ebp, esp
    mov esi, [ebp+8]    
    xor eax, eax        
    xor ecx, ecx        

.next_digit:
    movzx edx, byte [esi+ecx]  
    test dl, dl               
    je .done
    cmp dl, 0xa              
    je .done
    sub dl, '0'              
    imul eax, 10             
    add eax, edx             
    inc ecx                  
    jmp .next_digit

.done:
    pop ebp
    ret

int_to_string:
    push ebp
    mov ebp, esp
    mov eax, [ebp+8]    
    mov edi, resultado  
    mov ecx, 5          
    mov byte [edi+6], 0 

.next_digit:
    xor edx, edx        
    mov ebx, 10         
    div ebx             
    add dl, '0'         
    mov [edi+ecx-1], dl 
    dec ecx             
    test eax, eax       
    jnz .next_digit

.fill_spaces:
    test ecx, ecx
    jz .done
    mov byte [edi+ecx-1], ' '  
    dec ecx
    jmp .fill_spaces

.done:
    mov eax, edi        
    pop ebp
    ret

_start:
    menu_ppal:
        print_menu menu_principal, len_menu_principal
        mov eax, 3
        mov ebx, 0
        mov ecx, opcion
        mov edx, 2
        int 0x80

        mov al, [opcion]
        cmp al, '1'
        je menu_arit
        cmp al, '2'
        je menu_bin
        cmp al, '3'
        je salir
        jmp menu_ppal

    menu_arit:
        print_menu menu_aritmetico, len_menu_aritmetico
        mov eax, 3
        mov ebx, 0
        mov ecx, opcion
        mov edx, 2
        int 0x80

        mov al, [opcion]
        cmp al, '1'
        je suma
        cmp al, '2'
        je resta
        cmp al, '3'
        je multiplicar
        cmp al, '4'
        je dividir
        cmp al, '5'
        je menu_ppal
        jmp menu_arit

    menu_bin:
        print_menu menu_binario, len_menu_binario
        mov eax, 3
        mov ebx, 0
        mov ecx, opcion
        mov edx, 2
        int 0x80

        mov al, [opcion]
        cmp al, '1'
        je operacion_and
        cmp al, '2'
        je operacion_or
        cmp al, '3'
        je operacion_xor
        cmp al, '4'
        je menu_ppal
        jmp menu_bin

suma:
    print_menu msg_num1, 21
    push num1
    call leer_entrada

    print_menu msg_num2, 21
    push num2
    call leer_entrada

    push num1
    call string_to_int
    mov [numero1], eax

    push num2
    call string_to_int
    mov [numero2], eax

    mov eax, [numero1]
    add eax, [numero2]

    push eax
    call int_to_string

    print_menu msg_resultado, 18
    print_menu resultado, 6
    print_menu nueva_linea, 2
    jmp menu_arit

resta:
    print_menu msg_num1, 21
    push num1
    call leer_entrada

    print_menu msg_num2, 21
    push num2
    call leer_entrada

    push num1
    call string_to_int
    mov [numero1], eax

    push num2
    call string_to_int
    mov [numero2], eax

    mov eax, [numero1]
    sub eax, [numero2]

    push eax
    call int_to_string

    print_menu msg_resultado, 16
    print_menu resultado, 6
    print_menu nueva_linea, 2
    jmp menu_arit

multiplicar:
    print_menu msg_num1, 21
    push num1
    call leer_entrada

    print_menu msg_num2, 21
    push num2
    call leer_entrada

    push num1
    call string_to_int
    mov [numero1], eax

    push num2
    call string_to_int
    mov [numero2], eax

    mov eax, [numero1]
    mov ebx, [numero2]
    mul ebx

    push eax
    call int_to_string

    print_menu msg_resultado, 18
    print_menu resultado, 6
    print_menu nueva_linea, 2
    jmp menu_arit

dividir:
    print_menu msg_num1, 21
    push num1
    call leer_entrada

    print_menu msg_num2, 21
    push num2
    call leer_entrada
    push num1
    call string_to_int
    mov [numero1], eax

    push num2
    call string_to_int
    mov [numero2], eax

    ; Verificar división por cero
    mov ebx, [numero2]
    test ebx, ebx
    jz error_division

    mov eax, [numero1]
    xor edx, edx
    div ebx

    push eax
    call int_to_string

    print_menu msg_resultado, 18
    print_menu resultado, 6
    print_menu nueva_linea, 2
    jmp menu_arit

error_division:
    print_menu msg_error, 24
    jmp menu_arit

operacion_and:
    print_menu msg_num1, 21
    push num1
    call leer_entrada

    print_menu msg_num2, 21
    push num2
    call leer_entrada

    push num1
    call string_to_int
    mov [numero1], eax

    push num2
    call string_to_int
    mov [numero2], eax

    mov eax, [numero1]
    and eax, [numero2]

    push eax
    call int_to_string

    print_menu msg_resultado, 18
    print_menu resultado, 6
    print_menu nueva_linea, 2
    jmp menu_bin

operacion_or:
    print_menu msg_num1, 21
    push num1
    call leer_entrada

    print_menu msg_num2, 21
    push num2
    call leer_entrada

    push num1
    call string_to_int
    mov [numero1], eax

    push num2
    call string_to_int
    mov [numero2], eax

    mov eax, [numero1]
    or eax, [numero2]

    push eax
    call int_to_string

    print_menu msg_resultado, 18
    print_menu resultado, 6
    print_menu nueva_linea, 2
    jmp menu_bin

operacion_xor:
    print_menu msg_num1, 21
    push num1
    call leer_entrada

    print_menu msg_num2, 21
    push num2
    call leer_entrada

    push num1
    call string_to_int
    mov [numero1], eax

    push num2
    call string_to_int
    mov [numero2], eax

    mov eax, [numero1]
    or eax, [numero2]

    push eax
    call int_to_string

    print_menu msg_resultado, 18
    print_menu resultado, 6
    print_menu nueva_linea, 2
    jmp menu_bin

salir:
    mov eax, 1
    xor ebx, ebx
    int 0x80
