.model small
.data
str db "GAG"
len equ 11
rstr db 20 dup(?)
msg1 db 10,13, "palli$"
msg2 db 10,13,"not pallis$"
.code
mov ax,@data
mov ds,ax
mov es,ax
mov cx,len
dec cx
mov si,offset str
mov di,offset rstr
add di,cx
inc cx
back:mov al,[si]
     mov [di],al
     inc si
     dec di
     loop back
     mov di,offset rstr
     mov cx,len
disp:mov dl,[di]
     mov ah,02h
     int 21h
     inc di
     loop disp
     mov cx,len
     mov si,offset str
     mov di,offset rstr
     cld
     repe cmpsb
     jz palin
     lea dx,msg2
     jmp exit
 palin:lea dx,msg1
 exit:mov ah,09h
      int 21h
      mov ah,4ch
      int 21h
      end
