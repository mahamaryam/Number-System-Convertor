.model small
.stack
.data
tit db "             ----HEXADECIMAL,OCTAL,BINARY CONVERTER----$"
top db 10,13,"_____________________________$"
sel db 10,13,"|Select Conversion:         |$" 
space db 10,13, "|                           |$"
bin db 10,13,"|Enter 1 for Binary         |$"
octal db 10,13,"|Enter 2 for Octal          |$"
hex db 10,13,"|Enter 3 for Hexadecimal    |$"
bottom db 10,13,"|___________________________|$"
incorrect db 10,13,"Incorrect Input! $"       
entbin db 10,13,"Enter Binary: $"      
octalis db 10,13,"Octal is: $" 
hexis db 10,13,"Hexadecimal is: $" 
error db 10,13,"Error! Re-enter: $"   
continue db 10,13,"Do you wish to continue?$"
terminate db 10,13,"Program Terminated!$"

.code
main proc
    
        mov ax,@data
        mov ds,ax
        lea dx,tit
        mov ah,9
        int 21h 
        mov dl,13
        mov ah,2
        int 21h
        mov dl,10
        mov ah,2
        int 21h  
        start:
        mov dx,offset top
        mov ah,9
        int 21h
        mov dx,offset sel
        mov ah,9
        int 21h 
        mov dx,offset space
        mov ah,9
        int 21h
        mov dx,offset bin
        mov ah,9
        int 21h
       mov dx,offset octal
        mov ah,9
        int 21h
        mov dx,offset hex
        mov ah,9
        int 21h
        mov dx,offset bottom
        mov ah,9
        int 21h 
        mov dl,13
        mov ah,2
        int 21h
        mov dl,10
        mov ah,2
        int 21h
        mov ah,1 ;input for first three options
        int 21h 
        
        cmp al,'1'
        je binfunc
        jmp there
        
        binfunc:
        call binary 
        jmp there
        
        
        
        there:
        mov dx,offset continue
        mov ah,9
        int 21h
        mov ah,1
        int 21h
        cmp al,'Y'
        je start
        mov dx,offset terminate
        mov ah,9
        int 21h
        mov ah,4ch
        int 21h
    
    
    main endp

binary proc
     
     mov dl,13
     mov ah,2
     int 21h
     mov dl,10
     mov ah,2
     int 21h
     mov dx,offset top
     mov ah,9
     int 21h
     mov dx,offset sel
     mov ah,9
     int 21h
     mov dx,offset octal
     mov ah,9
     int 21h
     mov dx,offset hex
     mov ah,9
     int 21h
     mov dx,offset bottom
     mov ah,9
     int 21h
     mov ah,1
     int 21h
     cmp al,'2'
     je bintooctal
     cmp al,'3'
     je bintohex
     jmp noway
     bintooctal:
     call tooctal
     ret
     
     bintohex:
     call tohex 
     ret
     
     noway:
     mov dx,offset incorrect
     mov ah,9
     int 21h
     
  ret 
  binary endp
  
  proc tooctal
    
     mov dx,offset entbin
     mov ah,9
     int 21h
     xor bx,bx
      mov ah,1
      l1:
      int 21h
      cmp al,0DH
      je end
      shl bx,1
      and al,0FH
      or bl,al 
      jmp l1
      end:
      mov dx,offset octalis
      mov ah,9
      int 21h
      xor dx,dx
      mov cx,3 
      
      
      l2:
      rol bx,3
      mov dl,bl
      and dl,07H 
      add dl,48
      mov ah,2
      int 21h
     
      loop l2
 ret
 tooctal endp    
     
  proc tohex
    
    mov dl,13
    mov ah,2
    int 21h
    mov dl,10
    mov ah,2
    int 21h
    mov dx,offset entbin
    mov ah,9
    int 21h  
     
       here: 
       xor bx,bx
       mov ah,1
       loop1:
       int 21h
       cmp al,0DH
       je ending
       cmp al,'1'
       ja eror
       shl bx,1
       and al,0FH
       or bl,al
       jmp loop1
       ending:
       
       mov dl,13
       mov ah,2
       int 21h
       mov dl,10
       mov ah,2
       int 21h
       
       mov dx,offset hexis
       mov ah,9
       int 21h  
       
       mov cx,4
       
       print:
       rol bx,4
       mov dl,bl
       and dl,0FH
       cmp dl,9
       jle aa
       add dl,55
       jmp ab
       aa:
       add dl,48
       ab:
       mov ah,2
       int 21h
       dec cx
       jnz print 
       ret
       eror:
       mov dl,13
       mov ah,2
       int 21h
       mov dl,10
       mov ah,2
       int 21h
       mov dx,offset error
       mov ah,9
       int 21h
       jmp here
     
     
     tohex endp
