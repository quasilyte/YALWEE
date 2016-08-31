#include <stdio.h>
#include <stdlib.h>

extern int eval(const char* code);

#define EXIT "\x00\x00"
#define IACC_ADD_R1 "\x01\x00"
#define IACC_ADD_R2 "\x02\x00"
#define IACC_LOAD_R1 "\x03\x00"
#define IACC_LOAD_R2 "\x04\x00"
#define IACC_SAVE_R1 "\x05\x00"
#define IACC_SAVE_R2 "\x06\x00"
#define IRESET_R0 "\x07\x00"
#define IRESET_R1 "\x08\x00"
#define IRESET_R2 "\x09\x00"
#define IMOVE_R0_TO_R1 "\x0A\x00"
#define IMOVE_R0_TO_R2 "\x0B\x00"
#define IMOVE_R1_TO_R0 "\x0C\x00"
#define IMOVE_R1_TO_R2 "\x0D\x00"
#define IMOVE_R2_TO_R0 "\x0E\x00"
#define IMOVE_R2_TO_R1 "\x0F\x00"
#define IMOVE_8_TO_R0(BYTE) "\x10\x00" BYTE
#define IMOVE_8_TO_R1(BYTE) "\x11\x00" BYTE
#define IMOVE_8_TO_R2(BYTE) "\x12\x00" BYTE
#define IJMPZ_R0(POS) "\x13\x00" POS
#define IJMPZ_R1(POS) "\x14\x00" POS
#define IJMPZ_R2(POS) "\x15\x00" POS

void read_regs(long* dest) {
  long value;
  
  __asm("mov %%r8, %0" :"=r" (value));
  dest[0] = value;
  __asm("mov %%r9, %0" :"=r" (value));
  dest[1] = value;
  __asm("mov %%r10, %0" :"=r" (value));
  dest[2] = value;
}

void set_ir(int n, long value) {
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

void reset_regs(void) {
  __asm(
    "xor %r8, %r8\n"
    "xor %r9, %r9\n"
    "xor %r10, %r10\n"
  );
}

extern int foo;

const char* code =
  IJMPZ_R1("\x0D\x00\x00\x00\x00\x00\x00\x00")
  IMOVE_8_TO_R0("\xFF")
  IMOVE_8_TO_R0("\x03")
  EXIT;

extern const char* code_root;

int main() {
  reset_regs();

  // set_ir(1, 10);
  set_ir(2, 15);

  eval(code);
  
  long irs[3];
  read_regs(irs);

  for (int i = 0; i < 3; ++i) {
    printf("ir[%d] = %ld\n", i, irs[i]);
  }
  
  return 0;
}
