\\ EXTRA 1024
heap_init:    MOV  [es], es
              ADD  [es], 4
              RET
Null          equ  -1
Alloc:        push bp
              mov  bp, sp
              push bx
              mov  eax, null
              mov  bx, [es]
              Add  bx, [bp+8]
              Cmp  bx, 1024
              JE   Alloc_fin

              mov  eax, [es]
              Add  [es], [bp+8]

Alloc_fin:    pop  bx
              mov  sp, bp
              pop  bp
              ret


\include "heap.asm"
nodo_size  equ  6
Val        equ  0
Sig        equ  2

nodo_nuevo:   push bp
              mov  bp, sp

              Push nodo_size
              Call Alloc
              Add  sp, 4

              CMP  eax, null
              JZ   nodo_fin

              mov  [eax+Val], [bp+8]
              MOV  [eax+Sig], null

nodo_fin:     mov  sp, bp
              pop  bp
              ret
