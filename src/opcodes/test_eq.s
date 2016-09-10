%macro @test_eq 2
  cmp %1, %2 
  sete cl
%endmacro

@op_r?_const? test_eq, {@test_eq .a, .b}
@op_r?_r? test_eq, {@test_eq .a, .b}
@op_r?_imm? test_eq, {@test_eq .a, .b}
