section .text
global fibo_r


fibo_r:
	push 	rbp
	mov	rbp, rsp

	CMP 	rdi, 1
	JG 	recurse

move:	mov 	rax, 1
	JMP 	END
	

recurse:
	DEC	rdi
	push	rdi
	call	fibo_r
	pop	rdi
	push	rax
	SUB	rdi, 1
	call 	fibo_r
	pop	rdi
	ADD	rax,rdi
END:
	POP	RBP
	ret
