
INCLUDE EMU8086.INC

GETC MACRO P1 ; define a user macro
MOV AH, 7
INT 21H
MOV [P1], AL
ENDM


.model small

.stack 100h

.data

  
;Pharmacy  
                                      
INTRO1 DB '                            PHARMACY SHOP                                     $',10,13
INTRO2 DB '                               RICE SHOP                                     $',10,13
       
INTRO  DB '****************************************************************************** ',10,13
       DB '*                 ===   |    |  ====    ====   ====  ====                    * ',10,13
       DB '*                |      |    | |    |  |    | |     |                        * ',10,13
       DB '*                 ===   |====| |    |  |====  |==== |====                    * ',10,13
       DB '*                    |  |    | |    |  |      |     |                        * ',10,13
       DB '*                 ===   |    | |====|  |      |==== |====                    * ',10,13
       DB '*                                                                            * ',10,13
       DB '******************************************************************************$ ',10,13 
         
NEWUSER   DB ' ----------------------------------------------------------------------------  ',10,13
          DB '|                         Welcome to SHOPEE!                                 | ',10,13
          DB '| Are you a                                                                  | ',10,13
          DB '| 1.New customer?                                                            | ',10,13
          DB '| 2.Excisting customer?                                                      | ',10,13
          DB '|____________________________________________________________________________|$',10,13 

       
 LIST  DB ' ----------------------------------------------------------------------------  ',10,13
       DB '|                         Welcome to SHOPEE!                                 | ',10,13
       DB '|                            SHOP LIST                                       | ',10,13
       DB '| Which shop are you going?                                                  | ',10,13
       DB '| 1.PHARMACY SHOP                                                            | ',10,13
       DB '| 2.RICE SHOP                                                                | ',10,13
       DB '|____________________________________________________________________________|$',10,13
       
PLIST  DB ' ----------------------------------------------------------------------------  ',10,13
       DB '|                         Welcome to PHARMACY SHOP!                          | ',10,13
       DB '|                                                                            | ',10,13
       DB '|                                                                            | ',10,13
       DB '|    Items                   Price(RM)                                       | ',10,13 
       DB '|                                                                            | ',10,13
       DB '| 1. Sanitizeir               RM25                                           | ',10,13
       DB '| 2. Mask 50pcs               RM10                                           | ',10,13
       DB '| 3. Spray                    RM13                                           | ',10,13
       DB '| 4. Set of 5 test kits       RM40                                           | ',10,13
       DB '|                                                                            | ',10,13
       DB '|============================================================================| ',10,13
       DB '|                                                                            | ',10,13
       DB '| 5. CHECK OUT                                                               | ',10,13
       DB '| 6. Go to RICE SHOP                                                         | ',10,13
       DB '|____________________________________________________________________________|$',10,13
              
         
RLIST  DB ' ----------------------------------------------------------------------------  ',10,13
       DB '|                         Welcome to RICE SHOP!                              | ',10,13
       DB '|                                                                            | ',10,13
       DB '|                                                                            | ',10,13
       DB '|    Items                   Price(RM)                                       | ',10,13 
       DB '|                                                                            | ',10,13
       DB '| 1. Basmati Rice 5kg          RM39                                          | ',10,13
       DB '| 2. Local Rice 5kg            RM15                                          | ',10,13
       DB '| 3. Pusa Gold 5kg             RM44                                          | ',10,13
       DB '| 4. Fragrant rice             RM31                                          | ',10,13
       DB '|                                                                            | ',10,13
       DB '|============================================================================| ',10,13
       DB '|                                                                            | ',10,13
       DB '| 5. CHECK OUT                                                               | ',10,13
       DB '| 6. Go to PHARMACY SHOP                                                     | ',10,13
       DB '|____________________________________________________________________________|$',10,13
         
SAN     DB 10,13,10,13,'1. Sanitizeir-RM25 $'
MASK    DB 10,13,10,13,'2. MASK 50pcs-RM10 $'
SPRAY   DB 10,13,10,13,'3. Spray - RM13 $'
KIT     DB 10,13,10,13,'4. Set of 5 Test kits-RM 40 $'

