%define size_is_valid(x) (x == 8 || x == 16 || x == 32 || x == 64)
%define size_error(x) invalid size given. expected {8, 16, 32, 64}, %[x] given
