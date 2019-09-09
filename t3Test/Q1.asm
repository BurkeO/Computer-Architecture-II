        add   R0,#4,R3            ; int g = 4 (global) 

min :   add   R26, R0, R16		  ; use R16 for local variable 'v'. Function will return result in register 1.
		sub   R27,R16,R0 {C}      ; b<v 		
		jge	  min0				  ;
		xor	  R0,R0,R0			  ; NOP
		add   R27,R0,R16	      ;  v=b
min0:	sub	  R28,R16,R0 {C}	  ; c<v
		jge	  min1				  ; 
		xor   R0,R0,R0			  ; NOP
		add	  R28,R0,R16		  ;  v=c
min1: 	add   R16,R0,R1 
        ret   R25,0				  ; return
		xor   R0,R0,R0			  ; NOP


p:      add   R3,R0,R10			  ; setup 1st param 
		add   R26,R0,R11		  ; setup 2nd param
		callr R25, min 			  ; call min (save return address in r25)
		add   R27,R0,R12		  ; setup 3rd param
		add   R1,R0,R10           ; setup 1st
		add   R28,R0,R11
		callr R25, min
		add   R29,R0,R12
		ret   R25,0
		xor	  R0,R0,R0
		
		
gcd:    sub   R27,R0,R0 {C}
        je    setRtr
        xor   R0,R0,R0
        add   R26,R0,R10          ; 1st param = a
        callr R25, mod            ; call an external function 'mod' to evaluate a % b (Assume provided).
        add   R27,R0,R11          ; 2nd param = b
        add   R27,R0,R10          ; 1st param
        callr R25, gcd
        add   R1,R0,R11           ; 2nd param
        j     retFnc
        xor   R0,R0,R0
setRtr: add   R26,R0,R1           
retFnc: ret   R25,0
		xor	  R0,R0,R0