BASMATI DB 10,13,10,13,'1. Basmati Rice 5kg-RM39$'
LOCAL   DB 10,13,10,13,'2. Local rice 5kg-RM15 $'
PUSA    DB 10,13,10,13,'3. Pusa Gold 5kg-RM44 $'
FRAGRANT DB 10,13,10,13,'4. Fragrant rice 5kg-RM31$'

AGAIN  DB 10,13,'DO YOU WANT TO BUY MORE? (1.YES//2.NO//3.CHECKOUT): $'
EN_DIS DB 10,13,'AGAIN ENTER DISCOUNT: $'
R DB 0DH,0AH,'PRESENT AMOUNT IS : $'
FT DB 10,13,'TOTAL AMOUNT IS :$'  
        
ENTER DB 10,13,'PLEASE ENTER THE SHOP THAT YOU WANT TO VISIT: $'
ENTER1 DB 10,13,'PLEASE ENTER THE ITEM YOU WANT TO BUY: $'
ENTER2 DB 10,13,'PLEASE ENTER 1//2: $'
E_QUANTITY DB 10,13,'ENTER QUANTITY: $'
ER_MSG DB 10,13,'WRONG INPUT$'
E_DISCOUNT DB 10,13,'ENTER DISCOUNT(IF NOT AVAILABLE ENTER 0 ): $'

NL DB 0DH,0AH,'$'                ;NEW LINE  

A DW ?                           ;DECLARED VARIABLES
B DW ?
C DW ?
S DW 0,'$'
Z DW ?  

;------------------Checking out------------------------  

AGAIN2  DB 10,13,'DO YOU WANT TO BUY MORE? (1.YES//2.CHECKOUT): $'

SUM_OF_PURCHASE dw 0

;--------User authentication code data definition:(by SJR)----

USER    DB 10,13,'Please enter your authentication code'
        DB 10,13,'New users can register by entering 00000'
        DB 10,13,'$' 
               
NEWUSER_2 DB 10,13,'NEW USER REGISTRATION'
        DB 10,13,'Register now and get a RM 7 discount on your first purchase!'
        DB 10,13,'Enter your 5-digit registration code'        
        DB 10,13,'$' 

REGISTER DB '00000' ; new user register
PASSCODE DB 'ABCDE' ; preset passcode
USERCODE DB 5 DUP (?) ; user passcode (reserve 5 bytes)

;--------End of User authentication code data definition:----

.code
start:

     MOV AX, @DATA               
     MOV DS, AX     
     
     MOV BL,207                   ;COLOR CODE
     MOV AH,9 
     MOV AL,0  
     INT 10H  
     
     LEA DX,INTRO                  
     MOV AH,9
     INT 21H

     LEA DX,NL                   ;PRINT A NEW LINE
     MOV AH,9
     INT 21H       

     JMP BEGINTOP
        
     
BEGINTOP:
   LEA DX,NL                   ;PRINT A NEW LINE
   MOV AH,9
   INT 21H 
    
   MOV BL,10                   ;COLOR CODE
   MOV AH,9 
   MOV AL,0  
   INT 10H 
    
;User authentication code------------------------   
    PROMPT:CALL prompt_user_code ;prompt user to log in or register
    
    CALL user_enter_code ;user enters 5 digit code
    
    CALL check_registered_user ;  
    
    NEW_USER_REG:

    CALL clear_screen
    
    CALL display_new_user_reg  ;prompt new code
    
    CALL user_enter_code ; user enter 5 digit code stored in USERCODE
    
    CALL store_new_code;
    
    JMP BEGINTOP; 
;User authentication code ends--------------- 
   
   MOV BL,10                   ;COLOR CODE
   MOV AH,9 
   MOV AL,0  
   INT 10H
    
