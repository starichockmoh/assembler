.model small
.stack 100h
.data
Student DB 'Sakhnov Maksim 251', 0Dh, 0Ah, '$' ; определяем переменную со строкой и переносом на следующую строку
hi db 'hello world$'
BreakLine DB 0Dh, 0Ah, '$'
mas dw 10 dup(?)

.code

;-------------------------------------
; Процедура Header проводит первоначальные настройки, выводит имя фамилию номер группы студента
Header Proc
mov ax, @data
mov ds, ax
xor si, si
xor di,di
mov ah, 09h
mov dx, offset Student ; выводим после прерывания данные которые храняться в переменной Студент
int 21h
RET
Header ENDP
;----------------------------------
; Процедура производит переход на следующую строку
nextLine Proc
mov ah, 09h
mov dx, offset BreakLine ;
int 21h
RET
nextLine ENDP
;----------------------------------
tabulation Proc
xor dx, dx
mov ah, 02h
mov dx, '  '
int 21h
ret
tabulation endp
;-----------------------------------

input Proc
mov cx, 10
mov si, 0
mov ax, 1
inputf: mov mas[si], ax
inc ax
add si, 2
loop inputf
ret
input ENDP

;----------------------------------
chetn Proc
mov cx, 10
xor si, si
startChetn: mov ax, mas[si]
test ax,1
jnz finishChetn ; если нечетное переходим в конец, если четное
;выполняем это
push cx
mov cx, 0
cmp ax, 9
jle cout1chisl
;--------------вывод чисел больше 9
xor dx,dx
mov bx, 10
delenieStart:
div bx
push dx
inc cx
cmp ax, 0
jne delenieStart

xor ax,ax
coutStart: pop dx
add dx,30h
mov ah, 02h
int 21h
loop coutStart
jmp ifBigger10
;--------------вывод чисел больше 9 кончился

cout1chisl:  ;вывод числа от 1 до 9
mov dx, ax
add dx, 30h
mov ah, 02h
int 21h

ifBigger10: call tabulation
pop cx
finishChetn: add si,2
loop startChetn
ret
chetn ENDP

;----------------------------------


nechetn PROC
mov cx, 10
xor si, si
startneChetn: mov ax, mas[si]
test ax,1
jz finishneChetn ; если нечетное переходим в конец, если четное
;выполняем это
push cx
mov cx, 0
cmp ax, 9
jle cout1chisln
;--------------вывод чисел больше 9
xor dx,dx
mov bx, 10
delenieStartn:
div bx
push dx
inc cx
cmp ax, 0
jne delenieStartn

xor ax,ax
coutStartn: pop dx
add dx,30h
mov ah, 02h
int 21h
loop coutStartn
jmp ifBigger10n
;--------------вывод чисел больше 9 кончился

cout1chisln:
mov dx, ax
add dx, 30h
mov ah, 02h
int 21h

ifBigger10n: call tabulation
pop cx
finishneChetn: add si,2
loop startneChetn
ret
nechetn ENDP

;----------------------------------

solve Proc
call input
call chetn
call nextline
call nechetn
ret
solve ENDP


start:
call Header

call solve

mov AX,4C00h
int 21h

end start
