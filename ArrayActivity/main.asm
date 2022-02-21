extern display
extern edit
extern scanf
extern printf
section .data

num: dd 230
msg: db "Enter a number: " , 0
msg2: db "Enter an index between 1 and 10: ", 0
fmtS: db "%d", 0
section .bss

arr resq 10
numB: resd 1
numI: resd 1

section .text

global main



main:
	push rbp
	xor r8,r8
init:
	mov qword[arr+r8],num
	add r8, 8
	cmp r8, 80
	jl init

	mov rdi, arr
	call display
	
	mov rdi, msg
	xor rax, rax
	call printf
	
	mov	rdi, fmtS
	mov	rsi, numB
	xor rax, rax
	call scanf
		

        mov rdi, msg2
        xor rax, rax
        call printf

        mov     rdi, fmtS
        mov     rsi, numI
        xor rax, rax
        call scanf

	mov rdi, arr
	xor rsi,rsi
	mov esi, [numB]
	xor edx, edx
	mov edx, [numI]
	dec edx
	call edit

	mov rdi, arr
        call display



done:
	pop rbp
	xor rax,rax
	ret
