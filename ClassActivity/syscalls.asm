	section		.data
msg:	db		"Enter a string:", 0x0A
len:	equ		$ - msg

new_line db		10

	section		.bss
buff 	resb		30

	section		.text
	global		main
main:
	mov		rax, 1
	mov		rdi, 1
	mov		rsi, msg
	mov		rdx, len
	syscall

	mov		rax, 0
	mov		rdi, 0
	mov		rsi, buff
	mov		rdx, 30
	syscall

	mov		rdx, rax

	mov		rax, 1
	mov		rdi, 1
	mov 		rsi, buff
	syscall
	mov		rax, 1
	mov		rdi, 1
	mov		rsi, new_line
	mov 		rdx, 1
	syscall


	mov 		rax, 60
	xor 		rdi, rdi
	syscall
