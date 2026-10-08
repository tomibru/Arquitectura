CIFRAR: push bp
        mov  bp, sp
        sub  bp, 4
        push ecx
        mov  [bp-4], 0

OTRO:   mov  ecx, [bp+8]
        add  ecx, [bp-4]
        cmp  b[ecx], 0
        jz   fin
        xor  b[ecx], [bp+12]
        add  [bp-4], 1
        jmp  OTRO

fin:    pop  ecx
        mov  sp, bp
        pop  bp
        ret
