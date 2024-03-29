; Hamin Han, XK26538, haminh1@gl.umbc.edu
; reverseHalves.asm
; Contains the reverseHalves subroutine

	section .data

char_buff:	db	0,0	; Character buffer that will be used to print out the string
	
	section .text
	global reverseHalves

reverseHalves:		        ; Parameters: rdi has the pointer to string, rsi has length of string
	push	rbp		; Setting up the subroutine stack frame
	mov	rbp, rsp	

	mov	r12, rdi	; Getting the values from the parameters
	mov	r15, rsi
	
	mov     r8, r12	    	; r8 points to the beginning of the string
	mov     r14, r15 	; Copy of the length of the string in r14
	shr     r15, 1		; Dividing the length of the string in half
	xor     r9, r9		; r9 will be the Counter value (set to 0)

first_push:			; While Counter < # of characters in first half
	xor     r10, r10 	; Clearing up r10 which will hold the character
	mov     r10b, [r8] 	; r10b holds the single character	

	push    r10		; The character is pushed on the stack
	inc     r8		; r8 points to the next character
	inc     r9		; Incrementing the counter value
	cmp     r9, r15		; Checking if it looped enough times
	jl      first_push 	; If counter < # of characters in the first half, loop back

	xor     r9, r9		; Counter is reset to 0

first_pop:			; While Counter < # of characters in first half
	pop     r10		; Pop off from the stack and put it on r10

	mov     [char_buff], r10b ; Using char_buff to store the ASCII value of the character	
	mov     rsi, char_buff
	mov     rdx, 1
	mov	rax, 1
	mov	rdi, 1
	syscall			; Printing out each individual characters

	inc     r9
	cmp     r9, r15
	jl      first_pop

setup:
	xor     r9,r9		; Counter is reset to 0	
	mov     r8, r12 	; r8 gets the pointer to str_buff
	add     r8, r15		; r8 points to the middle of the string
	sub     r14, r15 	; r14 contains the # of characters in the second half

second_push:			; While Counter < # of characters in second half
	xor     r10, r10 	; Clearing up r10 which will hold the character
	mov     r10b, [r8] 	; r10b holds the single character

	push    r10		; The character is pushed on the stack
	inc     r8		; r8 points to the next character
	inc     r9		; Incrementing the counter value
	cmp     r9, r14		; Checking if it looped enough times
	jl      second_push 	; If counter < # of characters in the second half, loop back

	xor     r9, r9		; Counter is reset to 0

second_pop:			; While Counter < # of characters in second half
	pop     r10		; Pop off from the stack and put it on r10

	mov     [char_buff], r10b ; Using char_buff to store the ASCII value of the character
	mov     rsi, char_buff
	mov     rdx, 1
	mov	rax, 1
	mov	rdi, 1
	syscall			; Printing out each individual characters

	inc     r9		; Incrementing the counter value
	cmp     r9, r14		; Checking if it looped enough times
	jl      second_pop 	; If Counter < # of characters in second half

	pop	rbp		; Ending subroutine stack frame
	ret
