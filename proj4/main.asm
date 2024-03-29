; Hamin Han, XK26538, haminh1@gl.umbc.edu
; Main assembly file that calls the subroutines
; The program first displays a menu with the options that the user can choose
; "d" or "D" shows the current 10 messages to the user (initially set to "I love assembly language and CMSC 313 is my favorite class at UMBC!"
; "u" or "U" gets a new message from the user and replaces a message from the array
; "f" or "F" replaces a string sequence from one of the messages
; "t" or "T" does a random transformation on the text, either reverseHalves or scramble
; "e" or "E" exits the program

extern scanf
extern printf	
extern display
extern randomNumber
extern stringLength
extern reverseHalves
extern scramble
extern easterEgg
extern validate
extern checkMsg
extern update
extern findReplace
extern freeUp
	
	section .data		; Initialized data

menu_choices:	db 	"d/D: Display", 10, "u/U: Update", 10, "f/F: Find & Replace", 10, "t/T: Transform", 10, "e/E: Exit", 10, "-------------", 10, "Enter your choice:", 10, 0 ; Menu prompt
og_msg:		db 	"I love assembly language and CMSC 313 is my favorite class at UMBC!", 0 ; Initial message that will be stored in the array
choose_str:	db	"Please enter the number of the string you would like to work with:", 10, 0
len_choose:	db 	$-choose_str
	
find_msg:	db 	"Please enter the character sequence to find: ", 10, 0
replace_msg:	db	"Please enter the replacement sequence: ", 10, 0
newtxt_msg:	db	"The new text is: ", 0
	
enter_msg:	db	"Please enter the text:", 10, 0
invalid_msg:	db	"invalid message, keeping current", 10, 10, 0
	
invalid_choice:	db	"Invalid option! Try again!", 10, 0
	
reverse_str:	db	"The text is reverse-halved as: ", 0
len_reverse:	equ	$-reverse_str

scramble_str:	db	"The text is scrambled as: ", 0
len_scramble:	equ	$-scramble_str

new_line:	db	10, 0
	
	section .bss 		; Uninitialized data

array:		resq	10	; Array of strings (10 quadwords for 10 char pointers)
selection:	resb	2	; Will contain the user input character (two bytes for character + new line)
	
	section .text		; Actual code for instructions
	global main
	
main:
	xor	rax, rax
	push	rax
	xor	r8, r8		; Set r8 to 0 which will be used as a counter

init:				; Loop to set up the initial array of messages
	mov	qword[array+r8], og_msg	
	add	r8, 8		
	cmp	r8, 80
	jl	init

menu:				; Prints out the menu prompt and asks for user input
	mov	rdi, menu_choices ; Printing out menu prompt
	xor	rax, rax	
	call 	printf
	
	mov	rax, 0		; Reading in user input
	mov	rdi, 0
	mov     rsi, selection
	mov     rdx, 2
	syscall

	xor	r8, r8		 ; r8 stores the value of user input
	mov	r8b, [selection] 

	cmp	r8, 101		; Exit if the user typed in "e" or "E"
	je	exit		
	cmp	r8, 69
	je	exit

	cmp 	r8, 100		; Check if the user typed in "d" or "D"
	je	choice_d
	cmp	r8, 68
	je	choice_d

	cmp	r8, 117		; Check if the user typed in "u" or"U"
	je	choice_u
	cmp	r8, 85
	je	choice_u

	cmp	r8, 102		; Check if the user typed in "f" or "F"
	je	choice_f
	cmp	r8, 70
	je	choice_f
	
	cmp	r8, 116		; Check if the user typed in "t" or "T"
	je	choice_t
	cmp	r8, 84
	je	choice_t

	cmp	r8, 99		; Easter egg if the user typed in "c"
	je	choice_c
	
no_choice:			; Display when user puts in an invalid option
	mov	rdi, invalid_choice
	xor	rax, rax
	call	printf
	call	printNewline
	jmp 	menu
	
choice_d:			; Display when "d" or "D"
	mov	rdi, array
	call	display		; Display the contents of the array
	jmp	menu		; Jump back to the menu prompt

choice_u:			; Update when "u" or "U"
	mov	rdi, enter_msg	; Asks for user input
	xor	rax, rax
	call 	printf

	call	validate	; Gets user input
	mov	rdi, rax
	mov	r10, rax
	push	r10
	call	checkMsg	; Check if the messgae is valid

	cmp	rax, 1		; If valid, jump to valid
	je	valid

	mov	rdi, invalid_msg ; Else tell the user that the input is invalid and jump back to menu
	pop	rax
	xor	rax, rax
	call	printf
	jmp 	menu
	
valid:
	mov 	rdi, array	; rdi: first parameter char *arr[] is array
	pop	rsi		; rsi: second parameter char * msg is the result from validate
	call	update		; Calls the update function to update the array with the new string
	call	printNewline
	jmp	menu

choice_f:			; Find and replace when "f" or "F"
	mov	rdi, choose_str	; Asks the user to choose a string
	xor	rax, rax
	call	printf

	mov     rax, 0		; User inputs number
	mov     rdi, 0
	mov     rsi, selection
	mov     rdx, 2
	syscall

	xor     r12, r12 	; r12 has the value of user input
	mov     r12b, [selection]
	sub     r12, 48

	xor     r9, r9		; Set r9 to 0
	cmp     r12, 0		; If r12 is 0
	je      setString 	; Jump and skip the loop
add:
	add     r9, 8		; Multiplies the user input number by 8
	dec     r12		; This number is added to the array address to point at the wanted element
	cmp     r12, 0
	jne     add

setString:
	mov     rdi, qword[array+r9] ; Sets rdi to the character pointer
	push	rdi

getSequence:
	mov	rdi, find_msg	; Ask the user to enter the character sequence
	xor	rax, rax
	call	printf
	call	validate
	mov	rsi, rax
	push 	rsi

getReplacement:
	mov	rdi, replace_msg ; Ask the user to enter the replacement characters
	xor	rax, rax
	call	printf
	call	validate
	mov	rdx, rax
	
	pop	rsi
	pop	rdi
	call	findReplace	; Calls replace function with the parameters: main_str in rdi, sequecne in rsi, and replacement in rdx
	jmp 	menu
	
choice_t:			; Transform when "t" or "T"
	mov	rdi, choose_str	; Asks the user to choose a string
	xor	rax, rax
	call	printf

	mov	rax, 0		; User inputs number
	mov	rdi, 0
	mov	rsi, selection
	mov	rdx, 2
	syscall			

	xor	r12, r12	; r12 has the value of user input
	mov	r12b, [selection]
	sub	r12, 48
	
	xor	r9, r9		; Set r9 to 0
	cmp	r12, 0		; If r12 is 0
	je	setParameters	; Jump and skip the loop
loop:
	add	r9, 8		; Multiplies the user input number by 8 
	dec	r12		; This number is added to the array address to point at the wanted element
	cmp	r12, 0
	jne	loop

setParameters:
	mov	rdi, qword[array+r9] ; Sets rdi to the character pointer
	mov	r12, rdi
	push	r12		     ; Push r12/rdi (the string) on the stack
	call	stringLength	     ; Ask for length of string
	push 	rax	             ; Push rax/rsi (length of string) on the stack

	call	randomNumber
	xor	rdx, rdx	; Set rdx before division
	mov	rbx, 2		; Denominator rbx = 2
	div	rbx		; rax = rax / 2 and rdx = remainder
			
	cmp	rdx, 0			; Check if even
	je	func_reverseHalves	; If even jump to reverseHalves 
	jmp	func_scramble		; Else jump to scrample

func_reverseHalves:		; Calls reverseHalves.asm
	mov	rsi, reverse_str 
	mov	rdx, len_reverse
	mov	rax, 1
	mov	rdi, 1
	syscall

	pop	rsi
	pop 	rdi
	call	reverseHalves
	call	printNewline
	call	printNewline
	jmp	menu

func_scramble:			; Calls scramble.asm
	mov	rsi, scramble_str
	mov	rdx, len_scramble
	mov	rax, 1
	mov	rdi, 1
	syscall

	pop	rsi
	pop	rdi
	call	scramble
	call 	printNewline
	call	printNewline
	jmp	menu

choice_c:			; Easter Egg when "c" 4 times
	call 	easterEgg
	jmp	menu
	
printNewline:			; Subroutine to print new line
	mov 	rsi, new_line
	mov	rdx, 2
	mov	rax, 1
	mov	rdi, 1
	syscall
	ret
	
exit:
	; call	freeUP Free up memory
	mov	rdi, array
	call	freeUp
	
	mov	rax, 60		; Exit statement
	xor	rdi, rdi
	syscall


