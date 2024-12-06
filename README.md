# calculadora-NASM
Calculadora NASM i386 x86
# Crear el contenido del archivo README
readme_content = """
# Super Calculadora en Ensamblador

Este proyecto implementa una calculadora interactiva utilizando lenguaje ensamblador. La calculadora incluye un menú principal para realizar operaciones aritméticas y binarias.

## Funcionalidades

### Menú Principal
1. **Operaciones Aritméticas**
   - Suma
   - Resta
   - Multiplicación
   - División
2. **Operaciones Binarias**
   - AND
   - OR
   - XOR
3. **Salir**

### Menú Aritmético
Permite realizar cálculos básicos seleccionando una de las operaciones disponibles.

### Menú Binario
Permite realizar operaciones binarias entre dos números utilizando operadores lógicos como AND y OR.

## Requisitos
- Un ensamblador compatible (NASM recomendado).
- Un entorno de ejecución para programas ensamblados (por ejemplo, DOSBox o un sistema Linux con soporte para ensamblador).

## Cómo Compilar y Ejecutar
1. Asegúrese de tener NASM instalado en su sistema.
2. Compile el archivo fuente:
   ```bash
   comando para compilarlo:
   ld -m elf_i386 super_calculadora.o -o super_calculadora
   ./super_calculadora

Este programa está diseñado para sistemas de 32 bits. Para sistemas de 64 bits, puede ser necesario configurar un entorno de compatibilidad.
Asegúrese de proporcionar números válidos como entrada para evitar resultados inesperados.
Autor
abbadon58 - Desarrollador del proyecto.

