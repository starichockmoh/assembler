.model tiny
.386  
.data ;Сегмент данных
    StudentInfo db 'Yanushchik Ilya Andreevich 251 ',0Dh,0Ah,'$'
    nl db 0Dh, 0Ah, '$'
    simple dw 10 dup(?)
    result dw 2 dup(' '), '$'

.code ;Сегмент кода
org 100h 
start: 
    mov dx,offset StudentInfo
    call Out_string       ;печатаем на экран информацию о студенте
    mov cx,10
    mov bx,1
    mov si,0
m1: mov simple[si],bx
    add si,2
    add bx,10
    loop m1

    mov cx,10
    mov si,0
m3: mov ax,simple[si]
    mov bx,10
    call byte_asc
    call Out_result
    add si,2
    loop m3

    mov ax,4C00h ;Завершение программы
    int 21h

byte_asc proc ;Процедура преобразования числа в строку
    pusha
    mov si,2
m2: sub si,1
    mov dx,0
    div bx
    add dx,30h
    mov result[si+2],dx
    cmp ax,0
    jne m2
    popa
    ret
byte_asc endp ;Конец процедуры

Out_string proc      ;процедура для печати строки
    mov ah,09h
    int 21h
    ret
Out_string endp

Out_result proc
    pusha
    mov ah,09h
    mov dx,offset result
    int 21h
    mov dx,offset nl
    int 21h
    popa
    ret
Out_result endp

end start ;Конец программы