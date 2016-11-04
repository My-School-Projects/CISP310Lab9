; general comments
; This version is compatible with Visual Studio 2012 and Visual C++ Express Edition 2012

; preprocessor directives
.586
.MODEL FLAT

; external files to link with

; stack configuration
.STACK 4096

; named memory allocation and initialization
.DATA

	; Named memory locations that will be passed to our macro to test it
	testCharacter1 BYTE 'h'
	testCharacter2 BYTE 'y'

; procedure code
.CODE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

toUpper	MACRO addressOfByteToChange
	
	; We're using BYTES because we're working with ASCII characters
	; This is an UNSIGNED problem, because ASCII characters are unsigned
	; (although it doesn't technically matter because the sign bit of an ASCII
	;  character is always 0).

	; LOGIC:
	; check if character is lower case
	; ( 'a' <= character <= 'z')
	;	if so, subtract 20h (make upper case)

LOCAL ifNotLowerCase
	
	pushfd			; save the EFLAGS register - we will be subtracting, which will change EFLAGS
	push eax		; save EAX - we use AL to hold the character we are converting to uppercase
					; ALWAYS PUSH/POP DWORDS

	; get the value at the passed address

	mov al, BYTE PTR [addressOfByteToChange]

	cmp al, 'a'		; (character < 'a') ?
	jb ifNotLowerCase

	cmp al, 'z'		; (character > 'z') ?
	ja ifNotLowerCase

	; lower case letters are located 20h higher in the ASCII table,
	; so subtracting 20h from a lower case letter will change it to upper case.
	
	sub eax, 20h

	; store uppercase character at the given address
	
	mov BYTE PTR [addressOfByteToChange], al

ifNotLowerCase:
	; nothing to do - clean up

	pop eax			; restore EAX
	popfd			; restore EFLAGS

		ENDM

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

main	PROC
	
	; Use NOP to avoid VisualStudio articles

	nop

	toUpper testCharacter1

	nop

	toUpper testCharacter1

	nop

	mov eax, 0
	ret
main	ENDP

END
	