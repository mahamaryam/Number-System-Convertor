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
entoct db 10,13,"Enter Octal: $" 
count db 0
var db 0
msg db 10,13,"Enter 4-Digit Octal Number(0-7): $"
msg2 db 10,13,"Hexadecimal equivalent is $"
errormsg db 10,13,"Incorrect! Re-enter: $" 
msghex db 10,13,"Enter Hexadecimal Number: $" 
binis db 10,13,"Binary is $"

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
        cmp al,'2'
        je octalfunc
        cmp al,'3'
        je hexjump
        jmp there
        binfunc:
        call binary 
        jmp there
        
        octalfunc:
        call octal88
        jmp there 
        
        hexjump:
        call hexfunc
        
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
     mov dl,13
     mov ah,2
     int 21h
     mov dl,10
     mov ah,2
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
  
  octal88 proc
    
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
     mov dx,offset bin
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
     mov ah,1
     int 21h
     cmp al,'1'
     je octtobin
     cmp al,'3'
     je octtohex
     jmp omg
     octtobin:
     call octal_to_binary
     ret  
     
     octtohex:
     call octal_to_hex
     ret 
     
     omg: 
     
     mov dx,offset incorrect
     mov ah,9
     int 21h 
     ret 
     
     octal88 endp
  
  octal_to_binary proc
    
    mov dx,offset entoct
    mov ah,9
    int 21h
    
   mov ah,1
      loop11:
      int 21h
      inc cx
      cmp al,0DH
      je ending2
      cmp al,57
      ja letter
      and al,0FH
      jmp herre
      letter:
      sub al,55
      herre:
      shl bx,4
      or bl,al
      jmp loop11 
      ending2:
      ;hex input complete
      mov dx,offset binis
      mov ah,9
      int 21h
      mov cx,12
      here3:
      shl bx,1
      mov var,0
      l11: 
      cmp var,3
      je here3
      shl bx,1
      inc var
      jc one
      mov dl,'0'
      jmp here2
      one:
      mov dl,'1'
      here2:
      mov ah,2
      int 21h
      loop l11   
      
      ret
      octal_to_binary endp
  
  octal_to_hex proc
    
          
               
               
           mov dx,offset count
        mov dx,offset var
       
       mov dx,offset msg
       mov ah,9
       int 21h 
       errordetect:
       xor bx,bx
       mov cx,0  
       mov ah,1  
      
      loop100:
      int 21h
      inc cx
      cmp al,0DH
      je ended
      cmp al,57
      ja letter_
      and al,0FH
      jmp heree_
      letter_:
      sub al,55
      heree_:
      shl bx,4
      or bl,al
      jmp loop100
      
      
      ended:
      cmp cx,5
      je forward
      mov dl,13
      mov ah,2
      int 21h
      mov dl,10
      mov ah,2
      int 21h
      mov dx,offset errormsg
      mov ah,9
      int 21h
      jmp errordetect     
      ;bx contains hex
        forward:
        mov dl,13
        mov ah,2
        int 21h
        mov dl,10
        mov ah,2
        int 21h
        mov dx,offset msg2
        mov ah,9
        int 21h
        xor ax,ax
        mov cx,12
        here5:
        inc var
        shl bx,1
        mov count,0
        cmp var,5
        je endloop
        
        l100:
        shl bx,1
        jc onesie
        
        mov dl,'0'
        and dl,0FH
        shl ax,1
        or al,dl
        inc count
        jmp idhr
        onesie: 
        mov dl,'1'
        and dl,0FH
        shl ax,1
        or al,dl
        inc count
        idhr:
        cmp count,3
        je here5
        dec cx
        jnz l100 
        
        endloop:
        
        
        xor bx,bx
        mov bx,ax
       
        rol bx,4
        mov cx,3  
        
        printf:
        rol bx,4
        mov dl,bl
        and dl,0FH
        cmp dl,9
        ja letter2
        add dl,30h
        jmp ok
        letter2:
        add dl,37h
        ok:
        mov ah,2
        int 21h
        loop printf
            
               
               
               
               
               
        ret
        octal_to_hex endp
                         
                         
hexfunc proc
    
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
     mov dx,offset bin
     mov ah,9
     int 21h
     mov dx,offset octal
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
     mov ah,1
     int 21h
     cmp al,'1'
     je hextobin
     cmp al,'2'
     je hextotheoctal
     jmp sountrue
     
     hextobin:
     call hex_to_binary
     ret
     
     hextotheoctal:
     call hex_to_octal
     ret    
     
     sountrue:
     mov dx,offset incorrect
     mov ah,9
     int 21h 
    
   ret 
    hexfunc endp 

hex_to_binary proc
     
     lea dx,msghex
      mov ah,9
      int 21h 
      tohere_:
      mov cx,0
      xor bx,bx
      mov ah,1 
      
      loop17:
      int 21h
      inc cx
      cmp al,0DH
      je end_end
      cmp al,57
      ja lafz
      and al,0FH
      jmp here123
      lafz:
      sub al,55
      here123:
      shl bx,4
      or bl,al
      jmp loop17
      
      
      end_end:
      cmp cx, 5
      jb _error_  
      jmp okay
      _error_:
      mov dl,13
      mov ah,2
      int 21h
      mov dl,10
      mov ah,2
      int 21h
      mov dx,offset error
      mov ah,9
      int 21h
      jmp tohere_   
      
      okay: 
      mov dl,13
      mov ah,2
      int 21h
      mov dl,10
      mov ah,2
      int 21h
      mov dx,offset binis
      mov ah,9
      int 21h   
      
      mov cx,16
      loop55:
      shl bx,1
      jc oneaik
      mov dl,48
      mov ah,2
      int 21h
      jmp idhr_
      oneaik:
      mov dl,49
      mov ah,2
      int 21h 
      idhr_: 
      
      loop loop55
    
    
    ret
    hex_to_binary endp     

hex_to_octal proc
       
       mov dx,offset msghex
       mov ah,9
       int 21h
       mov dx,offset var 
       mov var,0
      xor bx,bx
      mov ah,1
      loopee:
      int 21h
      inc cx
      cmp al,0DH
      je endabc
      cmp al,57
      ja letterz
      and al,0FH
      jmp _here_
      letterz:
      sub al,55
      _here_:
      shl bx,4
      or bl,al
      jmp loopee 
      endabc:
      ;hex input complete
      ;in the backend its already stored as binary 
      mov dx,offset octalis
      mov ah,9
      int 21h
      shl bx,1
      jc oone
      mov dl,48
      jmp hh
      oone:
      mov dl,49
      hh:
      mov ah,2
      int 21h
      mov cx,5
      loopee2:
      rol bx,3
      mov dl,bl
      and dl,07h
      add dl,48
      mov ah,2
      int 21h
      loop loopee2
    
    
    ret
    hex_to_octal endp
