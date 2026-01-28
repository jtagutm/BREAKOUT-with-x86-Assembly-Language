.MODEL SMALL
.STACK 100h
.DATA
COLOR     DB 14
xPos      DW 160
yPos      DW 100
ancho     DW 30
alto      DW 20
paletaX   DW 115
paletaY   DW 175
paletaAncho DW 40
velX      DW 1
velY      DW -1
contador  DW 0
bloques   DB 28 DUP(1)
bloques_restantes DW 28
puntaje   DW 0
vidas     DW 3d
msg_vidas DB 'VIDAS: $'
msg_puntaje DB 'PUNTAJE: $'
msg_victoria DB 'FELICITACIONES! GANASTE!$'
msg_game_over DB 'GAME OVER!$'
msg_nivel DB 'NIVEL: $'
msg_reintentar DB 'R - REINTENTAR$'
msg_menu DB 'M - MENU PRINCIPAL$'
msg_salir DB '$'
msg_elige DB 'Elige una opcion: $'
titulo1   DB ' ____  ____  _____    _    _  _____  _   _ _____ $'
titulo2   DB '| __ )|  _ \| ____|  / \  | |/ / _ \| | | |_   _|$'
titulo3   DB '|  _ \| |_) |  _|   / _ \ | . / | | | | | | | |  $'
titulo4   DB '| |_) |  _ <| |___ / ___ \| |\  |_| | |_| | | |  $'
titulo5   DB '|____/|_| \_\_____/_/   \_\_|\_\___/ \___/  |_|  $'
titulo6   DB '                                               $'
titulo7   DB '                                               $'
subtitulo DB '         *** JUEGO CLASICO DE BLOQUES ***    $'
bienvenida1 DB '      Destruye todos los bloques para ganar!    $'
bienvenida2 DB '                                                $'
instrucciones1 DB '             === COMO JUGAR ===              $'
instrucciones2 DB '                                             $'
instrucciones3 DB '   A / FLECHA IZQ  -  Mover paleta izquierda $'
instrucciones4 DB '   D / FLECHA DER  -  Mover paleta derecha   $'
instrucciones5 DB '   ESC             -  Salir del juego        $'
instrucciones6 DB '                                             $'
creditos1 DB '                  $'
creditos2 DB '                                               $'
inicio_msg DB '      Presiona ENTER para comenzar a jugar     $'
decoracion1 DB '===============================================$'
decoracion2 DB '-----------------------------------------------$'
nombre_archivo DB 'records.txt', 0
handle_archivo DW ?
buffer_escritura DB 50 DUP(0)
buffer_lectura DB 200 DUP(0)
nombre_jugador DB 20 DUP(0)
msg_nombre DB '    Ingresa tu nombre: $'
msg_nuevo_record DB ' '
puntaje_maximo DW 0
msg_records DB '   V- RECORDS$'
msg_volver DB '   ESC - VOLVER AL MENU$'
msg_no_records DB 'No hay records guardados$'
records_buffer DB 1000 DUP(0)  
nivel_actual DW 1
contador_records    dw 0
puntaje_minimo      dw 0
pos_record_minimo   dw 0
include dra2.inc
.CODE
INICIO:
    mov ax, @data
    mov ds, ax
    call CARGAR_RECORD_ACTUAL   
menu_principal:   
    call MOSTRAR_PORTADA
    call ESPERAR_TECLA_MENU    
    cmp al, 1       
    je continuar_juego
    cmp al, 2       
    je mostrar_records_menu
    cmp al, 3       
    je salir_programa
    jmp menu_principal   
mostrar_records_menu:
    call MOSTRAR_PANTALLA_RECORDS
    jmp menu_principal     
continuar_juego:
    call REINICIAR_VARIABLES_JUEGO   
    mov ah, 0
    mov al, 13h
    int 10h   
    call DIBUJAR_ESCENA
    call MOSTRAR_VIDAS
    call MOSTRAR_PUNTAJE
    jmp BUCLE_JUEGO         
salir_programa:
    jmp FIN_JUEGO
BUCLE_JUEGO:
    call ACTUALIZAR_FISICA
    call PROCESAR_INPUT
    call VERIFICAR_REGENERACION
    mov cx, 5000
pausa_juego:
    loop pausa_juego    
    jmp BUCLE_JUEGO    
MOSTRAR_PORTADA PROC
    push ax
    push bx
    push cx
    push dx    
    mov ah, 0
    mov al, 03h     
    int 10h
    mov ah, 06h     
    mov al, 0      
    mov bh, 0Fh     
    mov cx, 0      
    mov dx, 184Fh  
    int 10h
    mov ah, 02h
    mov bh, 0
    mov dh, 2      
    mov dl, 15     
    int 10h
    mov ah, 09h
    mov dx, OFFSET titulo1
    int 21h    
    mov ah, 02h
    mov bh, 0
    mov dh, 3
    mov dl, 15
    int 10h
    mov ah, 09h
    mov dx, OFFSET titulo2
    int 21h
    mov ah, 02h
    mov bh, 0
    mov dh, 4
    mov dl, 15
    int 10h
    mov ah, 09h
    mov dx, OFFSET titulo3
    int 21h
    mov ah, 02h
    mov bh, 0
    mov dh, 5
    mov dl, 15
    int 10h
    mov ah, 09h
    mov dx, OFFSET titulo4
    int 21h
    mov ah, 02h
    mov bh, 0
    mov dh, 6
    mov dl, 15
    int 10h
    mov ah, 09h
    mov dx, OFFSET titulo5
    int 21h
    mov ah, 02h
    mov bh, 0
    mov dh, 8
    mov dl, 12
    int 10h
    mov ah, 09h
    mov dx, OFFSET subtitulo
    int 21h
    mov ah, 02h
    mov bh, 0
    mov dh, 9
    mov dl, 12
    int 10h
    mov ah, 09h
    mov dx, OFFSET decoracion2
    int 21h
    mov ah, 02h
    mov bh, 0
    mov dh, 10
    mov dl, 10
    int 10h
    mov ah, 09h
    mov dx, OFFSET bienvenida1
    int 21h
    mov ah, 02h
    mov bh, 0
    mov dh, 12
    mov dl, 15
    int 10h
    mov ah, 09h
    mov dx, OFFSET instrucciones1
    int 21h
    mov ah, 02h
    mov bh, 0
    mov dh, 14
    mov dl, 8
    int 10h
    mov ah, 09h
    mov dx, OFFSET instrucciones3
    int 21h
    mov ah, 02h
    mov bh, 0
    mov dh, 15
    mov dl, 8
    int 10h
    mov ah, 09h
    mov dx, OFFSET instrucciones4
    int 21h
    mov ah, 02h
    mov bh, 0
    mov dh, 17      
    mov dl, 8
    int 10h
    mov ah, 09h
    mov dx, OFFSET msg_records
    int 21h
    mov ah, 02h
    mov bh, 0
    mov dh, 16
    mov dl, 8
    int 10h
    mov ah, 09h
    mov dx, OFFSET instrucciones5
    int 21h
    mov ah, 02h
    mov bh, 0
    mov dh, 18
    mov dl, 13
    int 10h
    mov ah, 09h
    mov dx, OFFSET creditos1
    int 21h
    mov ah, 02h
    mov bh, 0
    mov dh, 20
    mov dl, 12
    int 10h
    mov ah, 09h
    mov dx, OFFSET decoracion1
    int 21h
    mov ah, 02h
    mov bh, 0
    mov dh, 22
    mov dl, 10
    int 10h
    mov ah, 09h
    mov dx, OFFSET inicio_msg
    int 21h
    pop dx
    pop cx
    pop bx
    pop ax
    ret
