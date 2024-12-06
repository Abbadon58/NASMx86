# Programas en NASM para Arquitectura i386 (x86)

¡Bienvenido a este repositorio! Aquí encontrarás diversos programas escritos en **NASM** (Netwide Assembler) diseñados para ejecutarse en arquitecturas **i386 (x86)**. Estos programas son ideales para aprender ensamblador, explorar conceptos de bajo nivel y experimentar con el funcionamiento interno del hardware.

---

## 📋 Requisitos Previos

Antes de empezar, asegúrate de contar con los siguientes requisitos:

- **NASM**: Instalado en tu sistema para ensamblar los programas.  
  Puedes descargarlo desde [NASM Official](https://www.nasm.us/).
- **Emulador o entorno de ejecución**: Opcional, como QEMU o Bochs, para probar los binarios.
- **Sistema operativo Linux o Windows** con soporte para programas de 32 bits.

---

## 📂 Estructura del Repositorio a futuro:

```plaintext
├── README.md       # Información del proyecto
├── src/            # Código fuente en ensamblador NASM
│   ├── hola_mundo.asm    # Ejemplo básico: "Hola, Mundo"
│   ├── suma_enteros.asm  # Programa para sumar números enteros
│   ├── manejo_memoria.asm # Ejemplo de uso de memoria
│   └── interrupciones.asm # Uso de interrupciones en x86
├── bin/            # Binarios generados (.bin, .o, .elf)
└── docs/           # Documentación adicional
```

## 📋 como compilar los programas


git clone https://github.com/tu_usuario/nasm-i386-x86.git
cd nasm-i386-x86

Ensamblar un Archivo: Para ensamblar un programa, usa el comando:

nasm -f elf32 -o bin/programa.o src/programa.asm
Enlazar el Binario: En Linux, enlaza el archivo objeto para crear un ejecutable:


ld -m elf_i386 -o bin/programa bin/programa.o
Ejecutar: Ejecuta el programa desde la línea de comandos:

./bin/programa

Contribuciones
¡Las contribuciones son bienvenidas! Si tienes ideas para nuevos programas o mejoras, abre un issue o envía un pull request.

🛠 Herramientas Utilizadas
NASM: Ensamblador principal.
GDB: Depurador para análisis de programas.
QEMU/Bochs: Emuladores para pruebas.

