%macro @test_gt_?_? 2
  cmp %1, %2 
  setg cl
%endmacro

%macro @test_gt_r?_r? 2
  @#assert_symbolic_diff %1, %2
  @test_gt_?_? %1, %2
%endmacro

%define @test_gt_r?_const?(a, b) @test_gt_?_? a, b
%define @test_gt_r?_int?(a, b)   @test_gt_?_? a, b
%define @test_gt_r?_uint?(a, b)  @test_gt_?_? a, b