MOSTRAR_PORTADA ENDP
ESPERAR_TECLA_MENU PROC
esperar_tecla_menu:
    mov ah, 00h     
    int 16h         
    cmp al, 13      
    je iniciar_juego
    cmp al, 'v'     
    je ver_records
    cmp al, 'V'     
    je ver_records
    cmp al, 27      
    je salir_desde_menu
    jmp esperar_tecla_menu   
iniciar_juego:
    mov al, 1      
    ret             
ver_records:
    mov al, 2       
    ret             
salir_desde_menu:
    mov al, 3      
    ret             
ESPERAR_TECLA_MENU ENDP
PEDIR_NOMBRE_JUGADOR PROC
    push ax
    push bx
    push cx
    push dx
    push si
    

    mov si, 0
    mov cx, 20
limpiar_nombre:
    mov BYTE PTR [nombre_jugador + si], 0
    inc si
    loop limpiar_nombre
    

    mov ah, 02h
    mov bh, 0
    mov dh, 12      
    mov dl, 5       
    int 10h
    

    mov ah, 09h
    mov dx, OFFSET msg_nombre
    int 21h
    
    mov si, 0
leer_char:
    mov ah, 00h         
    int 16h
    
    cmp al, 13          
    je fin_nombre
    cmp al, 8           
    je borrar_char
    cmp si, 15          
    jge leer_char
    cmp al, 32
    jl leer_char
    cmp al, 126
    jg leer_char
    

    mov [nombre_jugador + si], al
    inc si
    

    mov ah, 02h
    mov dl, al
    int 21h
    jmp leer_char

borrar_char:
    cmp si, 0
    je leer_char        
    dec si
    mov BYTE PTR [nombre_jugador + si], 0
    
    mov ah, 02h
    mov dl, 8          
    int 21h
    mov dl, ' '        
    int 21h
    mov dl, 8           
    int 21h
    jmp leer_char

fin_nombre:
    cmp si, 0
    jne nombre_valido
    
    mov BYTE PTR [nombre_jugador], 'J'
    mov BYTE PTR [nombre_jugador + 1], 'U'
    mov BYTE PTR [nombre_jugador + 2], 'G'
    mov BYTE PTR [nombre_jugador + 3], 'A'
    mov BYTE PTR [nombre_jugador + 4], 'D'
    mov BYTE PTR [nombre_jugador + 5], 'O'
    mov BYTE PTR [nombre_jugador + 6], 'R'
    mov BYTE PTR [nombre_jugador + 7], 0
    jmp fin_pedir_nombre

nombre_valido:
    mov BYTE PTR [nombre_jugador + si], 0

fin_pedir_nombre:
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
PEDIR_NOMBRE_JUGADOR ENDP
CARGAR_RECORD_ACTUAL PROC
    push ax
    push bx
    push cx
    push dx
    push si
    mov ah, 3Dh         
    mov al, 0           
    mov dx, OFFSET nombre_archivo
    int 21h
    jc archivo_no_existe 
    mov handle_archivo, ax
    mov ah, 3Fh         
    mov bx, handle_archivo
    mov cx, 200        
    mov dx, OFFSET buffer_lectura
    int 21h
    mov ah, 3Eh
    mov bx, handle_archivo
    int 21h
    call EXTRAER_PUNTAJE_DE_BUFFER
    jmp fin_cargar_record
archivo_no_existe:
    mov puntaje_maximo, 0
fin_cargar_record:
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
CARGAR_RECORD_ACTUAL ENDP
EXTRAER_PUNTAJE_DE_BUFFER PROC
    push ax
    push bx
    push cx
    push dx
    push si
    mov si, 0
    mov ax, 0
    mov cx, 10
    mov dx, 0      
buscar_siguiente_numero:
    mov bl, [buffer_lectura + si]
    cmp bl, 0     
    je fin_busqueda
    cmp bl, '0'
    jl siguiente_caracter
    cmp bl, '9'
    jg siguiente_caracter
    mov ax, 0
extraer_numero:
    mov bl, [buffer_lectura + si]
    cmp bl, '0'
    jl fin_numero
    cmp bl, '9'
    jg fin_numero
    sub bl, '0'
    mul cx             
    add al, bl          
    inc si
    cmp si, 200         
    jl extraer_numero
fin_numero:
    cmp ax, dx
    jle siguiente_caracter
    mov dx, ax            
siguiente_caracter:
    inc si
    cmp si, 200
    jl buscar_siguiente_numero   
fin_busqueda:
    mov puntaje_maximo, dx   
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
EXTRAER_PUNTAJE_DE_BUFFER ENDP
PREPARAR_BUFFER_ESCRITURA PROC
    push ax
    push bx
    push cx
    push dx
    push si
    push di
    mov si, 0
    mov cx, 50
limpiar_buffer:
    mov BYTE PTR [buffer_escritura + si], 0
    inc si
    loop limpiar_buffer
    mov ax, puntaje
    call CONVERTIR_NUMERO_A_STRING_FIJO
    mov si, 5
    mov BYTE PTR [buffer_escritura + si], ' '
    inc si
    mov BYTE PTR [buffer_escritura + si], '-'
    inc si
    mov BYTE PTR [buffer_escritura + si], ' '
    inc si
    mov di, 0
agregar_nombre:
    mov bl, [nombre_jugador + di]
    cmp bl, 0
    je fin_buffer
    mov [buffer_escritura + si], bl
    inc si
    inc di
    cmp di, 15      
    jl agregar_nombre    
fin_buffer:    
    mov BYTE PTR [buffer_escritura + si], 0   
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
PREPARAR_BUFFER_ESCRITURA ENDP
CONVERTIR_NUMERO_A_STRING_FIJO PROC
    push ax
    push bx
    push cx
    push dx
    push si
    mov si, 0
    mov cx, 5
llenar_ceros:
    mov BYTE PTR [buffer_escritura + si], '0'
    inc si
    loop llenar_ceros
    mov ax, puntaje
    mov bx, 10
    mov si, 4           
convertir_loop:
    cmp ax, 0
    je fin_conversion
    cmp si, 0          
    jl fin_conversion
    mov dx, 0
    div bx             
    add dl, '0'         ; Convertir residuo a ASCII
    mov [buffer_escritura + si], dl
    dec si
    jmp convertir_loop    
