%macro @inc_ops 0
  @each @op_inc_r?_by_1
  @op_inc_cx_by_1 
  @each @op_inc_r0_by_r?
  @each @op_inc_cx_by_r?
  @each @op_inc_r?_by_imm8
  @each @op_inc_r?_by_imm32
  @each @op_inc_r?_by_imm64
  @op_inc_cx_by_imm8
  @op_inc_cx_by_imm32
  @op_inc_cx_by_imm64
%endmacro

%macro @op_inc_r?_by_1 1
  @@op_inc_r%1_by_1:
    inc R%1
    @next_op
%endmacro

%macro @op_inc_cx_by_1 0
  @@op_inc_cx_by_1:
    inc CX
    @next_op
%endmacro

%macro @op_inc_r0_by_r? 1
  @@op_inc_r0_by_r%1:
    add ACC, R%1
    @next_op
%endmacro

%macro @op_inc_cx_by_r? 1
  @@op_inc_cx_by_r%1:
    add CX, R%1
    @next_op
%endmacro

%macro @op_inc_r?_by_imm8 1
  @@op_inc_r%1_by_imm8:
    consume_imm8 rax
    add R%1, rax
    @next_op
%endmacro

%macro @op_inc_r?_by_imm32 1
  @@op_inc_r%1_by_imm32:
    consume_imm32 rax
    add R%1, rax
    @next_op
%endmacro

%macro @op_inc_r?_by_imm64 1
  @@op_inc_r%1_by_imm64:
    consume_imm64 rax
    add R%1, rax
    @next_op
%endmacro

%macro @op_inc_cx_by_imm8 0
  @@op_inc_cx_by_imm8:
    consume_imm8 rax
    add CX, rax
    @next_op
%endmacro

%macro @op_inc_cx_by_imm32 0
  @@op_inc_cx_by_imm32:
    consume_imm32 rax
    add CX, rax
    @next_op
%endmacro

%macro @op_inc_cx_by_imm64 0
  @@op_inc_cx_by_imm64:
    consume_imm64 rax
    add CX, rax
    @next_op
%endmacro