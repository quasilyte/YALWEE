%macro @test_lte 2
  cmp %1, %2 
  setle cl
%endmacro

@op_r?_const? test_lte, {@test_lte .a, .b}
@op_r?_r? test_lte, {@test_lte .a, .b}
@op_r?_imm? test_lte, {@test_lte .a, .b}
