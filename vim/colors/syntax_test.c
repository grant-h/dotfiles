#define FALSE 0
#include <stdio.h>

/* This is a large comment
 * Author: grant
 */

int main(int argc, char * argv[])
{
  if(argc < 3)
  {
    printf("Usage: ./%s <arg1> <arg2>\n", argv[0]);
    return 1;
  }
  
  for(int i = 0; i < strlen(argv[1]); i++)
  {
    printf("%c", 'A');
  }

  bool hey = false;
  hey = NULL;
  return 0;
}
