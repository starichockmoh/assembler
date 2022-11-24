.model tiny
.386  
.data                    ;сегмент данных
    studentInfo db 'Yanushchik Ilya Andreevich 251 ',0Dh,0Ah,'$'
    break db 0Dh, 0Ah, '$'
    array dw 20 dup(?)
    result db 5 dup(' '), '$'
    factor dw 5

.code                    ;сегмент кода
org 100h 
start: 
    mov dx,offset studentInfo
    call outString       ;печатаем на экран информацию о студенте

    ;заносим первые 10 элементов
    mov cx,10            ;шагов в цикле
    mov bx,2             ;первый элемент массива
    mov si,0             ;индекс начального элемента массива
inputFirstItems:         ;заполнение массива
    mov array[si],bx     ;заносим содержимое BX в массив
    add si,2             ;увеливаем индекс
    add bx,2             ;для получения очередного четного числа, прибавляем 2
    loop inputFirstItems

    ;заносим первые 10 элементов
    mov cx,10            ;шагов в цикле
    mov si,0             ;индекс начального элемента массива
inputSecondItems:        ;заполнение массива
    mov bx,array[si]     ;заносим в BX число из первой десятки элементов
    mov ax,bx
    mul factor           ;перемножаем элемент с числом 5
    mov array[si+20],ax  ;заносим результат в следующую десятку элементов 
    add si,2             ;увеливаем индекс
    loop inputSecondItems

    ;вывод массива
    mov cx,20            ;шагов в цикле
    mov di,10            ;заносим индекс конца первой половины массива
    mov si,0             ;индекс начального элемента массива
output: 
    mov ax,cx
    mov dx,0             ;заносим 0 в регистр DX (т.к. делимое у нас AX:DX)
    div di               ;делим ax на di
    cmp dx,0             ;если текущий шаг в цикле на равен 10, то переходим на основное тело цикла
    jne mainLoopBody
    mov dx, offset break ;иначе печатаем перенос строки
    call outString
mainLoopBody: 
    mov ax,array[si]     ;заносим очередной элемент массива simple[SI] в регистр AX.
    mov bx,10            ;заносим основание системы счисления, равное 10, в региср BL.
    call byteAsc         ;вызываем процедуру преобразования числа в строку
    mov dx,offset result ;выводим на экран число
    call outString
    add si,2             ;увеличиваем SI на 2, чтобы перейти к следующему слову массива.
    loop output
    
    mov ax,4C00h         ;завершение программы
    int 21h

byteAsc proc             ;процедура преобразования числа в строку
    pusha                ;располагаем в стеке все регистры общего назначения в следующем порядке: AX,CX,DX,BX,SP,BP,SI,DI.
    mov si,5             ;заносим длину строки результата (=5) в регистр SI.
addDigit: 
    sub si,1             ;задаем позицию в строке результата для очередной цифры числа.
    mov dx,0             ;заносим 0 в регистр DX (т.к. делимое у нас AX:DX)
    div bx               ;делим элмент на BX, неполное частное от деления помещается в AX, а остаток - в DX.
    add dx,30h           ;получаем из цифры, соотвествующей остатку от деления, код цифры в таблице ASCII
    mov result[si],dl    ;заносим код цифры в result[SI]
    cmp ax,0             ;проверка условия: если неполное частное (AL) не равно 0, то переход на addDigit.
    jne addDigit
    popa                 ;восстанавливаем регистры
    ret
byteAsc endp             ;конец процедуры

outString proc           ;процедура для печати строки
    pusha                ;располагаем в стеке все регистры общего назначения
    mov ah,09h           ;функция DOS 9h вывода на экран
    int 21h              ;вызов функции DOS
    popa                 ;восстанавливаем регистры
    ret
outString endp

end start                ;конец программы