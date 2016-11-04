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

; procedure code
.CODE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

toUpper	MACRO addressOfByteToChange
	
	; LOGIC:
	; check if character is lower case
	; ( 'a' <= character <= 'z')
	;	if so, subtract 20h (make upper case)

LOCAL ifNotLowerCase
	
	pushfd			; save the EFLAGS register - we will be subtracting, which will change EFLAGS
	push eax		; save EAX - we use to hold the character we are converting to uppercase

	mov eax, DWORD PTR [addressOfByteToChange]

	cmp eax, 'a'	; (character < 'a') ?
	jb ifNotLowerCase

	cmp eax, 'z'	; (character > 'z') ?
	ja ifNotLowerCase

	; lower case letters are located 20h higher in the ASCII table,
	; so subtracting 20h from a lower case letter will change it to upper case.
	sub eax, 20h

ifNotLowerCase:
	; nothing to do - clean up

	pop eax			; restore EAX
	popfd			; restore EFLAGS

		ENDM

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

main	PROC
	


	mov eax, 0
	ret
main	ENDP

END
	