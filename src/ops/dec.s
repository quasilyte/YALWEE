%macro @dec_ops 0
  @each @op_dec_r?_by_1
  @op_dec_cx_by_1 
  @each @op_dec_r0_by_r?
  @each @op_dec_cx_by_r?
  @each @op_dec_r?_by_imm8
  @each @op_dec_r?_by_imm32
  @each @op_dec_r?_by_imm64
  @op_dec_cx_by_imm8
  @op_dec_cx_by_imm32
  @op_dec_cx_by_imm64
  @each @op_decrev_r0_by_r?
  @each @op_decrev_r?_by_imm8
  @each @op_decrev_r?_by_imm32
  @each @op_decrev_r?_by_imm64
%endmacro

%macro @op_dec_r?_by_1 1
  @@op_dec_r%1_by_1:
    dec R%1
    @next_op
%endmacro

%macro @op_dec_cx_by_1 0
  @@op_dec_cx_by_1:
    dec CX
    @next_op
%endmacro

%macro @op_dec_r0_by_r? 1
  @@op_dec_r0_by_r%1:
    sub ACC, R%1
    @next_op
%endmacro

%macro @op_dec_cx_by_r? 1
  @@op_dec_cx_by_r%1:
    sub CX, R%1
    @next_op
%endmacro

%macro @op_dec_r?_by_imm8 1
  @@op_dec_r%1_by_imm8:
    read_imm8 al
    sub R%1x8, al
    @next_op
%endmacro

%macro @op_dec_r?_by_imm32 1
  @@op_dec_r%1_by_imm32:
    read_imm32 eax
    sub R%1x32, eax
    @next_op
%endmacro

%macro @op_dec_r?_by_imm64 1
  @@op_dec_r%1_by_imm64:
    read_imm64 rax
    sub R%1, rax
    @next_op
%endmacro

%macro @op_dec_cx_by_imm8 0
  @@op_dec_cx_by_imm8:
    read_imm8 al
    sub CX, rax
    @next_op
%endmacro

%macro @op_dec_cx_by_imm32 0
  @@op_dec_cx_by_imm32:
    read_imm32 eax
    sub CX, rax
    @next_op
%endmacro

%macro @op_dec_cx_by_imm64 0
  @@op_dec_cx_by_imm64:
    read_imm64 rax
    sub CX, rax
    @next_op
%endmacro

%macro @op_decrev_r0_by_r? 1
  @@op_decrev_r0_by_r%1:
    sub ACC, R%1
    neg ACC
    @next_op
%endmacro

%macro @op_decrev_r?_by_imm8 1
  @@op_decrev_r%1_by_imm8:
    read_imm8 al
    sub R%1x8, al
    neg al
    @next_op
%endmacro

%macro @op_decrev_r?_by_imm32 1
  @@op_decrev_r%1_by_imm32:
    read_imm32 eax
    sub R%1x32, eax
    neg eax
    @next_op
%endmacro

%macro @op_decrev_r?_by_imm64 1
  @@op_decrev_r%1_by_imm64:
    read_imm64 rax
    sub R%1, rax
    neg rax
    @next_op
%endmacro