UI1:   
       MOV  AH, 0                   ;CLEAR SCREEN
       MOV  AL, 3
       INT  10H 

       LEA DX,NL                   ;PRINT A NEW LINE
       MOV AH,9
       INT 21H 
       
       MOV BL,10                   ;COLOR CODE      
       MOV AH,9 
       MOV AL,0  
       INT 10H
   
       LEA DX,LIST                ;PRINT SHOP LIST "WHICH SHOP.."
       MOV AH,9
       INT 21H 
   
       LEA DX,NL                   ;PRINT A NEW LINE
       MOV AH,9
       INT 21H
   
       LEA DX,ENTER               ;PROMPT USER TO ENTER INPUT"ENTER THE SHOP U WANNA VISIT" 
       MOV AH,9
       INT 21H
   
       MOV AH,1                    ;TAKE AN INPUT & SAVED TO AL
       INT 21H
   
       CMP AL,49                   ;IF AL=1 GO TO PAGE 1(PHARMANCY)
       JE PAGE1
   
       CMP AL,50                   ;IF AL=2 GO TO PAGE 2(RICE)
       JE PAGE2
   
   
PAGE1:
   MOV  ah, 0                   ;CLEAR SCREEN
   MOV  al, 3
   INT  10H 
   
   MOV BL,10                   ;COLOR CODE
   MOV AH,9 
   MOV AL,0  
   INT 10H
   
   LEA DX,NL                   ;PRINT A NEW LINE
   MOV AH,9
   INT 21H
   
   LEA DX,INTRO1               ;PRINT INTRO STRING 
   MOV AH,9
   INT 21H
      
   LEA DX,NL                   ;PRINT A NEW LINE
   MOV AH,9
   INT 21H 
   
   LEA DX,PLIST                ;PRINT PHARMACY SHOP LIST
   MOV AH,9
   INT 21H
   
   JMP BUY  
   
BUY:   
   LEA DX,ENTER1               ;"PLEASE ENTER THE ITEM U WANT TO BUY" 
   MOV AH,9
   INT 21H 
    
   MOV AH,1                    ;TAKE AN INPUT & SAVED TO AL
   INT 21H 
      
   CMP AL,49                   ;IF AL=1 GO TO SAN_LEB
   JE SAN_LEB
     
   CMP AL,50                   ;IF AL=2 GO TO MASK_LEB
   JE MASK_LEB
     
   CMP AL,51                   ;IF AL=3 GO TO SPRAY_LEB
   JE SPRAY_LEB
     
   CMP AL,52                   ;IF AL=4 GO TO TEST_LEB
   JE TEST_LEB 
   
   CMP AL,53                   ;IF AL=5 GO TO CHECKOUT
   JE CHECKOUT
   
   CMP AL,54                   ;IF AL=6 GO TO RICE SHOP
   JE PAGE2
   
SAN_LEB:                             
   LEA DX,E_QUANTITY           ;PRINT ENTER QUANTITY STRING
   MOV AH,9
   INT 21H
    
   MOV AH,1                    ;TAKE AN INPUT & SAVED TO AL
   INT 21H 
   
   SUB AL,0x30
   
   MOV BL,25                   ;PRICE OF SANITIZER IS MOVED TO A WHERE PRICE IS 25 
   MUL BL 
   
   call display_new_line
   CALL PRINT_NUM_UNS
   
   ;jmp output
    JMP BUY
   
MASK_LEB:
   LEA DX,E_QUANTITY           ;PRINT ENTER QUANTITY STRING
   MOV AH,9
   INT 21H
    
   MOV AH,1                    ;TAKE AN INPUT & SAVED TO AL
   INT 21H 
   
   SUB AL,48
   
   MOV BL,10                   ;PRICE OF SANITIZER IS MOVED TO A WHERE PRICE IS 25 
   MUL BL 
   
   call display_new_line
   CALL PRINT_NUM_UNS
   
   JMP BUY
   
