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
    consume_imm8 rax
    sub R%1, rax
    @next_op
%endmacro

%macro @op_dec_r?_by_imm32 1
  @@op_dec_r%1_by_imm32:
    consume_imm32 rax
    sub R%1, rax
    @next_op
%endmacro

%macro @op_dec_r?_by_imm64 1
  @@op_dec_r%1_by_imm64:
    consume_imm64 rax
    sub R%1, rax
    @next_op
%endmacro

%macro @op_dec_cx_by_imm8 0
  @@op_dec_cx_by_imm8:
    consume_imm8 rax
    sub CX, rax
    @next_op
%endmacro

%macro @op_dec_cx_by_imm32 0
  @@op_dec_cx_by_imm32:
    consume_imm32 rax
    sub CX, rax
    @next_op
%endmacro

%macro @op_dec_cx_by_imm64 0
  @@op_dec_cx_by_imm64:
    consume_imm64 rax
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
    consume_imm8 rax
    sub R%1, rax
    neg al
    @next_op
%endmacro

%macro @op_decrev_r?_by_imm32 1
  @@op_decrev_r%1_by_imm32:
    consume_imm32 rax
    sub R%1, rax
    neg eax
    @next_op
%endmacro

%macro @op_decrev_r?_by_imm64 1
  @@op_decrev_r%1_by_imm64:
    consume_imm64 rax
    sub R%1, rax
    neg rax
    @next_op
%endmacro