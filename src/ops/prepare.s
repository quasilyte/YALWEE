%macro @prepare_ops 0
  @expand_list_range @op_prepare?_e?, 0, E_COUNT, 4, 8, 12, 16
%endmacro

%macro @op_prepare?_e? 2
  @@op_prepare%1_e%2:
    xor rbp, rbp

    ;; copying machine code from labels
    %assign %%i 0
    %rep %1
      movzx rax, word [rdi+(2 * %%i)] ;; opcode

      mov rdx, [$op_sizes+(rax * 8)] ;; code size
      mov rax, [$op_labels+(rax*8)]  ;; code address

      movdqu xmm8, [rax]             ;; code
      movdqu [$e%2 + rbp], xmm8      ;; copy code 
      add rbp, rdx                   ;; save offset

      %assign %%i %%i+1
    %endrep

    ;; write epilogue
    mov rax, [@@stop]
    mov [$e%2+rbp], rax
    mov rax, [@@stop+8]
    mov [$e%2+rbp+8], rax 
    mov byte [$e%2+rbp+15], 0x90 
    
    add IP, (%1 * 2) ;; consume arguments
    @next_op
%endmacro