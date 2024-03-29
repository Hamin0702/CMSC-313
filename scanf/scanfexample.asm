; hello_64.asm    print a string using printf
; Assemble:       nasm -f elf64 -l hello_64.lst  hello_64.asm
; Link:           gcc -m64 -o hello_64  hello_64.o
; Run:            ./hello_64 > hello_64.out
; Output:         cat hello_64.out

; Equivalent C code
; // hello.c
; #include <stdio.h>
; int main()
; {
;   char msg[] = "Hello world";
;   printf("%s\n",msg);
;   return 0;
; }

; Declare needed C  functions
        extern  printf          ; the C function, to be called
        extern  scanf
	extern  calcPow

        section .data           ; Data section, initialized variables
msg:    db "Enter a number:", 0 ; C string needs 0
fmt:    db "%s", 10, 0          ; The printf format, "\n",'0'
fmt_scan: db "%d",0
fmt3:   db "The result is %d ", 10, 0
        section .bss
num:    resq  1


        section .text           ; Code section.

        global main             ; the standard gcc entry point
main:                           ; the program label for the entry point
        push    rbp             ; set up stack frame, must be aligned

        mov     rdi,fmt         ; address of format, standard register rdi
        mov     rsi,msg         ; address of first data, standard register rsi
        mov     rax,0           ; or can be  xor  rax,rax
        call    printf          ; Call C function


        mov     rdi,fmt_scan
        mov     rsi,num
        mov     rax,0 
        
        call    scanf
	
        ;mov     r8b, [num]
	xor	 rdi, rdi
	mov	 dil, [num]
	call	 calcPow
	mov	 word[num], ax

        mov     rdi,fmt3         ; address of format, standard register rdi
        mov     rsi,[num]         ; address of first data, standard register rsi
        mov     rax,0           ; or can be  xor  rax,rax
        call    printf          ; Call C function

        pop     rbp             ; restore stack


        mov     rax,0           ; normal, no error, return value
        ret                     ; return