fin_conversion:
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
CONVERTIR_NUMERO_A_STRING_FIJO ENDP
CONVERTIR_NUMERO_A_STRING PROC
    push ax
    push bx
    push cx
    push dx
    push si
    mov bx, 10
    mov cx, 0
    mov si, 4         
    cmp ax, 0
    jne convertir_loop2
    mov BYTE PTR [buffer_escritura], '0'
    jmp fin_conversion2
convertir_loop2:
    cmp ax, 0
    je fin_conversion2
    mov dx, 0
    div bx              ; AX = cociente, DX = residuo
    add dl, '0'         ; Convertir a ASCII
    mov [buffer_escritura + si], dl
    dec si
    jmp convertir_loop2
fin_conversion2:
    cmp si, 0
    jl fin_rellenar
rellenar_espacios:
    mov BYTE PTR [buffer_escritura + si], '0'
    dec si
    cmp si, 0
    jge rellenar_espacios
fin_rellenar:
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
CONVERTIR_NUMERO_A_STRING ENDP
MOSTRAR_PANTALLA_RECORDS PROC
    push ax
    push bx
    push cx
    push dx
    mov ah, 0
    mov al, 03h
    int 10h
    mov ah, 06h     
    mov al, 0       
    mov bh, 0Fh     
    mov cx, 0       
    mov dx, 184Fh   
    int 10h
    mov ah, 02h
    mov bh, 0
    mov dh, 2
    mov dl, 30
    int 10h
    mov ah, 02h
    mov dl, '='
    int 21h
    mov dl, '='
    int 21h
    mov dl, '='
    int 21h
    mov dl, ' '
    int 21h
    mov dl, 'R'
    int 21h
    mov dl, 'E'
    int 21h
    mov dl, 'C'
    int 21h
    mov dl, 'O'
    int 21h
    mov dl, 'R'
    int 21h
    mov dl, 'D'
    int 21h
    mov dl, 'S'
    int 21h
    mov dl, ' '
    int 21h
    mov dl, '='
    int 21h
    mov dl, '='
    int 21h
    mov dl, '='
    int 21h
    mov ah, 02h
    mov bh, 0
    mov dh, 3
    mov dl, 15
    int 10h
    mov ah, 09h
    mov dx, OFFSET decoracion2
    int 21h
    call CARGAR_Y_MOSTRAR_TODOS_RECORDS
    mov ah, 02h
    mov bh, 0
    mov dh, 20
    mov dl, 15
    int 10h    
    mov ah, 09h
    mov dx, OFFSET decoracion2
    int 21h
    mov ah, 02h
    mov bh, 0
    mov dh, 22
    mov dl, 25
    int 10h   
    mov ah, 09h
    mov dx, OFFSET msg_volver
    int 21h
    mov ah, 02h
    mov bh, 0
    mov dh, 23
    mov dl, 25
    int 10h    
    mov ah, 09h
    mov dx, OFFSET msg_salir
    int 21h
esperar_volver:
    mov ah, 00h
    int 16h
    cmp al, 'v'
    je fin_records
    cmp al, 'V'
    je fin_records
    cmp al, 27      ; ESC
    je fin_records
    cmp al, 13      ; Enter tambi?n deber?a funcionar
    je fin_records
    jmp esperar_volver   
fin_records:
    pop dx
    pop cx
    pop bx
    pop ax
    ret
MOSTRAR_PANTALLA_RECORDS ENDP
CARGAR_Y_MOSTRAR_TODOS_RECORDS PROC
    push ax
    push bx
    push cx
    push dx
    push si
    mov ah, 3Dh
    mov al, 0
    mov dx, OFFSET nombre_archivo
    int 21h
    jc no_hay_records    
    mov handle_archivo, ax
    mov ah, 3Fh
    mov bx, handle_archivo
    mov cx, 1000
    mov dx, OFFSET records_buffer
    int 21h
    mov ah, 3Eh
    mov bx, handle_archivo
    int 21h
    call MOSTRAR_RECORDS_FORMATEADO
    jmp fin_cargar_records   
no_hay_records:
    mov ah, 02h
    mov bh, 0
    mov dh, 10
    mov dl, 25
    int 10h    
    mov ah, 09h
    mov dx, OFFSET msg_no_records
    int 21h   
fin_cargar_records:
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
CARGAR_Y_MOSTRAR_TODOS_RECORDS ENDP
MOSTRAR_RECORDS_FORMATEADO PROC
    push ax
    push bx
    push cx
    push dx
    push si   
    mov si, 0
    mov dh, 6     ; Fila inicial
    mov cx, 1     ; Contador de l?neas mostradas    
mostrar_linea_record:
    cmp BYTE PTR [records_buffer + si], 0
    je fin_mostrar_records
    cmp cx, 13
    jge fin_mostrar_records
    mov ah, 02h
    mov bh, 0
    mov dl, 10    ; Columna 10
    int 10h
    push cx
    mov ax, cx
    add al, '0'
    cmp al, '9'
    jle mostrar_numero_simple
    mov ah, 02h
    mov dl, '1'
    int 21h
    sub al, 10
    add al, '0'
mostrar_numero_simple:
    mov ah, 02h
    mov dl, al
    int 21h
    mov dl, '.'
    int 21h
    mov dl, ' '
    int 21h
    pop cx
mostrar_char_record:
    mov al, [records_buffer + si]
    cmp al, 0
    je fin_mostrar_records
    cmp al, 13    ; Carriage return
    je siguiente_linea
    cmp al, 10    ; Line feed
    je siguiente_linea
    mov ah, 02h
    mov dl, al
    int 21h    
    inc si
    jmp mostrar_char_record   
siguiente_linea:
    inc si
    cmp BYTE PTR [records_buffer + si], 10
    jne no_lf
    inc si
no_lf:
    inc dh        ; Siguiente fila
    inc cx        ; Incrementar contador de l?neas
    jmp mostrar_linea_record    
fin_mostrar_records:
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
MOSTRAR_RECORDS_FORMATEADO ENDP
GUARDAR_NUEVO_RECORD PROC
    push ax
    push bx
    push cx
    push dx
    push si
    push di
    
    ; Primero cargar records existentes y contar cu?ntos hay
    call CONTAR_RECORDS_EXISTENTES
    
    ; Si hay 15 o m?s records, necesitamos reorganizar
    cmp contador_records, 15
    jge reorganizar_records
    jmp agregar_record_normal

reorganizar_records:
    ; Cargar todos los records existentes
    call CARGAR_TODOS_RECORDS
    ; Encontrar el puntaje m?s bajo y reemplazarlo si el nuevo es mayor
    call REEMPLAZAR_RECORD_MINIMO
    jmp fin_guardar_record

