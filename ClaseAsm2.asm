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


;Insercion ordenada iterativa
insert_Sort: push bp
            mov  bp, sp
            Push eax
            Push ebx
            Push edx
            MOV  edx, [bp+8]
            MOV  eax, [bp+12]
            CMP  eax, null
            JZ   ins_fin

ins_otro:   MOV  ebx, [edx]
            CMP  ebx, null
            Jz   ins_actual
            CMP  w[ebx+val], w[eax+val]
            JNN  ins_actual
            mov  edx, ebx
            Add  edx, Sig
            JMP  ins_otro

            MOV  [eax+sig], ebx    ; (1)
            MOV  [edx], eax        ; (2)

            pop  edx
            pop  ebx
            pop  eax

;Version recursiva
insert_Sort: push bp
            mov  bp,sp
            Push eax
            Push ebx
            Push edx
            MOV  edx,[bp+8]
            MOV  eax,[bp+12]
            CMP  eax,null
            JZ   ins_fin

            MOV  ebx,[edx]
            CMP  ebx,null
            Jt   ins_actual
            CMP  w[ebx+val],w[eax+val]
            JNN  ins_actual
            mov  edx,ebx
            Add  edx,Sig

            Push eax
            Push edx
            CALL Insert_Sort
            Add  sp,8
            Jmp  ins_fin
