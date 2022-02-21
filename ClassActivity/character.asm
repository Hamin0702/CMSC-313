	section .data
request:	db	"Enter a string: ", 10
len_r:		equ	$-request

num_r:		db	"Enter a number: ", 10
len_n:		equ	$-num_r

new_line:	db	10

	section .bss
string_buff:	resb	40
num_buff:	resb	2
char_buff:	resb	1

	section .text

	global main

main:
	mov	rax, 1
	mov	rdi, 1
	mov	rsi, request
	mov	rdx, len_r
	syscall

	mov	rax, 0
        mov	rdi, 0
        mov	rsi, string_buff
        mov	rdx, 40
        syscall

	mov	rax, 1
        mov	rdi, 1
        mov	rsi, num_r
        mov	rdx, len_n
        syscall

	mov     rax, 0
	mov     rdi, 0
	mov     rsi, num_buff
	mov     rdx, 2
	syscall

	mov 	r8, string_buff
	xor	r9, r9
	mov	r9b, [num_buff]
	sub	r9b, 49
	add	r8,r9
	mov	al, [r8]
	mov	[char_buff], al

	mov     rax, 1
	mov     rdi, 1
	mov     rsi, char_buff
	mov     rdx, 1
	syscall

	mov     rax, 1
	mov     rdi, 1
	mov     rsi, new_line
	mov     rdx, 1
	syscall


exit:
	mov	rax, 60
	xor	rdi, rdi
	syscall