agregar_record_normal:
    ; Preparar el buffer de escritura con el nuevo record
    call PREPARAR_BUFFER_ESCRITURA
    
    ; Abrir archivo para agregar al final
    mov ah, 3Dh         ; Funci?n abrir archivo
    mov al, 1           ; Modo escritura
    mov dx, OFFSET nombre_archivo
    int 21h
    jc crear_archivo_nuevo
    
    mov handle_archivo, ax
    
    ; Ir al final del archivo
    mov ah, 42h         ; Lseek
    mov al, 2           ; Desde el final del archivo
    mov bx, handle_archivo
    mov cx, 0
    mov dx, 0
    int 21h
    jmp escribir_record

crear_archivo_nuevo:
    ; Crear nuevo archivo
    mov ah, 3Ch         ; Funci?n crear archivo
    mov cx, 0           ; Atributos normales
    mov dx, OFFSET nombre_archivo
    int 21h
    jc error_crear_archivo
    mov handle_archivo, ax

escribir_record:
    ; Escribir el nuevo record
    call ESCRIBIR_BUFFER_AL_ARCHIVO
    jmp cerrar_archivo_guardar

error_crear_archivo:
    jmp fin_guardar_record

cerrar_archivo_guardar:
    mov ah, 3Eh
    mov bx, handle_archivo
    int 21h

fin_guardar_record:
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
GUARDAR_NUEVO_RECORD ENDP
CONTAR_RECORDS_EXISTENTES PROC
    push ax
    push bx
    push cx
    push dx
    push si
    
    mov contador_records, 0
    
    ; Intentar abrir el archivo
    mov ah, 3Dh
    mov al, 0           ; Solo lectura
    mov dx, OFFSET nombre_archivo
    int 21h
    jc no_archivo_contar
    
    mov handle_archivo, ax
    
    ; Leer el archivo completo
    mov ah, 3Fh
    mov bx, handle_archivo
    mov cx, 1000
    mov dx, OFFSET records_buffer
    int 21h
    
    ; Cerrar archivo
    mov ah, 3Eh
    mov bx, handle_archivo
    int 21h
    
    ; Contar l?neas (cada l?nea es un record)
    mov si, 0
    mov cx, 0           ; Contador de l?neas
    
contar_lineas_loop:
    cmp BYTE PTR [records_buffer + si], 0
    je fin_contar
    cmp BYTE PTR [records_buffer + si], 10  ; Line Feed
    je incrementar_contador
    cmp BYTE PTR [records_buffer + si], 13  ; Carriage Return
    je verificar_lf
    inc si
    jmp contar_lineas_loop

verificar_lf:
    inc si
    cmp BYTE PTR [records_buffer + si], 10
    jne contar_lineas_loop
    ; Es CRLF, incrementar contador
    
incrementar_contador:
    inc cx
    inc si
    jmp contar_lineas_loop

fin_contar:
    mov contador_records, cx
    jmp fin_contar_records

no_archivo_contar:
    mov contador_records, 0

fin_contar_records:
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
CONTAR_RECORDS_EXISTENTES ENDP
CARGAR_TODOS_RECORDS PROC
    push ax
    push bx
    push cx
    push dx
    
    ; Limpiar buffer
    mov ax, 0
    mov cx, 500
    mov bx, OFFSET records_buffer
    
limpiar_records_buffer:
    mov [bx], al
    inc bx
    loop limpiar_records_buffer
    
    ; Abrir archivo
    mov ah, 3Dh
    mov al, 0
    mov dx, OFFSET nombre_archivo
    int 21h
    jc error_cargar_todos
    
    mov handle_archivo, ax
    
    ; Leer archivo completo
    mov ah, 3Fh
    mov bx, handle_archivo
    mov cx, 1000
    mov dx, OFFSET records_buffer
    int 21h
    
    ; Cerrar archivo
    mov ah, 3Eh
    mov bx, handle_archivo
    int 21h

error_cargar_todos:
    pop dx
    pop cx
    pop bx
    pop ax
    ret
    CARGAR_TODOS_RECORDS ENDP
REEMPLAZAR_RECORD_MINIMO PROC
    push ax
    push bx
    push cx
    push dx
    push si
    push di
    
    ; Encontrar el puntaje m?nimo en los records existentes
    call ENCONTRAR_PUNTAJE_MINIMO
    
    ; Comparar con el puntaje actual
    mov ax, puntaje
    cmp ax, bx          ; BX contiene el puntaje m?nimo
    jle no_reemplazar   ; Si el nuevo puntaje no es mayor, no reemplazar
    
    ; Reescribir todo el archivo sin el record m?nimo y agregando el nuevo
    call REESCRIBIR_ARCHIVO_RECORDS

no_reemplazar:
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
REEMPLAZAR_RECORD_MINIMO ENDP
ENCONTRAR_PUNTAJE_MINIMO PROC
    push ax
    push cx
    push dx
    push si
    
    mov si, 0
    mov bx, 65535       ; Valor m?ximo para empezar la comparaci?n
    mov dx, 0           ; Posici?n del record con puntaje m?nimo
    
buscar_minimo_loop:
    cmp BYTE PTR [records_buffer + si], 0
    je fin_buscar_minimo
    
    ; Extraer n?mero de la l?nea actual
    call EXTRAER_NUMERO_EN_POSICION
    
    ; Comparar con el m?nimo actual
    cmp ax, bx
    jge siguiente_linea_minimo
    mov bx, ax          ; Nuevo m?nimo
    mov dx, si          ; Guardar posici?n

siguiente_linea_minimo:
    ; Avanzar a la siguiente l?nea
    call AVANZAR_A_SIGUIENTE_LINEA
    jmp buscar_minimo_loop

fin_buscar_minimo:
    ; BX contiene el puntaje m?nimo
    ; DX contiene la posici?n del record m?nimo
    
    pop si
    pop dx  
    pop cx
    pop ax
    ret
ENCONTRAR_PUNTAJE_MINIMO ENDP
EXTRAER_NUMERO_EN_POSICION PROC
    push bx
    push cx
    push dx
    push di
    
    mov ax, 0
    mov cx, 10
    mov di, si
    
extraer_digitos_loop:
    mov bl, [records_buffer + di]
    cmp bl, '0'
    jl fin_extraer_numero
    cmp bl, '9'
    jg fin_extraer_numero
    
    sub bl, '0'
    mul cx              ; AX = AX * 10
    add al, bl          ; AX = AX + d?gito
    inc di
    jmp extraer_digitos_loop

fin_extraer_numero:
    pop di
    pop dx
    pop cx
    pop bx
    ret
EXTRAER_NUMERO_EN_POSICION ENDP
AVANZAR_A_SIGUIENTE_LINEA PROC
    push ax
    
buscar_fin_linea:
    cmp BYTE PTR [records_buffer + si], 0
    je fin_avanzar_linea
    cmp BYTE PTR [records_buffer + si], 10  ; LF
    je fin_avanzar_linea
    cmp BYTE PTR [records_buffer + si], 13  ; CR
    je verificar_crlf
    inc si
    jmp buscar_fin_linea

verificar_crlf:
    inc si
    cmp BYTE PTR [records_buffer + si], 10
    jne fin_avanzar_linea
    inc si              ; Saltar el LF tambi?n

fin_avanzar_linea:
    inc si              ; Avanzar al primer car?cter de la siguiente l?nea
    pop ax
    ret
