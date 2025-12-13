#include <stdio.h>

int main(int arc, char** argv)
{
    for(int i = 0; i < arc; i++)
    {
        printf("%s\n", argv[i]);
    }
}
