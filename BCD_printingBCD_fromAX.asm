;This code prints the BCD digits in AX


; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt



.stack 100h
            
.data 
 
asciieq db 0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x39
 
.code            

MOV  AX, @data
MOV  DS, AX
            
mov ax,0x9999
mov bx,ax; 

lea si, asciieq

;compare the first digit from left 
and ax,0xf000 
jnz cmp1
je set0
cmp1:cmp ax,0x5000
jbe cmp1_low
cmp ax, 0x5000
je set5 
cmp ax, 0x6000
je set6 
cmp ax, 0x7000
je set7
cmp ax, 0x8000
je set8
cmp ax, 0x9000
je set9

cmp1_low:
cmp ax, 0x4000
je set4 
cmp ax, 0x3000 
je set3
cmp ax, 0x2000 
je set2
cmp ax, 0x1000  
je set1 
 

 
set1:mov dl,[si+1] 
jmp print
set2:mov dl,[si+2]
jmp print
set3:mov dl,[si+3]
jmp print
set4:mov dl,[si+4] 
jmp print
set5:mov dl,[si+5] 
jmp print
set6:mov dl,[si+6] 
jmp print
set7:mov dl,[si+7]
jmp print
set8:mov dl,[si+8]
jmp print
set9:mov dl,[si+9]
jmp print
set0:mov dl,ds:[si+0]
jmp print

print: mov ah, 2;  
int 21h;


;compare the second digit from left
mov ax,bx;
and ax, 0x0f00
jnz cmp2
jmp set0_2
cmp2:cmp ax,0x0500
jbe cmp2_low
cmp ax, 0x0500
je set5_2
cmp ax, 0x0600
je set6_2 
cmp ax, 0x0700 
je set7_2
cmp ax, 0x0800 
je set8_2
cmp ax, 0x0900  
je set9_2
cmp2_low:
cmp ax, 0x0400
je set4_2 
cmp ax, 0x0300
je set3_2
cmp ax, 0x0200
je set2_2
cmp ax, 0x0100 
je set1_2


set1_2:mov dl,[si+1] 
jmp print_2
set2_2:mov dl,[si+2]
jmp print_2
set3_2:mov dl,[si+3]
jmp print_2
set4_2:mov dl,[si+4] 
jmp print_2
set5_2:mov dl,[si+5] 
jmp print_2
set6_2:mov dl,[si+6] 
jmp print_2
set7_2:mov dl,[si+7]
jmp print_2
set8_2:mov dl,[si+8]
jmp print_2
set9_2:mov dl,[si+9]
jmp print_2
set0_2:mov dl,ds:[si+0]
jmp print_2

print_2: mov ah, 2;  
int 21h; 


;compare the 3rd digit 
mov ax,bx;
and ax, 0x00f0
jnz cmp3
jmp set0_3
cmp3:cmp ax,0x0050
jbe cmp3_low
cmp ax, 0x0050
je set5_3
cmp ax, 0x0060
je set6_3 
cmp ax, 0x0070 
je set7_3
cmp ax, 0x0080 
je set8_3
cmp ax, 0x0090  
je set9_3
cmp3_low:
cmp ax, 0x0040
je set4_3 
cmp ax, 0x0030
je set3_3
cmp ax, 0x0020
je set2_3
cmp ax, 0x0010 
je set1_3


set1_3:mov dl,[si+1] 
jmp print_3
set2_3:mov dl,[si+2]
jmp print_3
set3_3:mov dl,[si+3]
jmp print_3
set4_3:mov dl,[si+4] 
jmp print_3
set5_3:mov dl,[si+5] 
jmp print_3
set6_3:mov dl,[si+6] 
jmp print_3
set7_3:mov dl,[si+7]
jmp print_3
set8_3:mov dl,[si+8]
jmp print_3
set9_3:mov dl,[si+9]
jmp print_3
set0_3:mov dl,ds:[si+0]
jmp print_3

print_3: mov ah, 2;  
int 21h; 


;compare the 4th digit 
mov ax,bx;
and ax, 0x000f
jnz cmp4
jmp set0_4
cmp4:cmp ax,0x0005
jbe cmp4_low
cmp ax, 0x0005
je set5_4
cmp ax, 0x0006
je set6_4 
cmp ax, 0x0007 
je set7_4
cmp ax, 0x0008 
je set8_4
cmp ax, 0x0009  
je set9_4
cmp4_low:
cmp ax, 0x0004
je set4_4 
cmp ax, 0x0003
je set3_4
cmp ax, 0x0002
je set2_4
cmp ax, 0x0001 
je set1_4


set1_4:mov dl,[si+1] 
jmp print_4
set2_4:mov dl,[si+2]
jmp print_4
set3_4:mov dl,[si+3]
jmp print_4
set4_4:mov dl,[si+4] 
jmp print_4
set5_4:mov dl,[si+5] 
jmp print_4
set6_4:mov dl,[si+6] 
jmp print_4
set7_4:mov dl,[si+7]
jmp print_4
set8_4:mov dl,[si+8]
jmp print_4
set9_4:mov dl,[si+9]
jmp print_4
set0_4:mov dl,ds:[si+0]
jmp print_4

print_4: mov ah, 2;  
int 21h;

jmp $
ret





