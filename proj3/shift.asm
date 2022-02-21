; Hamin Han, XK26538, haminh1@gl.umbc.edu
; The user first inputs a number between 1 and 99 and this number is used to generate the random number
; The user also inputs a string and the program will randomly select either the reverseHalves or scramble operations and display it
; reverseHalves will divide the input text into two halves and then reverse each half and put them back into one string
; scramble will alternate between the characters at the ends of the string and create a new string


	section .data		; Initialized data

seed_req:	db	"Enter a number between 1 and 99: ", 10	; User input prompt for the seed
len_seed:	equ	$-seed_req				

str_req:	db	"Enter a string: ", 10 ; User input for the string
len_str:	equ	$-str_req

char_buff:	db	0, 0 ; Character buffer that will be used for later methods

new_line:	db 	10
	
	section .bss		; Uninitialized data

seed_buff:	resb 	3	; Should contain 3 bytes max (including the new line with the two digits from the number)
str_buff:	resb	40	; Will contain the user input string later (max 40 bytes as of now)
	
	
	section .text		; Actual code for instructions
	global main

print:
	mov	rax, 1		; Subroutine for printing
	mov	rdi, 1		; for cleaner code
	syscall
	ret

read:
	mov	rax, 0		; Subroutine for reading
	mov 	rdi, 0		; for cleaner code
	syscall
	ret
	
main:				
	mov 	rsi, seed_req	; Asks the user
	mov	rdx, len_seed	; for a number
	call	print		; between 1 and 99
		
	mov	rsi, seed_buff	; Stores the user input
	mov	rdx, 3		; into seed_buff
	call	read

	mov	r8, rax		; r8 register stores the length of the user input number (including the new space)
			                                                                                                               
        mov 	rsi, str_req	; Asks the user                                                                                                                
        mov	rdx, len_str	; for a string
	call	print		; (this will be converted by either reverseHalves or scramble)

	mov     rsi, str_buff   ; Stores the user input
	mov     rdx, 40		; into str_buff
	call 	read

	mov 	r15, rax	; Moves the length of the input (contained in rax) into r15
	
	mov	rsi, str_buff	; Displays the
	call	print		; unedited string

	xor	r9, r9		; Making sure r9 is 0
	mov	r9b, [seed_buff]; One digit case where you move the value of seed to r9 (r9b is the 8bit register of r9)
	sub	r9, 48
	
	mov	rsi, 99		; rsi stores the parameter "max" and stores the value 99
	cmp	r8, 2		; Check if r8 has 2 bytes = one digit number
	je	one_digit	; Jumps if user input is a one digit number
	cmp	r8, 3		; Checks if r8 has 3 bytes = two digit number
	je 	two_digits	; Jumps if user input is a two digit number


call_random:	
	call 	maxrand		; Calls maxrand (rdi has "seed" and rsi has "max"), result value will be stored in rax
	
	xor	rdx, rdx	; rdx will be set to 0 before the division
	mov	rbx, 2		; rbx will store 2, which will be the denominator
	div	rbx		; rax = rax / 2 and rdx = remainder
	
	cmp	rdx, 0		
	je	reverseHalves	; Jump to reverseHalf if maxrand is even
	jmp 	scramble	; Else jump to scramble
	

