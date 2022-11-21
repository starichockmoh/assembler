.model tiny 
.386              
.code                     
org 100h  
start:
    mov dx,offset StudentInfo
    call Out_string       ;печатаем на экран информацию о студенте
    mov ax,65535 ;Выводимое число находится в регистре AX
    mov bx,10  ;Основание системы счисления - в регистре BX
    mov cx,0   ;Номер младшего разряда числа, равный 0, заносим в регистр CX

m1: mov dx,0   ;Заносим 0 в регистр DX (после деления в регистр DX попадет остаток от деления, перед делением надо его обнулить, т.к. делимое у нас AX:DX)
    div bx     ;Выполняем деление AX:DX на BX: неполное частное от деления помещается в AX (div), а остаток (mod) - в DX
    push dx    ;Сохраняем содержимое DX в стеке (нам надо сохранить очередную цифру в стек)
    inc cx     ;Увеличиваем значение счетчика в регистре CX на 1
    cmp ax,0   ;Сравнениваем неполное частное с нулем
    je m2      ;Если ax = 0 то выходим из цикла
    jmp m1     ;Иначе продолжаем деление

m2: pop dx     ;Извлекаем из стека слово данных в регистр DX
    call Out_symbol ;Вызываем процедуру вывода цифры на экран
    loop m2

    mov AX,4C00h
    int 21h

    Out_string proc       ;процедура для печати строки
        mov ah,09h
        int 21h
        ret
    Out_string endp
    Out_symbol proc       ;процедура для печати символа
        push ax
        mov ah,02h
        add dx,30h
        int 21h
        pop ax
        ret
    Out_symbol endp
StudentInfo db 'Yanushchik Ilya Andreevich 251 ',0Dh,0Ah,'$'   ; строки с символами перехода на новую строку
end start
