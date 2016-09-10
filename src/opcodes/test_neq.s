%macro @test_neq 2
  cmp %1, %2
  setne cl
%endmacro

@op_r?_const? test_neq, {@test_neq .a, .b}
@op_r?_r? test_neq, {@test_neq .a, .b}
@op_r?_imm? test_neq, {@test_neq .a, .b}