SPRAY_LEB: 
  
   LEA DX,E_QUANTITY           ;PRINT ENTER QUANTITY STRING
   MOV AH,9
   INT 21H
    
   MOV AH,1                    ;TAKE AN INPUT & SAVED TO AL
   INT 21H 
   
   SUB AL,48
   
   MOV BL,13                   ;PRICE OF SPRAY IS MOVED TO A WHERE PRICE IS 13  
   MUL BL                      ;STORE IN BL
   
   call display_new_line
   CALL PRINT_NUM_UNS
   
   JMP BUY
   ;JMP QUANTITY
    
TEST_LEB:  
   LEA DX,E_QUANTITY           ;PRINT ENTER QUANTITY STRING
   MOV AH,9
   INT 21H
    
   MOV AH,1                    ;TAKE AN INPUT & SAVED TO AL
   INT 21H 
   
   SUB AL,48
   
   MOV BL,40                   ;PRICE OF TEST KITS IS MOVED TO A WHERE PRICE IS 40 
   MUL BL 
   
   call display_new_line
   CALL PRINT_NUM_UNS
   JMP BUY
   ;jmp output
   
   
PAGE2:
   MOV  AH, 0                   ;CLEAR SCREEN
   MOV  AL, 3
   INT  10H
    
   MOV BL,10                   ;COLOR CODE
   MOV AH,9 
   MOV AL,0  
   INT 10H
   
   LEA DX,NL                   ;PRINT A NEW LINE
   MOV AH,9
   INT 21H
   
   LEA DX,INTRO2               ;PRINT INTRO2 STRING 
   MOV AH,9                               
   INT 21H
   
   LEA DX,NL                   ;PRINT A NEW LINE
   MOV AH,9
   INT 21H  
   
   LEA DX,RLIST                 ;PRINT RICE SHOP LIST
   MOV AH,9
   INT 21H 
   JMP BUY2
   
BUY2:   
   LEA DX,NL                   ;PRINT A NEW LINE
   MOV AH,9
   INT 21H 
   
   LEA DX,ENTER1                
   MOV AH,9
   INT 21H 
    
   MOV AH,1                    ;TAKE AN INPUT & SAVED TO AL
   INT 21H 
   
   
   CMP AL,49                   ;IF AL=1 GO TO CS_MALEB LEBEL
   JE BASMATI_LEB
     
   CMP AL,50                   ;IF AL=2 GO TO FS_MALEB LEBEL
   JE LOCAL_LEB
     
   CMP AL,51                   ;IF AL=3 GO TO PANT_MALEB LEBEL
   JE PUSA_LEB
     
   CMP AL,52                   ;IF AL=4 GO TO M_SHOESB LEBEL
   JE FRAGRANT_LEB
   
   CMP AL,53                   ;IF AL=5 GO TO CHECK OUT
   JE CHECKOUT
   
   CMP AL,54                   ;IF AL=6 GO TO PHARMACY SHOP
   JE PAGE1
   
   
BASMATI_LEB:                             
                                
   LEA DX,E_QUANTITY           ;PRINT ENTER QUANTITY STRING
   MOV AH,9
   INT 21H
    
   MOV AH,1                    ;TAKE AN INPUT & SAVED TO AL
   INT 21H 
   
   SUB AL,48
   MOV BL,39                   ;PRICE OF CASUAL SHIRT MALE IS MOVED TO A WHERE PRICE IS 150 
   MUL BL 
   
   call display_new_line
   CALL PRINT_NUM_UNS
   JMP BUY2
   ;jmp output
    
LOCAL_LEB: 
   LEA DX,E_QUANTITY           ;PRINT ENTER QUANTITY STRING
   MOV AH,9
   INT 21H
    
   MOV AH,1                    ;TAKE AN INPUT & SAVED TO AL
   INT 21H 
   
   SUB AL,48
   
   MOV BL,15                   ;PRICE OF TEST KITS IS MOVED TO A WHERE PRICE IS 15 
   MUL BL 
   
   call display_new_line
   CALL PRINT_NUM_UNS
   JMP BUY2
   ;jmp output
   
