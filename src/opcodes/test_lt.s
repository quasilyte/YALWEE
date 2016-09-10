%macro @test_lt 2
  cmp %1, %2 
  setl cl
%endmacro

@op_r?_const? test_lt, {@test_lt .a, .b}
@op_r?_r? test_lt, {@test_lt .a, .b}
@op_r?_imm? test_lt, {@test_lt .a, .b}
