%macro @test_neq_?_? 2
  cmp %1, %2 
  setne cl
%endmacro

%macro @test_neq_r?_r? 2
  @#assert_symbolic_diff %1, %2
  @test_neq_?_? %1, %2
%endmacro

%define @test_neq_r?_const?(a, b) @test_neq_?_? a, b
%define @test_neq_r?_int?(a, b)   @test_neq_?_? a, b
%define @test_neq_r?_uint?(a, b)  @test_neq_?_? a, b
