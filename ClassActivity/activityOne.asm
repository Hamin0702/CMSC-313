section .data
    prompt  db "Enter string", 10
    promptlen equ $-prompt
    

section .bss
    string      resq 40
    stuff       resb 8

section .text
    global main
    

main:

    mov rax, 1
    mov rdi, 1
    mov rsi, prompt
    mov rdx, promptlen
    syscall
    
    mov rax, 0
    mov rdi, 0
    mov rsi, string
    mov rdx, 300
    syscall
test:	
    shr rax, 1
  
	;; mov rdx,rax
    add rax, string
    mov rsi, rax
    mov rax, 1
    mov rdi, 1
    syscall
    
    
    exit:
    mov rax, 60
    mov rdi, 0
    syscall
