%define size_is_valid(x) x == 8 || x == 16 || x == 32 || x == 64
%define size_error(x) invalid size given. expected {8, 16, 32, 64}, %[x] given

%macro @#assert_nz 1
  %if %1 = 0
    %error assert not zero failed
  %endif
%endmacro

%macro @#assert_size 1
  %if !size_is_valid(%1)
    %error size_error(%1)
  %endif
%endmacro

%macro @#assert_numeric_diff 2
  %if %1 = %2
    %error numeric diff assertion failed
  %endif
%endmacro

%macro @#assert_symbolic_diff 2
  %defstr %%a_str %1
  %defstr %%b_str %2

  %if %%a_str = %%b_str
    %error symbolic diff assertion failed (%[%1] = %[%2])
  %endif
%endmacro 
