	AREA	Sets, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
	MOV	R0, #0			; 	int cSize =0; 
	LDR	R2, =ASize		;	aSize = address of aSize in memory;
	LDR	R3, =BSize		;	bSize = address of bSize in memory;
	LDR R2, [R2]			; 	aSize = memory.Byte[aSize] 
	LDR R3, [R3]			; 	bSize = memory.Byte[bSize] 
	
	LDR	R4, =AElems		;	aStartAddress= start of set A
	LDR	R5, =BElems		;	bStartAddress= start of set B	
	LDR	R6, =CElems		; 	cAddress = address of CElems in memory;

	MOV	R7, R4			; 	tempAdrA =  aStartAdress; 
	MOV	R9, #0			;	int countA = 0; 
	
whLoopA	
	CMP R9, R2			; 	while( countA != aSize) 
	BEQ endwhLoopA			;	{
	LDR R11, [R7]			;	elemA = memory.Byte[tempAdrA]; 
	MOV R8, R5			;	tempAdrB =  bStartAdress;
	MOV R10,#0			;	int countB = 0;
	MOV	R1, #1			;	boolean notEqual = true; 
	
whCompareB	
	CMP R10, R3			;	while( countB != bSize
	BEQ endWhCompareB		; 	&& 
	CMP	R1, #0			;  	notEqual) 
	BEQ	endWhCompareB		;	{ 	
	LDR R12, [R8]			;	elemB = memory.Byte[tempAdrB]; 
	CMP R11, R12			;  	if( elemA == elemB) 
	BNE	notEqual		;	{ 
	MOV	R1, #0			;	boolean notEqual = false; 
notEqual				;	}
	ADD	R8, R8,#4		;	tempAdrB = tempAdrB  +4;; 
	ADD R10, R10, #1		;	countB++; 
	B whCompareB			;	}
		
	
endWhCompareB				;	  
	CMP R1, #1			; 	If ( notEqual )
	BNE notUnique			;	{
	STR R11, [R6]			;	memory.Byte[cAddress ] = elemA; 
	ADD R6, R6, #4;			;	cAddress = cAddress + 4; 
	ADD R0, R0, #1			;	cSize++; 
notUnique				;	}	
	ADD R7, R7, #4;			;	aAddress = aAddress + 4; 
	ADD R9, R9, #1			;	countA++; 	
	B whLoopA			;	}
endwhLoopA	

	MOV	R8, R5			; 	tempAdrB =  bStartAdress; 
	MOV	R10, #0			;	int countB = 0; 
	
whLoopB
	CMP R10, R3			; 	while( countB != bSize) 
	BEQ endwhLoopB			;	{
	LDR R12, [R8]			;	elemB = memory.Byte[tempAdrB]; 
	MOV R7, R4			;	tempAdrA =  aStartAdress;
	MOV R9,#0			;	int countA = 0;
	MOV	R1, #1			;	boolean notEqual = true; 
	
whCompareA				;
	CMP R9, R2			;	while( countA != aSize
	BEQ endWhCompareA		; 	&& 
	CMP	R1, #1			;	notEqual) 
	BNE	endWhCompareA		;	{ 	
	LDR R11, [R7]			;	elemA = memory.Byte[tempAdrA]; 
	CMP R11, R12			; 	if( elemA == elemB) 
	BNE	notEqualB		;	{ 
	MOV	R1, #0			;	boolean notEqual = false; 
	
notEqualB				;	}
	ADD	R7, R7,#4		;	tempAdrA = tempAdrA  +4;; 
	ADD R9, R9, #1			;	countA++; 
	B 	whCompareA		;	}
endWhCompareA				;	  
	CMP R1, #1			; 	If ( notEqual )
	BNE notUniqueB			;	{
	STR R12, [R6]			;	memory.Byte[cAddress ] = elemB; 
	ADD R6, R6, #4;			;	cAddress = cAddress + 4; 
	ADD R0, R0, #1			;	cSize++; 
notUniqueB				;	}	
	ADD R8, R8, #4;			;	bAddress = bAddress + 4; 
	ADD R10, R10, #1		;	countB++; 	
	B whLoopB			;	}
endwhLoopB

	LDR R1, =CSize			;	cSizeAdr = adress of CSize in memory
	STR R0, [R1]			;	Memory.Bye[cSizeAdr ] =cSize  ;

stop	B	stop


	AREA	TestData, DATA, READWRITE
	
ASize	DCD	5			;	Number of elements in A
AElems	DCD	45,75,90,700,6
BSize	DCD	5			; 	Number of elements in B
BElems	DCD 700,75,100,3,78		; 	Elements of B

CSize	DCD	0			; 	Number of elements in C
CElems	SPACE	56			; 	Elements of C

	END	
