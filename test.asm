.model small
.stack 100h
.data
.386
Student DB 'Sakhnov Maksim 251', 0Dh, 0Ah, '$' ; определяем переменную со строкой и переносом на следующую строку
row db 10 ; колонка
col db 20 ; столбец
mode db (?) ; режим
BreakLine DB 0Dh, 0Ah, '$'



.code

B10MODE PROC
    ;получаем текущий режим 
    mov ah, 0Fh
    int 10h
    mov mode, al

    MOV AH,00h ;Запрос на установку видеорежима
    MOV AL,03h ;Стандартный цветной текстовый режим
    INT 10h    ;Вызвать обработчик прерывания
ret
B10MODE endp

D10CURSOR proc
    PUSHA   ;сохраняем в стек содержимое всех регистров общего назначение
    mov ah, 02h
    mov bh, 1
    mov dh, 10
    mov dl, 20
    int 10h
    POPA
ret
D10CURSOR endp


C10CLEAR proc
    pusha

    MOV AH,06h   ;Запросить прокрутку вверх
    MOV AL,01h   ;на одну строку
    MOV CX,0000  ;от 00:00 до
    MOV DX,18FFh ;24:79 (весь экран)
    INT 10h      ;Вызвать обработчик прерывания

    popa
ret
C10CLEAR endp

B10DISPLAY proc 
pusha
    mov al, 44h
    mov ah, 05h
    mov di, 1640
    mov cx, 10
    i:
        push cx
        mov cx, 10

        j: 
            mov es:word ptr[di], ax
            add di, 2
        loop j

        add di, 140
        pop cx
        add ah,1
        add al, 1
    loop i
    

ret
B10DISPLAY endp



start:
    mov ax,@data
    mov ds,ax
    ;Код главной программы
 
    mov ax,0b900h         ;Используя сегментный регистр ES,   
    mov es,ax             ;организовать запись данных в видеопамять
                          ;по адресу В900h:0000h (страница 1)
    call B10MODE
    call C10CLEAR
    

    MOV AH,05h ;Выбор функции для вывода страницы
    MOV AL,01h ;Страница 1
    INT 10h    ;Вызвать обработчик прерывания
    call D10CURSOR

    call B10DISPLAY

    xor ax,ax
    mov ah, 10h
    int 16h
    
    MOV AH,00h ;Запрос на установку видеорежима
    MOV AL, mode 
    INT 10h    ;Вызвать обработчик прерывания

mov AX,4C00h
int 21h

end start
