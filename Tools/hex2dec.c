/*
 Hex2Dec conversion tool.
 2018, Douglas Berdeaux, WeakNet Labs
 Decription: Provide hex as "0x0..0xfff" format and get decimal value.
*/
#include<stdio.h>
#include<stdlib.h> // str 2 ul
int main(int *argc,char ** argv){
 if(argc==2){
  printf("dec: %d\n",strtoul(argv[1],0,16));
 }else{
  printf("\nhex2dec: WeakNetLabs\n[!] You must provide input as a hexadecimal value.\n[?] e.g: './hex2dec 0xaf3'\n\n");
   return 1;
 }
 return 0;
}