PUSA_LEB: 
   LEA DX,E_QUANTITY           ;PRINT ENTER QUANTITY STRING
   MOV AH,9
   INT 21H
    
   MOV AH,1                    ;TAKE AN INPUT & SAVED TO AL
   INT 21H 
   
   SUB AL,48
   
   MOV BL,44                   ;PRICE OF TEST KITS IS MOVED TO A WHERE PRICE IS 44 
   MUL BL 
   
   call display_new_line
   CALL PRINT_NUM_UNS
   JMP BUY2
   ;jmp output
    
FRAGRANT_LEB: 
  
   LEA DX,E_QUANTITY           ;PRINT ENTER QUANTITY STRING
   MOV AH,9
   INT 21H
    
   MOV AH,1                    ;TAKE AN INPUT & SAVED TO AL
   INT 21H 
   
   SUB AL,48
   MOV BL,31                   ;PRICE OF TEST KITS IS MOVED TO A WHERE PRICE IS 40 
   MUL BL 
   
   call display_new_line
   CALL PRINT_NUM_UNS
   JMP BUY2
   ;jmp output            
   
   
;------------Implementing CHECKOUT---------------------   
   
CHECKOUT:
    CALL clear_screen             ; procedure is defined below   

    LEA DX,INTRO                  ;PRINT THE SHOPEE SIGN                  
    MOV AH,9
    INT 21H 
    
    LEA DX,AGAIN2                 ;ASK IF USER WANTS TO BUY MORE   
    MOV AH,9
    INT 21H 
    
    MOV AH,1                     ;TAKES THE INPUT OF YES OR NO
    INT 21H
    
    CMP AL,49                    ;IF YES, THEN AGAIN GO TO SHOPLIST MENU AND BUY AGAIN
    JE UI1
    
   ;IF NO, PROGRAM WILL CONTINUE 
    call display_new_line   
    
    lea di, SUM_OF_PURCHASE
    mov ax, [di]
    CALL PRINT_NUM_UNS 
    
    jmp $ ;temporary
 
;-------------------CHECKOUT END----------------------       
                      
ASK1: 
    MOV BL,1                     ;COLOR  CODE
    MOV AH,9 
    MOV AL,0  
    INT 10H
    
    LEA DX,AGAIN                 ;PRINT AGAIN IF USER WANTS TO BUY MORE IN this shop
    MOV AH,9
    INT 21H 
    
    MOV AH,1                     ;TAKES THE INPUT OF YES OR NO
    INT 21H
    
    CMP AL,49                    ;IF YES, THEN AGAIN GO TO SHOPLIST MENU AND BUY AGAIN
    JE BEGINTOP
    
    CMP AL,50
    ;JE  OUTPUT2                  ;IF NO, PROGRAM WILL GO TO MAIN MENU
    
    LEA DX,ER_MSG
    MOV AH,9                     ;IF ANY WRONG INPUT, PRINT ERROR MESSAGE AND AGAIN ASK TO BUY AGAIN
    INT 21H
    
    JMP ASK1
      

ERROR:
    
    LEA DX,ER_MSG                ;PRINT ERROR MESSAGE 
    MOV AH,9
    INT 21H
    
                     ;JUMP TO QUANTITY LEBEL
    
ADD:
    
 



DEFINE_PRINT_NUM_UNS    
END:
MOV AH, 4CH                  
INT 21H
    
;------User authentication code procedure calls definition by SJR-------

clear_screen proc
  mov  ah, 0
  mov  al, 3
  int  10H
  ret
clear_screen endp 

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
    JE UI1 ; if USERCODE=PASSCODE, jump to SHOPPING UI
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
  mov  dx, offset NEWUSER_2
  mov  ah, 9
  int  21h
  ret
display_new_user_reg endp   

display_new_line proc 
    XCHG BX,AX
    LEA DX,NL                   ;PRINT A NEW LINE
    MOV AH,9
    INT 21H
    XCHG BX,AX  
    ret
display_new_line endp

;------end of User authentication code procedure calls definition by SJR-------    
   
;---------------------------------------------


  