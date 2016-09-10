%macro @div 2
  mov rax, %1
  cqo
  idiv %2
  mov %1, rax
%endmacro

@op_r?_const? div, {@div .a, .b}
@op_r?_r? div, {@div .a, .b}
@op_r?_imm? div, {@div .a, .b}

