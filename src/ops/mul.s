%macro @mul_ops 0
  @expand_r? @op_mul_r0_by_r?
  @expand_r?_imm? @op_mul_r?_by_imm?
%endmacro

%macro @op_mul_r0_by_r? 1
  @gen_op mul_r0_by_r%1, {imul ACC, R%1}
%endmacro

%macro @mul_r?_by_imm? 2
  consume_imm%2 rax
  imul R%1, rax
%endmacro

%macro @op_mul_r?_by_imm? 2
  @gen_op mul_r%1_by_imm%2, {@mul_r?_by_imm? %1, %2}
%endmacro