AVANZAR_A_SIGUIENTE_LINEA ENDP
ESCRIBIR_BUFFER_AL_ARCHIVO PROC
    push ax
    push bx
    push cx
    push dx
    push si
    
    ; Calcular longitud del buffer
    mov si, 0
    mov cx, 0
    
calcular_longitud_escritura:
    cmp BYTE PTR [buffer_escritura + si], 0
    je fin_calcular_longitud_escritura
    inc cx
    inc si
    cmp si, 200
    jl calcular_longitud_escritura

fin_calcular_longitud_escritura:
    ; Asegurar que termina con CRLF
    cmp cx, 0
    je fin_escribir_buffer
    
    mov si, cx
    dec si
    cmp BYTE PTR [buffer_escritura + si], 10
    je escribir_al_archivo
    
    ; Agregar CRLF
    mov si, cx
    mov BYTE PTR [buffer_escritura + si], 13
    inc si
    mov BYTE PTR [buffer_escritura + si], 10
    inc si
    mov cx, si

escribir_al_archivo:
    ; Escribir al archivo
    mov ah, 40h
    mov bx, handle_archivo
    mov dx, OFFSET buffer_escritura
    int 21h

fin_escribir_buffer:
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
ESCRIBIR_BUFFER_AL_ARCHIVO ENDP
REESCRIBIR_ARCHIVO_RECORDS PROC
    push ax
    push bx
    push cx
    push dx
    push si
    push di
    
    ; Crear archivo temporal o reescribir el existente
    ; Por simplicidad, vamos a reescribir el archivo original
    
    ; Cerrar y recrear el archivo
    mov ah, 3Ch         ; Crear archivo (sobrescribe si existe)
    mov cx, 0
    mov dx, OFFSET nombre_archivo
    int 21h
    jc error_reescribir
    
    mov handle_archivo, ax
    
    ; Escribir todos los records excepto el m?nimo, m?s el nuevo record
    call ESCRIBIR_RECORDS_FILTRADOS
    
    ; Escribir el nuevo record
    call PREPARAR_BUFFER_ESCRITURA
    call ESCRIBIR_BUFFER_AL_ARCHIVO
    
    ; Cerrar archivo
    mov ah, 3Eh
    mov bx, handle_archivo
    int 21h

error_reescribir:
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
REESCRIBIR_ARCHIVO_RECORDS ENDP
ESCRIBIR_RECORDS_FILTRADOS PROC
    ; Implementaci?n simplificada
    ; En una versi?n completa, aqu? iteras sobre records_buffer
    ; y escribes cada l?nea excepto la que contiene el puntaje m?nimo
    ret
ESCRIBIR_RECORDS_FILTRADOS ENDP
VERIFICAR_GUARDADO PROC
    push ax
    push bx
    push cx
    push dx
    
    ; Mostrar mensaje de confirmaci?n
    mov ah, 02h
    mov bh, 0
    mov dh, 15      ; Fila 15
    mov dl, 20      ; Columna 20
    int 10h
    
    mov ah, 02h
    mov dl, 'G'
    int 21h
    mov dl, 'u'
    int 21h
    mov dl, 'a'
    int 21h
    mov dl, 'r'
    int 21h
    mov dl, 'd'
    int 21h
    mov dl, 'a'
    int 21h
    mov dl, 'd'
    int 21h
    mov dl, 'o'
    int 21h
    mov dl, '!'
    int 21h
    
    ; Pausa para que se vea el mensaje
    mov cx, 30000
pausa_verificacion:
    loop pausa_verificacion
    
    pop dx
    pop cx
    pop bx
    pop ax
    ret
VERIFICAR_GUARDADO ENDP

MOSTRAR_PANTALLA_GAME_OVER:


    mov ah, 0
    mov al, 03h
    int 10h
    mov ah, 06h     ; Scroll up window
    mov al, 0       ; Clear entire screen
    mov bh, 0Fh     ; Atributo: fondo negro, texto blanco brillante
    mov cx, 0       ; Upper left corner
    mov dx, 184Fh   ; Lower right corner (24,79)
    int 10h
    
    ; CORRECCI?N: Verificar si es nuevo record ANTES de mostrar mensajes
    mov ax, puntaje
    cmp ax, puntaje_maximo
    jg es_nuevo_record      ; CAMBIO: usar jg en lugar de jle
    jmp mostrar_game_over_normal

es_nuevo_record:
    ; Mostrar mensaje de nuevo record
    mov ah, 02h
    mov bh, 0
    mov dh, 6       ; Fila 6
    mov dl, 25      ; Columna 25
    int 10h   
    mov ah, 09h
    mov dx, OFFSET msg_nuevo_record
    int 21h
    
    ; Mostrar puntaje actual
    mov ah, 02h
    mov bh, 0
    mov dh, 8
    mov dl, 25      ; CORRECCI?N: Ajustar posici?n
    int 10h    
    mov ah, 09h
    mov dx, OFFSET msg_puntaje
    int 21h
    call MOSTRAR_NUMERO_PUNTAJE    
    
    ; CORRECCI?N: Pedir nombre INMEDIATAMENTE despu?s
    call PEDIR_NOMBRE_JUGADOR    
    call GUARDAR_NUEVO_RECORD
    call VERIFICAR_GUARDADO     ; AGREGAR esta l?nea
    ; Actualizar record m?ximo
    
    mov ax, puntaje
    mov puntaje_maximo, ax
    mov al, 00h   
    jmp mostrar_opciones_menu   

mostrar_game_over_normal:
    mov ah, 02h
    mov bh, 0
    mov dh, 8      
    mov dl, 32      
    int 10h    
    mov ah, 09h
    mov dx, OFFSET msg_game_over
    int 21h

mostrar_opciones_menu:
    mov ah, 02h
    mov bh, 0
    mov dh, 10
    mov dl, 30
    int 10h   
    mov ah, 09h
    mov dx, OFFSET msg_puntaje
    int 21h
    call MOSTRAR_NUMERO_PUNTAJE
    cmp puntaje_maximo, 0
    je sin_record  
    mov ah, 02h
    mov bh, 0
    mov dh, 11
    mov dl, 25
    int 10h
    mov ah, 02h
    mov dl, 'R'
    int 21h
    mov dl, 'E'
    int 21h
    mov dl, 'C'
    int 21h
    mov dl, 'O'
    int 21h
    mov dl, 'R'
    int 21h
    mov dl, 'D'
    int 21h
    mov dl, ':'
    int 21h
    mov dl, ' '
    int 21h
    push ax
    mov ax, puntaje
    push ax
    mov ax, puntaje_maximo
    mov puntaje, ax
    call MOSTRAR_NUMERO_PUNTAJE
    pop ax
    mov puntaje, ax
    pop ax   
