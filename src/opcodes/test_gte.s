%macro @test_gte 2
  cmp %1, %2 
  setge cl
%endmacro

@op_r?_const? test_gte, {@test_gte .a, .b}
@op_r?_r? test_gte, {@test_gte .a, .b}
@op_r?_imm? test_gte, {@test_gte .a, .b}
