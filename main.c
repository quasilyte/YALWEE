#include <stdio.h>

#include <c_api/mnemonics.h>

extern void eval(const char* code);

void read_regs(long* dest); 
void reset_regs(void);
void set_reg(int n, long value);
void print_regs(void);
void init(void);

char loop_code[] = {
  INC_R1_BY_IMM32(0x7f, 0x96, 0x98, 0x00),

  FOR_NZ_START_BY_R1(-1, 4, 0, 0, 0),
    INC_R0_BY_1,     
  END_FOR_NZ,
  
  INC_R7_BY_1,

  EXIT,
};

int main(void) {
  init();
  eval(loop_code);
  print_regs();
  return 0;
}

void init(void) {
  reset_regs();
}

void read_regs(long* dest) {
  long value;
  
  __asm("mov %%r8, %0" :"=r" (value));
  dest[0] = value;
  __asm("mov %%r9, %0" :"=r" (value));
  dest[1] = value;
  __asm("mov %%r10, %0" :"=r" (value));
  dest[2] = value;
}

void reset_regs(void) {
  __asm(
    "xor %r8, %r8\n"
    "xor %r9, %r9\n"
    "xor %r10, %r10\n"
  );
}

void set_reg(int n, long value) {
  switch (n) {
  case 0: 
    __asm("mov %0, %%r8\n" ::"r" (value));
    return;  
  case 1: 
    __asm("mov %0, %%r9\n" ::"r" (value));
    return; 
  case 2: 
    __asm("mov %0, %%r10\n" ::"r" (value));
    return; 
  }
}

void print_regs(void) {
  long regs[3];
  read_regs(regs);

  for (int i = 0; i < 3; ++i) {
    printf("r[%d] = %ld\n", i, regs[i]);
  }
}