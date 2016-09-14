%macro @macro_call 1
  %ifmacro %1
    %1 
  %elifdef %1
    %1()
  %else
    %error %[%1] is undefined
  %endif
%endmacro

%macro @macro_call 2
  %ifmacro %1
    %1 %2
  %elifdef %1
    %1(%2)
  %else
    %error %[%1] is undefined
  %endif
%endmacro

%macro @macro_call 3
  %ifmacro %1
    %1 %2, %3
  %elifdef %1
    %1(%2, %3)
  %else
    %error %[%1] is undefined
  %endif
%endmacro

%macro @macro_call 4
  %ifmacro %1
    %1 %2, %3, %4
  %elifdef %1
    %1(%2, %3, %4)
  %else
    %error %[%1] is undefined
  %endif
%endmacro