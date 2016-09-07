%macro @div_ops 0
  @expand_r? @op_div_r0_by_r?
  @expand_r?_imm? @op_div_r?_by_imm?
%endmacro

%macro @op_div_r0_by_r? 1
  @op_begin div_r0_by_r%1
    mov rax, R0
    cqo
    idiv R%1
    mov R0, rax
  @op_end
%endmacro

%macro @op_div_r?_by_imm? 2
  @op_begin div_r%1_by_imm%2
    consume_imm%2 rbp
    mov rax, R%1
    cqo  
    idiv rbp
    mov R0, rax
  @op_end
%endmacro