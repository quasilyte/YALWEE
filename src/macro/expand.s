;; %1 -- macro to expand
;; %2 -- range lower bound  
;; %3 -- range upper bound
%macro @expand_range 3
  %assign %%i %2

  %rep %3 
    %if %%i > %3
      %exitrep 
    %endif

    %1 %%i ;; macro passed given macro

    %assign %%i (%%i + 1)
  %endrep
%endmacro

;; %1 -- macro or expression to expand 
;; %* -- argument list to be iterated
%macro @expand_list 1-*
  %define m %1
  %rotate 1

  %rep %0-1
    %[m] %1

    %rotate 1
  %endrep
%endmacro

;; %1 -- macro or expression to expand
;; %2 -- range lower bound
;; %3 -- range upper bound 
;; %* -- argument list to be iterated
%macro @expand_list_range 3-*
  %define m %1  
  %define low %2
  %define high %3
  %rotate 3
  
  %rep %0-3
    @expand_range {%[m] %1,}, low, high
    %rotate 1
  %endrep
%endmacro

%macro @expand_r? 1
  @expand_range %1, 0, R_COUNT
%endmacro

%macro @expand_e? 1
  @expand_range %1, 0, E_COUNT
%endmacro

%macro @expand_imm? 1
  @expand_list %1, 8, 32, 64
%endmacro

%macro @expand_r?_imm? 1
  %assign %%i 0
  %rep R_COUNT
    @expand_list {%1 %%i,}, 8, 32, 64
    %assign %%i (%%i + 1)
  %endrep
%endmacro
