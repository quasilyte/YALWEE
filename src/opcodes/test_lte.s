%macro @test_lte_?_? 2
  cmp %1, %2 
  setle cl
%endmacro

%macro @test_lte_r?_r? 2
  @#assert_symbolic_diff %1, %2
  @test_lte_?_? %1, %2
%endmacro

%define @test_lte_r?_const?(a, b) @test_lte_?_? a, b
%define @test_lte_r?_int?(a, b)   @test_lte_?_? a, b
%define @test_lte_r?_uint?(a, b)  @test_lte_?_? a, b