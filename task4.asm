.model tiny
.386  
.data ;Сегмент данных
    StudentInfo db 'Yanushchik Ilya Andreevich 251 ',0Dh,0Ah,'$'
    nl db 0Dh, 0Ah, '$'
    simple dw 20 dup(?)
    result db 4 dup(' '), '$'
    mn dw 5

.code ;Сегмент кода
org 100h 
start: 
    mov dx,offset StudentInfo
    call Out_string       ;печатаем на экран информацию о студенте

    mov cx,10
    mov bx,2
    mov si,0
m1a: mov simple[si],bx
    add si,2
    add bx,2
    loop m1a

    mov cx,10
    mov si,0
m1b:mov bx,simple[si]
    mov ax,bx
    mul mn
    mov simple[si+20],ax
    add si,2
    loop m1b

    mov cx,20
    mov di,10
    mov si,0
m3: mov ax,cx
    mov dx, 0
    div di
    cmp dx,0
    jne m4
    mov dx, offset nl
    call Out_string
m4: mov ax,simple[si]
    mov bx,10
    call byte_asc
    call Out_result
    add si,2
    loop m3

    mov ax,4C00h ;Завершение программы
    int 21h

byte_asc proc ;Процедура преобразования числа в строку
    pusha
    mov si,4
m2: sub si,1
    mov dx,0
    div bx
    add dx,30h
    mov result[si],dl
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
    popa
    ret
Out_result endp

end start ;Конец программы