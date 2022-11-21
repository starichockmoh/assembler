.model tiny 
.386              
.code                     
org 100h  
start:
    mov dx,offset StudentInfo
    call Out_string       ;печатаем на экран информацию о студенте
    mov eax,134892 ;Выводимое число находится в регистре EAX
    mov ebx,10  ;Основание системы счисления - в регистре EBX
    mov cx,0   ;Номер младшего разряда числа, равный 0, заносим в регистр CX

m1: mov edx,0   ;Заносим 0 в регистр EDX (после деления в регистр EDX попадет остаток от деления, перед делением надо его обнулить, т.к. делимое у нас EAX:EDX)
    div ebx     ;Выполняем деление EAX:EDX на EBX: неполное частное от деления помещается в EAX (div), а остаток (mod) - в EDX
    push edx    ;Сохраняем содержимое EDX в стеке (нам надо сохранить очередную цифру в стек)
    inc cx     ;Увеличиваем значение счетчика в регистре CX на 1
    cmp eax,0   ;Сравнениваем неполное частное с нулем
    je m2      ;Если eax = 0 то выходим из цикла
    jmp m1     ;Иначе продолжаем деление

m2: pop edx     ;Извлекаем из стека слово данных в регистр EDX
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
        add edx,30h
        int 21h
        pop ax
        ret
    Out_symbol endp
StudentInfo db 'Yanushchik Ilya Andreevich 251 ',0Dh,0Ah,'$'   ; строки с символами перехода на новую строку
end start
