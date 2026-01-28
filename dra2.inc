DIBUJAR_BLOQUE MACRO x, y, ancho, alto, color
    LOCAL fila, columna
    push ax
    push bx
    push cx
    push dx
    push si
    push di

    mov si, 0
fila:
    mov dx, y
    add dx, si
    mov di, 0
columna:
    mov ah, 0Ch
    mov al, color
    mov bh, 0
    mov cx, x
    add cx, di
    int 10h

    inc di
    cmp di, ancho
    jl columna

    inc si
    cmp si, alto
    jl fila

    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
ENDM

DIBUJAR_LINEA_H MACRO x, y, ancho, color
    LOCAL columna
    push ax
    push bx
    push cx
    push dx
    push di

    mov dx, y
    mov di, 0
columna:
    mov ah, 0Ch
    mov al, color
    mov bh, 0
    mov cx, x
    add cx, di
    int 10h

    inc di
    cmp di, ancho
    jl columna

    pop di
    pop dx
    pop cx
    pop bx
    pop ax
ENDM

DIBUJAR_PELOTA MACRO x, y
    LOCAL fila_pelota, columna_pelota
    push ax
    push bx
    push cx
    push dx
    push si
    push di

    mov si, 0
fila_pelota:
    mov dx, y
    add dx, si
    sub dx, 2

    mov di, 0
columna_pelota:
    mov ah, 0Ch
    mov al, 15
    mov bh, 0
    mov cx, x
    add cx, di
    sub cx, 2
    int 10h

    inc di
    cmp di, 5
    jl columna_pelota

    inc si
    cmp si, 5
    jl fila_pelota

    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
ENDM

BORRAR_PELOTA MACRO x, y
    LOCAL fila_borrar, columna_borrar, safe_erase, check_bounds
    push ax
    push bx
    push cx
    push dx
    push si
    push di

    mov si, 0
fila_borrar:
    mov dx, y
    add dx, si
    sub dx, 2

    mov di, 0
columna_borrar:
    mov cx, x
    add cx, di
    sub cx, 2

check_bounds:
    cmp dx, 22
    jle safe_erase
    cmp dx, 178
    jge safe_erase
    cmp cx, 33
    jle safe_erase
    cmp cx, 286
    jge safe_erase
    cmp cx, 0
    jle safe_erase
    cmp cx, 319
    jge safe_erase
    cmp dx, 0
    jle safe_erase
    cmp dx, 199
    jge safe_erase

    mov ah, 0Ch
    mov al, 0
    mov bh, 0
    int 10h

safe_erase:
    inc di
    cmp di, 5
    jl columna_borrar

    inc si
    cmp si, 5
    jl fila_borrar

    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
ENDM

DIBUJAR_MARCO MACRO
    LOCAL marco_izq, marco_der
    push ax
    push bx
    push cx
    push dx

    DIBUJAR_LINEA_H 30, 20, 260, 15
    DIBUJAR_LINEA_H 30, 180, 260, 15

    mov cx, 30
    mov dx, 20
marco_izq:
    mov ah, 0Ch
    mov al, 15
    mov bh, 0
    int 10h
    inc dx
    cmp dx, 181
    jl marco_izq

    mov cx, 289
    mov dx, 20
marco_der:
    mov ah, 0Ch
    mov al, 15
    mov bh, 0
    int 10h
    inc dx
    cmp dx, 181
    jl marco_der

    pop dx
    pop cx
    pop bx
    pop ax
ENDM

FISICA_PELOTA MACRO velocidadX, velocidadY
    LOCAL no_collision_x, no_collision_y, check_right, check_bottom, skip_redraw
    push ax
    push bx
    push cx
    push dx

    BORRAR_PELOTA xPos, yPos

    mov ax, xPos
    add ax, velocidadX
    mov xPos, ax

    mov ax, yPos
    add ax, velocidadY
    mov yPos, ax

    mov ax, xPos
    cmp ax, 37
    jg check_right
    neg velocidadX
    mov xPos, 37
    jmp no_collision_x

check_right:
    cmp ax, 282
    jl no_collision_x
    neg velocidadX
    mov xPos, 282

no_collision_x:
    mov ax, yPos
    cmp ax, 27
    jg no_collision_y
    neg velocidadY
    mov yPos, 27

no_collision_y:
    DIBUJAR_PELOTA xPos, yPos

    pop dx
    pop cx
    pop bx
    pop ax
ENDM

PIXEL MACRO
    mov ah, 0Ch
    mov bh, 0
    int 10h
ENDM
