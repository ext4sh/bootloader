# Simple Bootloader

This repository contains a simple bootloader written in assembly language for the x86 architecture. The bootloader performs basic hardware checks and loads the kernel from the disk.

## Features

- Sets up the segment registers and stack.
- Checks for a valid boot signature.
- Reads a sector from the disk.
- Jumps to the loaded kernel.
- Displays error messages for various boot failures.

### Bootloader

The bootloader is written in 16-bit assembly language and is designed to be loaded and executed from the MBR (Master Boot Record) of a disk.

### Instructions

1. **Initialization**: The segment registers and stack pointer are initialized.
2. **Boot Signature Check**: The bootloader checks for the signature `0xAA55` at the end of the MBR.
3. **Reading the Kernel**: The bootloader reads the first sector of the kernel into memory at address `0x8000`.
4. **Kernel Check**: It verifies that the kernel sector contains the same `0xAA55` signature.
5. **Jump to Kernel**: The bootloader jumps to the loaded kernel.

### Error Handling

If any of the checks fail, the bootloader prints an error message and halts.

### Error Messages

The bootloader includes several predefined error messages for various failure conditions:

- `HDD Err`: Hard disk error
- `Flpy Err`: Floppy disk error
- `Read Err`: Read error
- `Geom Err`: Geometry error
- `Kern Load Err`: Kernel load error
- `Disk read err`: Disk read error

### Building

```
$ nasm -f bin -o bootloader.bin bootloader.asm
```

### Running

```
$ qemu-system-x86_64 -drive format=raw,file=bootloader.bin
```