maxrand:
	mov	rax, 1103515245	; rax stores this number which will be later used for multiplication
	mul 	rdi		; rax = rdi * rax = seed * 1103515245 (result is stored in rax)
	add	rax, 12345 	; rax = rax + 12345 | random_seed = random_seed + 12345

	xor	rdx, rdx	; Initializes rdx to 0 before division (it's the first half of the numerator and the remainder after)
	mov	r8, 65536 	; Stores the value 65536 to r8, which will be the denominator 
	div	r8		; rax = rax / r8 | rax = random_seed / 65536

	inc 	rsi		; max+1
	xor	rdx, rdx	; Initializes rdx to 0 before division (it's the first half of the numerator and the remainder after)
	div	rsi		; rax = rax /rsi | rax = (random_seed / 65536) / (max + 1) *rax stored the results of the past division
	mov	rax, rdx	; We want the result of (random_seed /65536) % (max +1), which is the remainder (rdx), stored in rax

	ret			; Return statement after maxrand is called in main

one_digit:
	xor     r9, r9		 ; Making sure r9 is 0
	mov     r9b, [seed_buff] ; One digit case where you move the value of seed to r9 (r9b is the 8bit register of r9)
	sub     r9, 48		 ; Converting from ASCII to actual number to work with
	mov	rdi, r9		 ; Setting up the rdi register to hold "seed" parameter for maxrand

	jmp	call_random	 ; Jump backs into main when finished
	
two_digits:
	xor	r9, r9		 ; Making sure r9 is 0, r9 will store the first character
	xor	r10, r10	 ; Making sure r10 is 0, r10 will store the second character

	mov	r9b, [seed_buff] ; Stores the first digit in r9b
	sub	r9, 48		 ; Converting from ASCII to actual number to work with
	mov 	rax, r9		 ; rax will store r9 before multiplying
	mov	r9, 10		 ; r9 will hold 10 for the multiplication
	mul	r9		 ; rax will hold the result, the first digit will be in ten's place now
	mov	r9, rax		 ; Move the first digit back in r9
	mov 	r11, seed_buff
	inc	r11		 ; Increment the address of seed_buff to point to the second digit
	mov	r10b, [r11]	 ; Stores the second digit in r10b
	sub	r10, 48		 ; Converting from ASCII to actual number to work with
	
	xor	rbx, rbx	 ; Clearing out rbx
	add	rbx, r9		 ; Moving the first digit to bl in rbx
	add	rbx, r10	 ; Moving the second digit to bl in rbx
	mov 	rdi, rbx	 ; Setting up the rdi register to hold "seed" parameter for maxrand
	
	jmp     call_random	 ; Jump backs into main when finished

	
reverseHalves:	
	mov	r8, str_buff	; r8 points to the beginning of the string
	mov	r14, r15	; Copy of the length of the string in r14
	shr	r15, 1		; Dividing the length of the string in half
	xor	r9, r9		; r9 will be the Counter value (set to 0)
	
first_push:			; While Counter < # of characters in first half
	xor	r10, r10	; Clearing up r10 which will hold the character
	mov	r10b, [r8]	; r10b holds the single character

	push	r10		; The character is pushed on the stack
	inc 	r8		; r8 points to the next character
	inc	r9		; Incrementing the counter value
	cmp	r9, r15		; Checking if it looped enough times
	jl	first_push	; If counter < # of characters in the first half, loop back
	
	xor 	r9, r9		; Counter is reset to 0

first_pop:		    	; While Counter < # of characters in first half
	pop	r10		; Pop off from the stack and put it on r10

	mov	[char_buff], r10b ;Using char_buff to store the ASCII value of the character
	mov	rsi, char_buff
	mov	rdx, 1
	call	print		; Printing out each individual characters

	inc	r9
	cmp	r9, r15
	jl	first_pop

setup:	
	xor	r9,r9		; Counter is reset to 0
	mov	r8, str_buff 	; r8 gets the pointer to str_buff
	add	r8, r15 	; r8 points to the middle of the string
	sub	r14, r15	; r14 contains the # of characters in the second half
	dec	r14		; Removing newline
	
second_push:		 	; While Counter < # of characters in second half
	xor     r10, r10        ; Clearing up r10 which will hold the character
	mov     r10b, [r8] 	; r10b holds the single character

	push    r10		; The character is pushed on the stack
	inc     r8		; r8 points to the next character
	inc     r9		; Incrementing the counter value
	cmp     r9, r14		; Checking if it looped enough times
	jl      second_push 	; If counter < # of characters in the second half, loop back

	xor	r9, r9		; Counter is reset to 0
	
second_pop:		    	; While Counter < # of characters in second half
	pop     r10             ; Pop off from the stack and put it on r10

	mov	[char_buff], r10b ; Using char_buff to store the ASCII value of the character
	mov	rsi, char_buff
	mov     rdx, 1
	call    print		; Printing out each individual characters

	inc     r9		; Incrementing the counter value
	cmp     r9, r14		; Checking if it looped enough times
	jl      second_pop	; If Counter < # of characters in second half
		
	jmp exit
	

scramble:
	xor	r10, r10	; r10 will be the Counter value (set to 0)
	mov     r14, r15        ; Copy of the length of the string in r14
	mov     r13, r15 	; Copy of the length of the string in r13
	shr	r15, 1		; Dividing the length of the string in half, value of r15 = # of characters in first half
	sub 	r14, r15	; r14 contains the + of characters in the second half (+1 for new line)
	dec	r14		; Removing newline
	dec	r13		; Removing newline
	
	mov	r8, str_buff	; r8 points to the beginning of the string
	mov 	r9, str_buff	; r9 points to the beginning of the string initially

	add	r9, r15		; r9 points to the middle of the string
	
prep_push:		 	; While Counter < # of characters in second half
	xor	r11, r11	; Clearing up r11 which will hold the character
	mov	r11b, [r9]	; r11b holds the single character
	
	push 	r11		; The character is pushed on the stack
	inc	r9		; r9 points to the next character
	inc	r10		; Incrementing the counter value
	cmp	r10, r14	; Checking if it looped enough times
	jl	prep_push	; If Counter < # of characters in the second half, loop back

	xor	r10, r10

front:
	xor	r11, r11	; Clearing up r11 which will hold the character
	mov	r11b, [r8]	; r11b sroes the single character

	mov	[char_buff], r11 ; Using char_buff to store the ASCII value of the character
	mov	rsi, char_buff
	mov	rdx, 1
	call 	print 		; Printing out each individual characters

	inc	r10		; Incrementing the counter value
	cmp	r10, r13	; Checking if it looped enough times
	jge	exit		; If Counter >= # of characters in the entire string, exit
	inc	r8		; Moving the pointer to the next address
	
back:	
	pop	r11

	mov	[char_buff], r11 ; Using char_buff to store the ASCII value of the character
	mov	rsi, char_buff
	mov	rdx, 1
	call 	print 		; Printing out each individual characters

	inc     r10             ; Incrementing the counter value
	cmp     r10, r13 	; Checking if it looped enough times
	jge     exit		; If Counter >= # of characters in the entire string, exit

	jmp	front

exit:
	mov     rsi, new_line   	; Printing out a new line
	mov     rdx, 1
	call    print
	
	mov	rax, 60		; Exit statement
	xor	rdi, rdi	; for when the code
	syscall			; is finished running
	