sin_record:
    mov ah, 02h
    mov bh, 0
    mov dh, 13
    mov dl, 30
    int 10h   
    mov ah, 09h
    mov dx, OFFSET msg_reintentar
    int 21h   
    mov ah, 02h
    mov bh, 0
    mov dh, 14
    mov dl, 30
    int 10h   
    mov ah, 09h
    mov dx, OFFSET msg_menu
    int 21h   
    mov ah, 02h
    mov bh, 0
    mov dh, 15
    mov dl, 30
    int 10h    
    mov ah, 09h
    mov dx, OFFSET msg_records
    int 21h    
    mov ah, 02h
    mov bh, 0
    mov dh, 16
    mov dl, 30
    int 10h   
    mov ah, 09h
    mov dx, OFFSET msg_salir
    int 21h    
    mov ah, 02h
    mov bh, 0
    mov dh, 18
    mov dl, 28
    int 10h    
    mov ah, 09h
    mov dx, OFFSET msg_elige
    int 21h
esperar_opcion_game_over:
    mov ah, 00h
    int 16h
    cmp al, 'r'
    je reiniciar_juego
    cmp al, 'R'
    je reiniciar_juego
    cmp al, 'm'
    je volver_menu
    cmp al, 'M'
    je volver_menu
    cmp al, 'v'
    je mostrar_records_desde_game_over
    cmp al, 'V'
    je mostrar_records_desde_game_over
    cmp al, 27      ; ESC
    je salir_juego
    jmp esperar_opcion_game_over
mostrar_records_desde_game_over:
    call MOSTRAR_PANTALLA_RECORDS
    jmp MOSTRAR_PANTALLA_GAME_OVER
reiniciar_juego:
    call REINICIAR_VARIABLES_JUEGO
    mov ah, 0
    mov al, 13h
    int 10h   
    call DIBUJAR_ESCENA
    call MOSTRAR_VIDAS
    call MOSTRAR_PUNTAJE
    jmp BUCLE_JUEGO
volver_menu:
    jmp menu_principal
salir_juego:
    jmp FIN_JUEGO
FIN_JUEGO:
    mov ah, 0
    mov al, 03h
    int 10h
    mov ax, 4C00h
    int 21h 
REINICIAR_VARIABLES_JUEGO PROC
    push ax
    push bx
    push cx
    push si
    mov xPos, 160
    mov yPos, 100    
    mov velX, 1
    mov velY, -1
    mov contador, 0    
    mov paletaX, 115    
    mov si, 0
    mov cx, 28
reiniciar_bloques_loop:
    mov bx, OFFSET bloques
    add bx, si
    mov BYTE PTR [bx], 1
    inc si
    loop reiniciar_bloques_loop    
    mov bloques_restantes, 28
    mov puntaje, 0
    mov vidas, 3
    mov nivel_actual, 1
    mov ah, 0Ch
    mov al, 0
    int 21h   
    pop si
    pop cx
    pop bx
    pop ax
    ret
REINICIAR_VARIABLES_JUEGO ENDP   
VERIFICAR_REGENERACION PROC
    push ax
    push bx
    push cx
    push si    
    cmp bloques_restantes, 0
    jne fin_verificacion
    call REGENERAR_TODOS_BLOQUES   
fin_verificacion:
    pop si
    pop cx
    pop bx
    pop ax
    ret
VERIFICAR_REGENERACION ENDP
REGENERAR_TODOS_BLOQUES PROC
    push ax
    push bx
    push cx
    push si   
    inc nivel_actual
    call LIMPIAR_AREA_BLOQUES
    mov si, 0
    mov cx, 28
regenerar_todos_loop:
    mov bx, OFFSET bloques
    add bx, si
    mov BYTE PTR [bx], 1         ; Activar bloque
    inc si
    loop regenerar_todos_loop
    mov bloques_restantes, 28
    add puntaje, 100
    call DIBUJAR_ESCENA
    call MOSTRAR_PUNTAJE
    mov cx, 50000
pausa_regeneracion:
    loop pausa_regeneracion   
    pop si
    pop cx
    pop bx
    pop ax
    ret
REGENERAR_TODOS_BLOQUES ENDP
LIMPIAR_AREA_BLOQUES PROC
    push ax
    push bx
    push cx
    push dx
    mov dx, 25              ; Y inicial
limpiar_fila_bloques:
    mov cx, 40              ; X inicial
limpiar_columna_bloques:
    mov ah, 0Ch             ; Funci?n para dibujar pixel
    mov al, 0               ; Color negro (borrar)
    mov bh, 0               ; P?gina de video
    int 10h
    inc cx
    cmp cx, 285
    jl limpiar_columna_bloques
    inc dx
    cmp dx, 85
    jl limpiar_fila_bloques    
    pop dx
    pop cx
    pop bx
    pop ax
    ret
LIMPIAR_AREA_BLOQUES ENDP
ACTUALIZAR_FISICA PROC
    push ax
    inc contador
    cmp contador, 8
    jge continuar_fisica   
    jmp saltar_fisica      
continuar_fisica:
    mov contador, 0        
    FISICA_PELOTA velX, velY
    mov ax, yPos
    cmp ax, 175
    jl no_pelota_perdida 
    call LIMPIAR_PELOTA_PERDIDA
    dec vidas
    cmp vidas, 0
    je game_over
    call REINICIAR_PELOTA
    call LIMPIAR_AREA_INFERIOR
    call MOSTRAR_VIDAS
    call MOSTRAR_PUNTAJE
    jmp fin_fisica
game_over:
    jmp MOSTRAR_PANTALLA_GAME_OVER
no_pelota_perdida:
    call DETECTAR_COLISIONES_PROC
    jmp fin_fisica
saltar_fisica:
fin_fisica:
    pop ax
    ret
ACTUALIZAR_FISICA ENDP
LIMPIAR_PELOTA_PERDIDA PROC
    push ax
    push bx
    push cx
    push dx
    mov cx, 35
limpiar_x_loop:
    mov dx, 170
limpiar_y_loop:
    cmp cx, 32
    jle skip_pixel
    cmp cx, 287
    jge skip_pixel
    cmp dx, 179
    jge skip_pixel
    mov ah, 0Ch
    mov al, 0
    mov bh, 0
    int 10h
skip_pixel:
    inc dx
    cmp dx, 179
    jl limpiar_y_loop
    inc cx
    cmp cx, 287
    jl limpiar_x_loop
    pop dx
    pop cx
    pop bx
    pop ax
    ret
LIMPIAR_PELOTA_PERDIDA ENDP
DETECTAR_COLISIONES_PROC PROC
    push ax
    push bx
    push cx
    push dx
    push si
    push di
    mov ax, xPos
    mov bx, yPos
    mov cx, paletaY
    sub cx, 8
    cmp bx, cx
    jl check_blocks_proc
    add cx, 12
    cmp bx, cx
    jg check_blocks_proc
    mov cx, paletaX
    sub cx, 3
    mov dx, paletaX
    add dx, paletaAncho
    add dx, 3
    cmp ax, cx
    jl check_blocks_proc
    cmp ax, dx
    jg check_blocks_proc
    call CALCULAR_REBOTE_PALETA
    jmp fin_colisiones_proc
