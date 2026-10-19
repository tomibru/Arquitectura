;3. Realizar subrutinas para convertir
;Un string, que representa un número entero en base 10, a un número.
STRNUM:
    PUSH BP
    MOV BP, SP
    PUSH EBX
    PUSH ECX
    PUSH EDX

    MOV EBX, l[BP + 8]      ; puntero al string
    MOV EAX, 0              ; acumulador
    MOV EDX, 0              ; EDX = 0 positivo, 1 negativo

    MOV ECX, 0
    MOV CL, b[EBX]
    CMP ECX, 45; '-' = 45
    JNZ ciclo
    MOV EDX, 1              ; era negativo
    ADD EBX, 1              ; salteo el '-'

ciclo:
    MOV ECX, 0
    MOV CL, b[EBX]          ; carácter actual
    CMP ECX, 0
    JZ fin                  ; llegó al '\0'
    SUB ECX, 48             ; '0' = 48
    MUL EAX, 10
    ADD EAX, ECX
    ADD EBX, 1
    JMP ciclo

fin:
    CMP EDX, 0
    JZ salir
    MUL EAX, -1             ; negativo → niego

salir:
    POP EDX
    POP ECX
    POP EBX
    MOV SP, BP
    POP BP
    RET

NUMSTR:
    PUSH BP
    MOV BP, SP
    PUSH EAX
    PUSH EBX
    PUSH ECX
    PUSH EDX

    MOV EAX, l[BP + 12]         ; EAX = número
    MOV EDX, l[BP + 8]          ; EDX = puntero al buffer
    MOV ECX, 0                  ; ECX = contador de dígitos

    CMP EAX, 0
    JNN ciclo_div               ; si n >= 0, directo a dividir
    MOV b[EDX], 45              ; '-'
    ADD EDX, 1
    MUL EAX, -1                 ; n = -n

ciclo_div:                      ; hacer-mientras (corre al menos 1 vez)
    DIV EAX, 10                 ; EAX = cociente, AC = resto
    PUSH AC                     ; guardo el dígito
    ADD ECX, 1                  ; contador++
    CMP EAX, 0
    JNZ ciclo_div               ; mientras el cociente != 0

ciclo_stack:
    POP EBX                     ; saco los dígitos en orden correcto
    ADD EBX, 48                 ; a ASCII
    MOV b[EDX], BL
    ADD EDX, 1
    SUB ECX, 1
    JNZ ciclo_stack             ; hasta vaciar los dígitos

    MOV b[EDX], 0               ; terminador

    POP EDX
    POP ECX
    POP EBX
    POP EAX
    POP BP
    RET