%macro @test_eq_?_? 2
  cmp %1, %2 
  sete cl
%endmacro

%macro @test_eq_r?_r? 2
  @#assert_symbolic_diff %1, %2
  @test_eq_?_? %1, %2
%endmacro

%define @test_eq_r?_const?(a, b) @test_eq_?_? a, b
%define @test_eq_r?_int?(a, b)   @test_eq_?_? a, b
%define @test_eq_r?_uint?(a, b)  @test_eq_?_? a, b
