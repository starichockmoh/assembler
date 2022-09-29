.model tiny               
.code                     
org 100h  
start:
	mov dx,offset StudentInfo   
	call Out_string       ;печатаем на экран информацию о студенте
	mov ax,5              ;помещаем цифру 5 в ax
	add ax,30h            ;прибавляем 5 с 16ричным 0 для получения asci кода                 
	mov bx,7              ;помещаем цифру 7 в ax   
	add bx,30h            ;прибавляем 7 с 16ричным 0 для получения asci кода       
	mov dx,ax
	call Out_symbol       ;печатаем на экран первую цифру
	mov dx,255 
	call Out_symbol       ;печатаем на экран пробел  
	mov dx,bx
	call Out_symbol       ;печатаем на экран вторую цифру
	mov AX,4C00h
	int 21h
	Out_string proc       ;процедура для печати строки
		mov ah,09h
		int 21h
		ret
	Out_string endp
	Out_symbol proc       ;процедура для печати символа
		mov ah,02h
		int 21h
		ret
	Out_symbol endp
	
StudentInfo db 'Yanushchik Ilya Andreevich 251 ',0Dh,0Ah,'$'   ; строка с символами перехода на новую строку
end start