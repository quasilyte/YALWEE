#include <stdio.h>

#include <c_api/mnemonics.h>

extern void eval(const char* code);

void read_regs(long* dest); 
void reset_regs(void);
void set_reg(int n, long value);
void print_regs(void);
void init(void);

char loop_code[] = { 
  FILL_R0_BY_IMM8(10),
  FILL_R1_BY_IMM8(-2),
  MUL_R0_BY_R1,
  MUL_R0_BY_IMM8(-1),

  // PREPARE4_E1,
  //   INC_R0_BY_1,
  //   INC_R0_BY_1,
  //   INC_R0_BY_1,
  //   INC_R1_BY_1,
  // INC_R0_BY_IMM32(0x7F, 0x96, 0x98, 0),  
  // FOR_NZ_START_BY_R0(-1, 4, 0, 0, 0),
  //   PREPARE4_E0, 
  //     INC_R0_BY_1, 
  //     INC_R1_BY_1, 
  //     DEC_R3_BY_1, 
  //     DEC_R2_BY_1,
  // END_FOR_NZ,

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
  __asm("mov %%r11, %0" :"=r" (value));
  dest[3] = value;
}

void reset_regs(void) {
  __asm(
    "xor %r8, %r8\n"
    "xor %r9, %r9\n"
    "xor %r10, %r10\n"
    "xor %r11, %r11\n"
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
  case 3: 
    __asm("mov %0, %%r11\n" ::"r" (value));
    return;  
  }
}

void print_regs(void) {
  long regs[4];
  read_regs(regs);

  for (int i = 0; i < 4; ++i) {
    printf("r[%d] = %ld\n", i, regs[i]);
  }
}