check_blocks_proc:
    cmp bx, 25
    jl fin_colisiones_proc
    cmp bx, 85
    jg fin_colisiones_proc
    cmp ax, 40
    jl fin_colisiones_proc
    cmp ax, 285
    jg fin_colisiones_proc
    mov cx, bx
    sub cx, 25
    mov ax, cx
    mov bl, 15
    div bl
    cmp al, 4
    jge fin_colisiones_proc
    mov cl, al
    mov ax, xPos
    sub ax, 40
    mov bl, 35
    div bl
    cmp al, 7
    jge fin_colisiones_proc
    mov ch, al
    mov al, cl
    mov bl, 7
    mul bl
    add al, ch
    mov si, ax
    mov di, OFFSET bloques
    add di, si
    mov al, [di]
    cmp al, 0
    je fin_colisiones_proc
    mov BYTE PTR [di], 0
    dec bloques_restantes
    add puntaje, 10
    call MOSTRAR_PUNTAJE
    mov ax, si
    call BORRAR_BLOQUE
    neg velY
fin_colisiones_proc:
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
DETECTAR_COLISIONES_PROC ENDP
CALCULAR_REBOTE_PALETA PROC
    push ax
    push bx
    push cx
    push dx
    push si
    BORRAR_PELOTA xPos, yPos
    mov yPos, 165
    mov ax, xPos
    mov cx, paletaX
    mov dx, paletaAncho
    shr dx, 2
    mov si, cx
    add si, dx
    cmp ax, si
    jl rebote_extremo_izq
    add si, dx
    cmp ax, si
    jl rebote_izquierda
    add si, dx
    cmp ax, si
    jl rebote_centro
    add si, dx
    cmp ax, si
    jl rebote_derecha
    jmp rebote_extremo_der
rebote_extremo_izq:
    mov velX, -2
    jmp aplicar_rebote
rebote_izquierda:
    mov velX, -1
    jmp aplicar_rebote
rebote_centro:
    jmp aplicar_rebote
rebote_derecha:
    mov velX, 1
    jmp aplicar_rebote
rebote_extremo_der:
    mov velX, 2
    jmp aplicar_rebote
aplicar_rebote:
    mov velY, -1
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
CALCULAR_REBOTE_PALETA ENDP
REINICIAR_PELOTA PROC
    push ax
    mov xPos, 160
    mov yPos, 100
    mov velX, 0
    mov velY, 1
    mov cx, 30000
pausa_reinicio:
    loop pausa_reinicio
    pop ax
    ret
REINICIAR_PELOTA ENDP
LIMPIAR_AREA_INFERIOR PROC
    push ax
    push bx
    push cx
    push dx
    push si
    push di
    mov si, 180
limpiar_fila:
    mov di, 30
limpiar_columna:
    mov ah, 0Ch
    mov al, 0
    mov bh, 0
    mov cx, di
    mov dx, si
    int 10h
    inc di
    cmp di, 290
    jl limpiar_columna
    inc si
    cmp si, 200
    jl limpiar_fila
    DIBUJAR_LINEA_H 30, 180, 260, 15
    call DIBUJAR_PALETA
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
LIMPIAR_AREA_INFERIOR ENDP
PROCESAR_INPUT PROC
    push ax
    push bx
    mov ah, 01h
    int 16h
    jz fin_input
    mov ah, 00h
    int 16h
    cmp al, 27
    jne check_arrows
    jmp FIN_JUEGO
check_arrows:
    cmp ah, 4Bh
    je mover_izq
    cmp ah, 4Dh
    je mover_der
    cmp al, 'a'
    je mover_izq
    cmp al, 'A'
    je mover_izq
    cmp al, 'd'
    je mover_der
    cmp al, 'D'
    je mover_der
    jmp fin_input
mover_izq:
    call MOVER_PALETA_IZQ
    jmp fin_input
mover_der:
    call MOVER_PALETA_DER
    jmp fin_input
fin_input:
    pop bx
    pop ax
    ret
PROCESAR_INPUT ENDP
MOVER_PALETA_IZQ PROC
    push ax
    mov ax, paletaX
    cmp ax, 35
    jle fin_mover_izq
    call BORRAR_PALETA
    sub paletaX, 8
    call DIBUJAR_PALETA
fin_mover_izq:
    pop ax
    ret
MOVER_PALETA_IZQ ENDP
MOVER_PALETA_DER PROC
    push ax
    mov ax, paletaX
    add ax, paletaAncho
    cmp ax, 280
    jge fin_mover_der
    call BORRAR_PALETA
    add paletaX, 8
    call DIBUJAR_PALETA
fin_mover_der:
    pop ax
    ret
MOVER_PALETA_DER ENDP
BORRAR_PALETA PROC
    push ax
    push bx
    push cx
    push dx
    push di
    push si
    mov si, 0
borrar_fila_paleta:
    mov dx, paletaY
    add dx, si
    mov di, 0
borrar_columna_paleta:
    mov ah, 0Ch
    mov al, 0
    mov bh, 0
    mov cx, paletaX
    add cx, di
    sub cx, 2
    int 10h
    inc di
    mov ax, paletaAncho
    add ax, 4
    cmp di, ax
    jl borrar_columna_paleta
    inc si
    cmp si, 3
    jl borrar_fila_paleta
    pop si
    pop di
    pop dx
    pop cx
    pop bx
    pop ax
    ret
BORRAR_PALETA ENDP
DIBUJAR_PALETA PROC
    push ax
    push bx
    push cx
    push dx
    push di
    mov dx, paletaY
    mov di, 0
dibujar_loop:
    mov ah, 0Ch
    mov al, 15
    mov bh, 0
    mov cx, paletaX
    add cx, di
    int 10h
    inc di
    cmp di, paletaAncho
    jl dibujar_loop
    pop di
    pop dx
    pop cx
    pop bx
    pop ax
    ret
DIBUJAR_PALETA ENDP
BORRAR_BLOQUE PROC
    push ax
    push bx
    push cx
    push dx
    push si
    push di
    mov si, ax
    mov bl, 7
    div bl
    mov bl, ah
    mov bh, 0
    mov cx, 35
    push ax
    mov ax, bx
    mul cx
    add ax, 40
    mov cx, ax
    pop ax
    mov ah, 0
    mov bx, 15
    mul bx
    add ax, 25
    mov dx, ax
    mov si, 0
borrar_fila:
    push cx
    push dx
    add dx, si
    mov di, 0
borrar_columna:
    mov ah, 0Ch
    mov al, 0
    mov bh, 0
    push cx
    add cx, di
    int 10h
    pop cx
    inc di
    cmp di, 30
    jl borrar_columna
    pop dx
    pop cx
    inc si
    cmp si, 10
    jl borrar_fila
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
BORRAR_BLOQUE ENDP
DIBUJAR_ESCENA PROC
    push ax
    push bx
    push cx
    push dx
    push si
    DIBUJAR_PELOTA xPos, yPos
    DIBUJAR_MARCO
    mov si, 0
    cmp BYTE PTR bloques[0], 0
    je skip_bloque_0
    DIBUJAR_BLOQUE  40, 25, 30, 10, 14
