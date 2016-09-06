%macro @div_ops 0
  @expand_r? @op_div_r0_by_r?
  @expand_r?_imm? @op_div_r?_by_imm?
%endmacro

%macro @div_r0_by_r? 1
  mov rax, R0
  cqo  
  idiv R%1
  mov R0, rax
%endmacro

%macro @op_div_r0_by_r? 1
  @gen_op div_r0_by_r%1, {@div_r0_by_r? %1}
%endmacro

%macro @div_r?_by_imm? 2
  consume_imm%2 rcx
  mov rax, R%1
  cqo  
  idiv rcx
  mov R0, rax
%endmacro

%macro @op_div_r?_by_imm? 2
  @gen_op div_r%1_by_imm%2, {@div_r?_by_imm? %1, %2}
%endmacro