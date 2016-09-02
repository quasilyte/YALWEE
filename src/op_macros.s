%macro @acc_labels 1
  @op_labels %1, 1, R_COUNT-1
%endmacro

%macro @r_labels 1
  @op_labels %1, 0, R_COUNT
%endmacro

%macro @r_exc_labels 2
  @op_exc_labels %1, 0, R_COUNT, %2
%endmacro

%macro @next_op 0
  movzx rax, word [rdi]
  add rdi, 2
  jmp [$op_table+(rax*8)]
%endmacro 

;; %1 -- ident
;; %2 -- low
;; %3 -- high
%macro @op_labels 3
  %assign i %2

  %rep %3
    dq @@%1%+i  
    %assign i i+1 
  %endrep
%endmacro

;; %1 -- ident
;; %2 -- low 
;; %3 -- high
;; %4 -- excluded
%macro @op_exc_labels 4
  %assign i %2

  %rep %3
    %if i <> %4
      dq @@%1%+i  
    %endif
    %assign i i+1
  %endrep
%endmacro

%macro @opcode_handler 2
  @@op_%1%2:
    @%1 %2
    @next_op
%endmacro

%macro @acc_ops 1
  %assign i 1

  %rep R_COUNT-1
    @opcode_handler %1, i
    %assign i i+1 
  %endrep
%endmacro

%macro @r_ops 1
  %assign i 0

  %rep R_COUNT
    @opcode_handler %1, i
    %assign i i+1 
  %endrep
%endmacro

%macro @r_exc_ops 2
  %assign i 0

  %rep R_COUNT
    %if i <> %2
      @opcode_handler %1, i
    %endif
    %assign i i+1 
  %endrep
%endmacro
