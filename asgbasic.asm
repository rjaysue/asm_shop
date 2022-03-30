INCLUDE EMU8086.INC

GETC MACRO P1 ; define a user macro
MOV AH, 7
INT 21H
MOV [P1], AL
ENDM

.model small

.stack 100h

.data


INTRO   DB 10,13,'Welcome to Shopping Application!' 
        DB 10,13,'We have the freshest rice in town!'
        DB 10,13,'Do not forget to check out the Covid-19 prevention items as well!'
        DB 10,13,'$' 
        
USER    DB 10,13,'Please enter your authentication code'
        DB 10,13,'New users can register by entering 00000'
        DB 10,13,'$' 
               
NEWUSER DB 10,13,'NEW USER REGISTRATION'
        DB 10,13,'Register now and get a RM 7 discount on your first purchase!'
        DB 10,13,'Just enter the given shopping code (?)'
        DB 10,13,'$'        
        
SHOP    DB 10,13,10,13,'Welcome to the shop!' 

        DB 10,13,10,13,'A) Pharmacy Shop' 
        DB 10,13,'1. Sanitizer                      RM25.00' 
        DB 10,13,'2. Mask (50 pcs)                  RM10.00'         
        DB 10,13,'3. Spray                          RM13.00'
        DB 10,13,'4. Set of 5 test kits             RM40.00'  
        
        DB 10,13,10,13,'B) Rice Shop' 
        DB 10,13,'1. Basmati rice (5kg)             RM39.00' 
        DB 10,13,'2. Local rice (5kg)               RM15.00'
        DB 10,13,'3. Pusa Gold (5kg)                RM44.00'
        DB 10,13,'4. Fragrant rice (5kg)            RM31.00' 
        DB 10,13,'$' 

PROMPT_CODE  DB 10,13,10,13, 'Press a key: $'
OUTPUT  DB 10,13,10,13, 'Key pressed: $'

REGISTER DB '00000' ; new user register
PASSCODE DB 'ABCDE' ; preset passcode
USERCODE DB 5 DUP (?) ; user passcode (reserve 5 bytes)


.code
start:

;initialize data segment        
MOV  AX, @data
MOV  DS, AX


CALL clear_screen   
   
CALL display_intro  ;display introduction to application  

PROMPT:CALL prompt_user_code ;prompt user to log in or register 

CALL user_enter_code ;user enters 5 digit code

CALL check_registered_user ;

NEW_USER_REG:

CALL clear_screen

CALL display_new_user_reg  ;prompt new code

CALL user_enter_code ; user enter 5 digit code stored in USERCODE

CALL store_new_code;

JMP start; 

SHOP_UI:   

CALL display_shop; 

;--------------------------------------------

LEA DX,PROMPT_CODE       ;display single line
MOV AH,9
INT 21H

MOV AH,1            ;asks for a keyboard input.
INT 21H             ;stored in AL register.

MOV BL,AL           ;save a copy of AL in BL

;--------------------------------------------

LEA DX,OUTPUT       ;display single line
MOV AH,9
INT 21H 

MOV AH,2            ;write character to standard output
MOV DL,BL
INT 21H

;--------------------------------------------



JMP $            
            
RET      

;wait for any key    
MOV  AH, 7
INT  21h

;finish program
MOV  AX, 4c00h
INT  21h

;---------------------------------------------

clear_screen proc
  mov  ah, 0
  mov  al, 3
  int  10H
  ret
clear_screen endp 

display_intro proc
  mov  dx, offset INTRO
  mov  ah, 9
  int  21h
  ret
display_intro endp 

prompt_user_code proc
  mov  dx, offset USER
  mov  ah, 9
  int  21h
  ret    
prompt_user_code endp 

user_enter_code proc
    MOV CX, 5 ; 5 characters
    LEA DI, USERCODE ; load address (offset) of USERCODE to DI
    RPT: GETC DI ; get a character & store at [DI]
    INC DI ; increment DI to next address
    PUTC '*' ; print an *
    LOOP RPT ; decrement CX & jump to RPT if CX?0
    PUTC 0AH ; print a new line character
    PUTC 0DH ; print a carriage return character
    RET
user_enter_code endp 

check_registered_user proc
    
    ;check new user registering
    MOV CX, 5 ; compare 5 characters
    MOV AX, DS ; AX=DS
    MOV ES, AX ; ES=AX=DS
    LEA SI, REGISTER ; load address (offset) of REGISTER to SI
    LEA DI, USERCODE ; load address (offset) of USERCODE to DI
    REPE CMPSB ; repeat until CX=0 or USERCODE?PASSCODE
    JE NEW_USER_REG ; if USERCODE=PASSCODE, jump to REGISTRATION PROCESS
    ;end of check new user registering
    
    
    MOV CX, 5 ; compare 5 characters
    MOV AX, DS ; AX=DS
    MOV ES, AX ; ES=AX=DS
    LEA SI, PASSCODE ; load address (offset) of PASSCODE to SI
    LEA DI, USERCODE ; load address (offset) of USERCODE to DI
    REPE CMPSB ; repeat until CX=0 or USERCODE?PASSCODE
    JE SHOP_UI ; if USERCODE=PASSCODE, jump to SHOPPING UI
    PRINTN 'WRONG PASSCODE!' ; else print error message
    JMP PROMPT ; jump back to prompting code
    RET
check_registered_user endp 

store_new_code proc
     MOV CX, 5;
     LEA SI, USERCODE;
     LEA DI, PASSCODE;
     RPT1: MOV AL,[SI]
     MOV [DI],AL;
     INC DI; 
     INC SI;
     LOOP RPT1;
     RET
    
store_new_code endp



display_new_user_reg proc
  mov  dx, offset NEWUSER
  mov  ah, 9
  int  21h
  ret
display_new_user_reg endp

display_shop proc
  mov  dx, offset SHOP
  mov  ah, 9
  int  21h
  ret
display_shop endp

end start