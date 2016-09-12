#include <stdio.h>
#include <stdlib.h>

extern void eval(const char* code);

void read_regs(long* dest); 
void reset_regs(void);
void set_reg(int n, long value);
void print_regs(void);
void init(void);
const char* slurp(const char* path);

int main(void) {
  const char* wordcode = slurp("data/wordcode.txt");

  init();
  set_reg(0, 10);
  eval(wordcode);
  print_regs();

  return 0;
}

void init(void) {
  reset_regs();
}

const char* slurp(const char* path) {
  FILE* file = fopen(path, "rb"); 
  if (!file) {
    printf("file not found: `%s'\n", path);
    exit(1);
  }

  fseek(file, 0, SEEK_END);
  size_t file_size = ftell(file);
  rewind(file);

  char* data = malloc(file_size);
  fread(data, file_size, 1, file);

  fclose(file);
  return data;
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
