.686                                ; create 32 bit code
.model flat, C                      ; 32 bit memory model
 option casemap:none                ; case sensitive

.data								; start of a data section
		public g					; export variable g
		g DWORD 4					; declare global variable g initialised to 4

.code



public      min						; make sure function name is exported	int min(int a, int b, int c) 

min:	    push    ebp             ; push frame pointer
            mov     ebp, esp        ; update ebp
			sub     esp, 4          ; space for local variable 'v'

			mov		eax, [ebp+8]
            mov     [ebp-4], eax		; v = i

			mov		eax, [ebp+12]
			cmp		eax, [ebp-4]		; if (b < v)
			jge		greater1			; {
				
			mov		[ebp-4], eax		;	v = b
greater1:								; }
			mov		eax, [ebp+16]
			cmp		eax, [ebp-4]		; if (c < v)
			jge		greater2			; {
			mov		[ebp-4], eax		;	v = c
greater2:								; }

			mov		eax, [ebp-4]		; 
			mov		esp, ebp
			pop		ebp
			ret		0

;
;
;
;
;
;
;

public		p					;int p(int i, int j, int, k, int l) {
								;	return min(min(g, i, j), k, l);
p:			push	ebp			; }				
			mov		ebp, esp
			
			push	[ebp+12]	;push params to stack
			push	[ebp+8]
			push	g
			call	min
			add		esp, 12		;remove params from stack 
			push	[ebp+20]	;push params to stack
			push	[ebp+16]	
			push	eax
			call	min
			add		esp, 12

			mov		esp, ebp
			pop		ebp
			ret		0

;
;
;
;
;
;
;
;

public		gcd							;int gcd(int a, int b) {

gcd:		push	ebp
			mov		ebp, esp

			mov		ecx, [ebp+12]
			cmp		ecx, 0				;if (b == 0) 
			je		setResult			;{ return a //see line 98,99 }
			mov		ecx, [ebp+12]		; else {return gcd(b, a % b);} 
			mov		eax, [ebp+8]		; 
			cdq							; edx = sign extend eax
			idiv	ecx					; ecx = a % b
			mov		ecx, [ebp+12]		; 
			push	edx
			push	ecx
			call	gcd
			add		esp, 8
			jmp		returnFunc
setResult:	
			mov		eax, [ebp+8]
returnFunc:
			mov		esp, ebp
			pop		ebp
			ret		0

end