skip_bloque_0:
    cmp BYTE PTR bloques[1], 0
    je skip_bloque_1
    DIBUJAR_BLOQUE  75, 25, 30, 10, 14
skip_bloque_1:
    cmp BYTE PTR bloques[2], 0
    je skip_bloque_2
    DIBUJAR_BLOQUE 110, 25, 30, 10, 14
skip_bloque_2:
    cmp BYTE PTR bloques[3], 0
    je skip_bloque_3
    DIBUJAR_BLOQUE 145, 25, 30, 10, 14
skip_bloque_3:
    cmp BYTE PTR bloques[4], 0
    je skip_bloque_4
    DIBUJAR_BLOQUE 180, 25, 30, 10, 14
skip_bloque_4:
    cmp BYTE PTR bloques[5], 0
    je skip_bloque_5
    DIBUJAR_BLOQUE 215, 25, 30, 10, 14
skip_bloque_5:
    cmp BYTE PTR bloques[6], 0
    je skip_bloque_6
    DIBUJAR_BLOQUE 250, 25, 30, 10, 14
skip_bloque_6:
    cmp BYTE PTR bloques[7], 0
    je skip_bloque_7
    DIBUJAR_BLOQUE  40, 40, 30, 10, 12
skip_bloque_7:
    cmp BYTE PTR bloques[8], 0
    je skip_bloque_8
    DIBUJAR_BLOQUE  75, 40, 30, 10, 12
skip_bloque_8:
    cmp BYTE PTR bloques[9], 0
    je skip_bloque_9
    DIBUJAR_BLOQUE 110, 40, 30, 10, 12
skip_bloque_9:
    cmp BYTE PTR bloques[10], 0
    je skip_bloque_10
    DIBUJAR_BLOQUE 145, 40, 30, 10, 12
skip_bloque_10:
    cmp BYTE PTR bloques[11], 0
    je skip_bloque_11
    DIBUJAR_BLOQUE 180, 40, 30, 10, 12
skip_bloque_11:
    cmp BYTE PTR bloques[12], 0
    je skip_bloque_12
    DIBUJAR_BLOQUE 215, 40, 30, 10, 12
skip_bloque_12:
    cmp BYTE PTR bloques[13], 0
    je skip_bloque_13
    DIBUJAR_BLOQUE 250, 40, 30, 10, 12
skip_bloque_13:
    cmp BYTE PTR bloques[14], 0
    je skip_bloque_14
    DIBUJAR_BLOQUE  40, 55, 30, 10, 9
skip_bloque_14:
    cmp BYTE PTR bloques[15], 0
    je skip_bloque_15
    DIBUJAR_BLOQUE  75, 55, 30, 10, 9
skip_bloque_15:
    cmp BYTE PTR bloques[16], 0
    je skip_bloque_16
    DIBUJAR_BLOQUE 110, 55, 30, 10, 9
skip_bloque_16:
    cmp BYTE PTR bloques[17], 0
    je skip_bloque_17
    DIBUJAR_BLOQUE 145, 55, 30, 10, 9
skip_bloque_17:
    cmp BYTE PTR bloques[18], 0
    je skip_bloque_18
    DIBUJAR_BLOQUE 180, 55, 30, 10, 9
skip_bloque_18:
    cmp BYTE PTR bloques[19], 0
    je skip_bloque_19
    DIBUJAR_BLOQUE 215, 55, 30, 10, 9
skip_bloque_19:
    cmp BYTE PTR bloques[20], 0
    je skip_bloque_20
    DIBUJAR_BLOQUE 250, 55, 30, 10, 9
skip_bloque_20:
    cmp BYTE PTR bloques[21], 0
    je skip_bloque_21
    DIBUJAR_BLOQUE  40, 70, 30, 10, 10
skip_bloque_21:
    cmp BYTE PTR bloques[22], 0
    je skip_bloque_22
    DIBUJAR_BLOQUE  75, 70, 30, 10, 10
skip_bloque_22:
    cmp BYTE PTR bloques[23], 0
    je skip_bloque_23
    DIBUJAR_BLOQUE 110, 70, 30, 10, 10
skip_bloque_23:
    cmp BYTE PTR bloques[24], 0
    je skip_bloque_24
    DIBUJAR_BLOQUE 145, 70, 30, 10, 10
skip_bloque_24:
    cmp BYTE PTR bloques[25], 0
    je skip_bloque_25
    DIBUJAR_BLOQUE 180, 70, 30, 10, 10
skip_bloque_25:
    cmp BYTE PTR bloques[26], 0
    je skip_bloque_26
    DIBUJAR_BLOQUE 215, 70, 30, 10, 10
skip_bloque_26:
    cmp BYTE PTR bloques[27], 0
    je skip_bloque_27
    DIBUJAR_BLOQUE 250, 70, 30, 10, 10
skip_bloque_27:
    call DIBUJAR_PALETA
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
DIBUJAR_ESCENA ENDP
MOSTRAR_VIDAS PROC
    push ax
    push bx
    push cx
    push dx
    mov ah, 02h
    mov bh, 0
    mov dh, 1
    mov dl, 2
    int 10h
    mov ah, 09h
    mov dx, OFFSET msg_vidas
    int 21h
    mov ax, vidas
    add al, '0'
    mov ah, 02h
    mov dl, al
    int 21h
    pop dx
    pop cx
    pop bx
    pop ax
    ret
MOSTRAR_VIDAS ENDP
MOSTRAR_PUNTAJE PROC
    push ax
    push bx
    push cx
    push dx
    mov ah, 02h
    mov bh, 0
    mov dh, 1        ; Fila 1
    mov dl, 20       ; Columna 20
    int 10h    
    mov ah, 09h
    mov dx, OFFSET msg_puntaje
    int 21h    
    call MOSTRAR_NUMERO_PUNTAJE   
    pop dx
    pop cx
    pop bx
    pop ax
    ret
MOSTRAR_PUNTAJE ENDP
MOSTRAR_NUMERO_PUNTAJE PROC
    push ax
    push bx
    push cx
    push dx   
    mov ax, puntaje
    mov bx, 10
    mov cx, 0   
    cmp ax, 0
    jne convertir_digitos
    mov ah, 02h
    mov dl, '0'
    int 21h
    jmp fin_mostrar_numero   
convertir_digitos:
    cmp ax, 0
    je mostrar_digitos
    mov dx, 0
    div bx         
    push dx       
    inc cx          
    jmp convertir_digitos    
mostrar_digitos:
    cmp cx, 0
    je fin_mostrar_numero
    pop dx      
    add dl, '0' 
    mov ah, 02h
    int 21h
    dec cx
    jmp mostrar_digitos   
fin_mostrar_numero:
    pop dx
    pop cx
    pop bx
    pop ax
    ret
MOSTRAR_NUMERO_PUNTAJE ENDP
END INICIO
