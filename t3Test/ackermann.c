#include <stdio.h> 
#include <time.h>

int procedureCalls = 0;
int procedureReturns = 0;
int max = 0;
int currentLevel = 0;

int overflows = 0;
int underflows = 0;
int windowCount = 2;    //Is '2' due to a window being taken up for the main function and the intial call to ackermann.
//int regWindows = 6;
//int regWindows = 8;
int regWindows = 16;
int returnVal;

int ackermann(int x, int y)
{
    procedureCalls++;
    currentLevel = procedureCalls - procedureReturns;
    if (max < currentLevel)
    {
        max = currentLevel;
    }
    if (windowCount == regWindows) 
    {
        overflows++;
    }
    else 
    {
        windowCount++;
    }
    /***********************************************************************/
    
    if (x == 0) 
    {
        returnVal = y+1;
    } 
    else if (y == 0)
    { 
        returnVal = ackermann(x-1,1);
    }
    else
    { 
        returnVal = ackermann(x-1, ackermann(x, y-1));
    }
    /***********************************************************************/
    procedureReturns++;
    if (windowCount == 2) 
    {
        underflows++;
    }
    else 
    {
        windowCount--;
    }
    return returnVal;   
} 


int ackermannRel(int x, int y)
{ 
    if (x == 0) {
        return y+1;
    }
    else if (y == 0) { 
        return ackermann(x-1, 1);
    } 
    else { 
        return ackermann(x-1, ackermann(x, y-1));
    } 
} 

int main(int argc, char** argv)
{
    int result = ackermann(3,6);
    printf("\nResult = %d",result);
    printf("\nCalls = %d",procedureCalls);
    printf("\nReturns = %d",procedureReturns);
    printf("\nMaxDepth = %d",max);
    printf("\nOverflows = %d",overflows);
    printf("\nUnderflows = %d\n\n",underflows);
    
    clock_t start = clock();
    int temp = ackermannRel(3,6);
    clock_t end = clock();
    double cpu_time_used_1 = ((double) (end - start)) / CLOCKS_PER_SEC;
    printf("Took %f seconds to execute \n", cpu_time_used_1);
    
    start = clock();
    temp = ackermannRel(3,6);
    end = clock();
    double cpu_time_used_2 = ((double) (end - start)) / CLOCKS_PER_SEC;
    printf("Took %f seconds to execute \n", cpu_time_used_2);
    
    start = clock();
    temp = ackermannRel(3,6);
    end = clock();
    double cpu_time_used_3 = ((double) (end - start)) / CLOCKS_PER_SEC;
    printf("Took %f seconds to execute \n", cpu_time_used_3);
    
    double average = (cpu_time_used_1 + cpu_time_used_2 + cpu_time_used_3)/3; 
    printf("Average time = %f seconds \n\n", average);
    
    return 0;
}



















