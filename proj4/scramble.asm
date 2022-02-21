; Hamin Han, XK26538, haminh1@gl.umbc.edu
; scramble.asm
;Contains the subroutine to scramble a string

	section .data

char_buff:	db	0,0	; Character buffer that will be used to printing out the transformed string
	
	section .text
	global scramble

scramble:			; Parameters: rdi has the pointer to string, rsi has length of string
	push	rbp		; Setting up the subroutine stack frame
	mov 	rbp, rsp

	mov	r12, rdi	; Getting the values from the parameters
	mov	r15, rsi
	
	xor     r10, r10 	; r10 will be the Counter value (set to 0)
	mov     r14, r15 	; Copy of the length of the string in r14
	mov     r13, r15 	; Copy of the length of the string in r13
	shr     r15, 1		; Dividing the length of the string in half, value of r15 = # of characters in first half
	mov     r14, r15 	; r14 contains the + of characters in the second half (+1 for new line)
	
	mov     r8, r12 	; r8 points to the beginning of the string
	mov     r9, r12 	; r9 points to the beginning of the string initially

	add     r9, r15		; r9 points to the middle of the string

	xor	rdx, rdx	; Set rdx before division
	mov	rax, r15	; Numerator = rax = r15 (half of string length)
	mov	rbx, 2		; Denominator = rbx = 2
	div	rbx		; rax = rax /2 and rdx = remainder

	cmp	rdx, 0		; Check if even
	je 	prep_push	; If even jump to prep_push
	inc	r9		; Else increment r9
	
prep_push:			; While Counter < # of characters in second half
	xor     r11, r11 	; Clearing up r11 which will hold the character
	mov     r11b, [r9] 	; r11b holds the single character

	push    r11		; The character is pushed on the stack
	inc     r9		; r9 points to the next character
	inc     r10		; Incrementing the counter value
	cmp     r10, r14 	; Checking if it looped enough times
	jne      prep_push 	; If Counter < # of characters in the second half, loop back

	xor     r10, r10

front:
	xor     r11, r11 	; Clearing up r11 which will hold the character
	mov     r11b, [r8] 	; r11b sroes the single character

	mov     [char_buff], r11b ; Using char_buff to store the ASCII value of the character
	mov     rsi, char_buff
	mov     rdx, 1
	mov	rax, 1
	mov	rdi, 1
	syscall    		; Printing out each individual characters

	inc     r10		; Incrementing the counter value
	cmp     r10, r13 	; Checking if it looped enough times
	jge     leave		; If Counter >= # of characters in the entire string, exit
	inc     r8		; Moving the pointer to the next address

back:
	pop     r11

	mov     [char_buff], r11b ; Using char_buff to store the ASCII value of the character
	mov     rsi, char_buff
	mov     rdx, 1
	mov	rax, 1
	mov	rdi, 1
	syscall   		; Printing out each individual characters

	inc     r10		; Incrementing the counter value
	cmp     r10, r13 	; Checking if it looped enough times
	jge     leave		; If Counter >= # of characters in the entire string, exit

	jmp     front
	
leave:
	pop	rbp		; Ending subroutine stack frame
	ret
