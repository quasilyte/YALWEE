%macro @prepare_ops 0
  @expand_list_range @op_prepare?_e?, 0, E_COUNT, 4, 8
%endmacro

%macro @op_prepare?_e? 2
  @@op_prepare%1_e%2:
    xor rcx, rcx ;; 0 offset

    ;; copying machine code from labels
    %assign %%i 0
    %rep %1
      movzx rax, word [rdi+(2 * %%i)] ;; opcode
      mov rdx, [$op_sizes+(rax * 8)] ;; code size
      mov rax, [$op_labels+(rax*8)]  ;; code address
      mov rax, [rax]                 ;; code
      mov [$e%2 + rcx], eax          ;; copy code 
      add rcx, rdx                   ;; save offset

      %assign %%i %%i+1
    %endrep

    ;; write epilogue
    mov rax, [@@stop]
    mov [$e%2+24], rax
    mov rax, [@@stop+8]
    mov [$e%2+32], rax

    add IP, (%1 * 2) ;; consume arguments
    @next_op
%endmacro

%macro @op_prepare8_e? 1
  @@op_prepare8_e%1: 
    xor rcx, rcx ;; 0 offset

    %assign .i 0
    %rep 8
      movzx rax, word [rdi+(2 * .i)] ;; opcode
      mov rdx, [$op_sizes+(rax * 8)] ;; code size
      mov rax, [$op_labels+(rax*8)]  ;; code address
      mov rax, [rax]                 ;; code
      mov [$e%1 + rcx], eax          ;; copy code 
      add rcx, rdx                   ;; save offset

      %assign .i .i+1
    %endrep

    ;; write epilogue
    mov rax, [@@stop]
    mov [$e%1+24], rax
    mov rax, [@@stop+8]
    mov [$e%1+32], rax

    add IP, 16
    @next_op
%endmacro

%macro @op_prepare4_e? 1
  @@op_prepare4_e%1: 
    %assign .i 0
    %rep 4
      movzx rax, word [rdi+(2*.i)]   ;; opcode
      mov rdx, [$op_sizes+(rax*8)]  ;; code size
      mov rax, [$op_labels+(rax*8)] ;; code address
      mov rax, [rax]                ;; code
      mov [$e%1 + (rdx*.i)], eax

      %assign .i .i+1
    %endrep

    ;; write epilogue
    mov rax, [@@stop]
    mov [$e%1+12], rax
    mov rax, [@@stop+8]
    mov [$e%1+20], rax

    add IP, 8
    @next_op
%endmacro

