bits 16

org 0x7C00

start:
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00

    mov ax, 0xAA55
    cmp word [0x7DFE], ax
    jne boot_error

    mov bx, 0x8000
    mov dh, 0x00
    mov dl, 0x80
    mov ch, 0x00
    mov cl, 0x02

    call read_sector

    cmp word [0x8000], 0xAA55
    jne kernel_error

    jmp 0x0000:0x8000

boot_error:
    mov si, error_hard_disk_error
    call print_string
    jmp hang

kernel_error:
    mov si, error_kernel_load
    call print_string
    jmp hang

read_sector:
    push ax
    push bx
    push cx
    push dx

    mov ah, 0x02
    mov al, 0x01
    int 0x13

    jc read_error

    pop dx
    pop cx
    pop bx
    pop ax
    ret

read_error:
    pop dx
    pop cx
    pop bx
    pop ax
    mov si, error_disk_read_error
    call print_string
    jmp hang

print_string:
    mov ah, 0x0E
.next_char:
    lodsb
    cmp al, 0
    je .done
    int 0x10
    jmp .next_char
.done:
    ret

hang:
    jmp hang

error_hard_disk_error db "HDD Err", 0
error_floppy_error db "Flpy Err", 0
error_read_error db "Read Err", 0
error_geom_error db "Geom Err", 0
error_kernel_load db "Kern Load Err", 0
error_selected_item_wont_fit db "Item mem err", 0
error_selected_disk_doesnt_exist db "Disk exist err", 0
error_disk_read_error db "Disk read err", 0
error_disk_write_error db "Disk write err", 0
error_disk_geometry_error db "Disk geom err", 0
error_attempt_to_access_block_outside_partition db "Part err", 0
error_no_such_partition db "No part err", 0
error_bad_filename db "Bad fname err", 0
error_bad_file_or_directory_type db "Bad file/dir err", 0
error_file_not_found db "File not found", 0
error_inconsistent_filesystem_structure db "FS struct err", 0
error_filesystem_compatibility_error db "FS comp err", 0
error_error_while_parsing_number db "Parse num err", 0
error_device_string_unrecognizable db "Dev str err", 0
error_invalid_device_requested db "Inv dev req", 0
error_loading_below_1MB_not_supported db "Load <1MB err", 0
error_unsupported_multiboot_features_requested db "MB feat err", 0
error_unknown_boot_failure db "Boot fail", 0
error_must_load_multiboot_kernel_before_modules db "MB kern first", 0
error_must_load_linux_kernel_before_initrd db "Lin kern first", 0
error_cannot_boot_without_kernel_loaded db "No kern boot", 0
error_unrecognized_command db "Cmd err", 0
error_bad_incompatible_header_on_compressed_file db "Hdr comp err", 0
error_bad_corrupt_data_while_decompressing_file db "Decomp err", 0
error_bad_corrupt_version_of_stage1_stage2 db "Stage err", 0

times 510-($-$$) db 0
dw 0xAA55
