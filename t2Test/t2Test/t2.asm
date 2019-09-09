option casemap:none             ; case sensitive
 
includelib legacy_stdio_definitions.lib
extrn printf:near


.data								; start of a data section
		public g					; export variable g
		g QWORD 4					; declare global variable g initialised to 4



.code

public		min

min:		push    rbp             ; push frame pointer
            mov     rbp, rsp        ; update ebp
			sub     rsp, 8          ; space for local variable 'v'

			mov		rax, rcx
            mov     [rbp-8], rax		; v = a

			mov		rax, rdx
			cmp		rax, [rbp-8]		; if (b < v)
			jge		greater1			; {
				
			mov		[rbp-8], rax		;	v = b
greater1:								; }
			mov		rax, r8
			cmp		rax, [rbp-8]		; if (c < v)
			jge		greater2			; {
			mov		[rbp-8], rax		;	v = c
greater2:								; }

			mov		rax, [rbp-8]		; 
			mov		rsp, rbp
			pop		rbp
			ret		0

;
;
;
;
;

public		p

p:			push	rbp						
			mov		rbp, rsp

			mov		[rbp+16], r8	;save k & l
			mov		[rbp+24], r9

			mov		r8, rcx
			mov		r9, rdx
			mov		rcx, g
			mov		rdx, r8
			mov		r8, r9

			sub		rsp, 32

			call	min

			add		rsp, 32
	
			mov		rcx, rax
			mov		rdx, [rbp+16]
			mov		r8, [rbp+24]

			sub		rsp, 32

			call	min

			add		rsp, 32

			mov		rsp, rbp
			pop		rbp
			ret		0

;
;
;
;
;

public		gcd

gcd:		push	rbp						
			mov		rbp, rsp

			cmp		rdx, 0

			je		setResult			

			mov		[rbp+16], rcx	;save a & b
			mov		[rbp+24], rdx
	
			mov		rax, rcx
			mov		r10, rdx
			cqo							
			idiv	r10

			mov		rcx, [rbp+24]

			sub		rsp, 32

			call	gcd

			add		rsp, 32
			jmp		returnFunc

setResult:	
			mov		rax, rcx
returnFunc:
			mov		rsp, rbp
			pop		rbp
			ret		0

;
;
;
;
;
public		q

fxp2		db 'a = %I64d b = %I64d c = %I64d d = %I64d e = %I64d sum = %I64d', 0AH, 00H

q:			push    rbp             ; push frame pointer
            mov     rbp, rsp        ; update ebp
			sub     rsp, 8          ; space for local variable 'sum'

			mov		[rbp+16], rcx
			mov		[rbp+24], rdx
			mov		[rbp+32], r8
			mov		[rbp+40], r9


			add		rcx, rdx
			add		rcx, r8
			add		rcx, r9
			add		rcx, [rbp+48]

			mov		[rbp-8], rcx

			push	rcx
			mov		rcx, [rbp+48]
			push	rcx
			mov		rcx, [rbp+40]
			push	rcx
			mov		r9, [rbp+32]
			mov		r8, [rbp+24]
			mov		rdx,[rbp+16]
			lea		rcx, fxp2
			sub		rsp, 32
			call	printf
			add		rsp, 32
			mov		rax, [rbp-8]
			mov		rsp, rbp
			pop		rbp
			ret		0

;
;
;
;
;

public		qns

fxp3		db 'qns\n', 0AH, 00H

qns:		push    rbp             ; push frame pointer
            mov     rbp, rsp        ; update ebp

			lea		rcx, fxp3		; with shadow space
			sub		rsp, 32
			call	printf
			add		rsp, 32
			
	;		lea		rcx, fxp3		;without shadow space
	;		call	printf
			mov		rax, 0
			mov		rsp, rbp
			pop		rbp
			ret		0




			end
    