%macro @test_gt 2
  cmp %1, %2 
  setg cl
%endmacro

@op_r?_const? test_gt, {@test_gt .a, .b}
@op_r?_r? test_gt, {@test_gt .a, .b}
@op_r?_imm? test_gt, {@test_gt .a, .b}
