#include <stdio.h>
#include <stdlib.h>
void bubble_sort_deciaml(int arr[],int size_arr)
{
    int temp=0;
    for(int m=0; m<size_arr; m++)
    {
        for(int i=0; i<(size_arr-1); i++)
        {
            if(arr[i]>arr[i+1])
            {
                temp=arr[i];
                arr[i]=arr[i+1];
                arr[i+1]=temp;
            }
        }
    }

}
void bubble_sort_char(char arr2[],int size_arr)
{
    int arr[size_arr];
    for(int i=0; i<size_arr; i++)
    {
        arr[i]=(int)arr2[i];
    }
    int temp=0;
    for(int m=0; m<size_arr; m++)
    {
        for(int i=0; i<(size_arr-1); i++)
        {
            if(arr[i]>arr[i+1])
            {
                temp=arr[i];
                arr[i]=arr[i+1];
                arr[i+1]=temp;
            }
        }
    }
    for(int j=0; j<size_arr; j++)
    {
        arr2[j]=arr[j];
    }
}
int min_selection_sort(int arr[],int size_arr)
{
    int temp=arr[0],index=0;
    for(int i=0; i<size_arr; i++)
    {
        if(arr[i]<temp)
        {
            temp=arr[i];
            index=i;
        }
    }
    arr[index]=2147483647;
    return temp;
}
void Selection_Sort_decimal(int arr[],int size_arr)
{
    int arr2[size_arr];
    for(int i=0; i<size_arr; i++)
    {
        arr2[i]=min_selection_sort(arr,size_arr);
    }
    for(int m=0; m<size_arr; m++)
    {
        arr[m]=arr2[m];
    }

}
void Selection_Sort_char(char arr4[],int size_arr)
{
    int arr[size_arr];
    for(int i=0; i<size_arr; i++)
    {
        arr[i]=(int)arr4[i];
    }
    int arr2[size_arr];
    for(int i=0; i<size_arr; i++)
    {
        arr2[i]=min_selection_sort(arr,size_arr);
    }
    for(int m=0; m<size_arr; m++)
    {
        arr[m]=arr2[m];
    }
    for(int j=0; j<size_arr; j++)
    {
        arr4[j]=arr[j];
    }

}
int binary_search_decimal(int arr[],int size_ar,int ele)
{
    int f=size_ar/2;
    if(ele==arr[f])
    {
        return f;
    }
    else if(ele<arr[f])
    {
        for(int i=f-1; i>=0; i--)
        {
            if(arr[i]==ele)
            {
                return i;
            }
        }
    }
    else
    {
        for(int i=f+1; i<size_ar; i++)
        {
            if(arr[i]==ele)
            {
                return i;
            }
        }
    }
    return -1;
}
int binary_search_char(char arr2[],int size_ar,char v[],int s)
{
    int ele;
    ele=(int)v[0];
    int f=size_ar/2;
    int arr[size_ar];
    for(int i=0; i<size_ar; i++)
    {
        arr[i]=(int)arr2[i];
    }
    if(arr[f]==ele)
    {
        return f;
    }
    else if(ele<arr[f])
    {
        for(int i=f-1; i>-1; i--)
        {
            if(arr[i]==ele)
            {
                return i;
            }
            else
            {

            }
        }
    }
    else if(arr[f]<ele)
    {
        for(int i=f+1; i<size_ar; i++)
        {
            if(arr[i]==ele)
            {
                return i;
            }
            else
            {

            }
        }
    }
    else
    {
        return -1;
    }
    return -1;
}
int main()
{
    int flag;
    printf("\nEnter -1 to exit otherwise but int execution will be done\n");
    scanf("%d",&flag);
    while(flag!=-1)
    {
        int size_arr_all;
        printf("Enter The Size Of the Array:\n");
        scanf("%d",&size_arr_all);
        printf("\n Enter the array type \n 1 to int \n 2 to char\n");
        int type;
        scanf("%d",&type);
        if(type==1)
        {
            printf("Enter the array one by one\n");
            int arr[size_arr_all];
            for(int i=0; i<size_arr_all; i++)
            {
                scanf("%d",&arr[i]);
            }
            printf("Successful Array Values\n");
            printf("Enter The operation you want do\n 1 to selection sort\n 2 to bubble sort\n ");
            int op=0;
            scanf("%d",&op);
            if(op==1)
            {
                printf("Array Before Selection Sort\n");
                for(int p=0; p<size_arr_all; p++)
                {
                    printf("%d \t",arr[p]);
                }
                printf("\n\n\n");
                Selection_Sort_decimal(arr,size_arr_all);
                printf("Array After Selection Sort\n");
                for(int p=0; p<size_arr_all; p++)
                {
                    printf("%d \t",arr[p]);
                }
                printf("\nIf You Want To Search With Binary Search \nPress 1\n");
                int flag11=0;
                scanf("%d",&flag11);
                if(flag11==1)
                {
                    printf("Enter The Value Of The Element That You Want To Search For\n");
                    int bi=0;
                    scanf("%d",&bi);
                    int g= binary_search_decimal(arr,size_arr_all,bi);
                    if(g!=-1)
                    {
                        printf("Found In Index %d\n",g);
                    }
                    else
                    {
                        printf("Not Found Element\n");
                    }
                }
            }
            else if(op==2)
            {
                printf("Array Before Selection Sort\n");
                for(int p=0; p<size_arr_all; p++)
                {
                    printf("%d \t",arr[p]);
                }
                printf("\n\n\n");
                bubble_sort_deciaml(arr,size_arr_all);
                printf("Array After Selection Sort\n");
                for(int p=0; p<size_arr_all; p++)
                {
                    printf("%d \t",arr[p]);
                }
                printf("\nIf You Want To Search With Binary Search \nPress 1\n");
                int flag11=0;
                scanf("%d",&flag11);
                if(flag11==1)
                {
                    printf("Enter The Value Of The Element That You Want To Search For\n");
                    int bi=0;
                    scanf("%d",&bi);
                    int g= binary_search_decimal(arr,size_arr_all,bi);
                    if(g!=-1)
                    {
                        printf("Found In Index %d\n",g);
                    }
                    else
                    {
                        printf("Not Found Element\n");
                    }
                }
            }
            else
            {
            }
        }
        else
        {
            printf("Enter the array all together \n");
            char arr9[size_arr_all];
            scanf("%s",arr9);
            printf("Successful Array Values\n");
            printf("Enter The operation you want do \n 1 to selection sort\n 2 to bubble sort\n ");
            int op7=0;
            scanf("%d",&op7);
            if(op7==1)
            {
                printf("Array Before Selection Sort\n");
                for(int p=0; p<size_arr_all; p++)
                {
                    printf("%c \t",arr9[p]);
                }
                printf("\n\n\n");
                Selection_Sort_char(arr9,size_arr_all);
                printf("Array After Selection Sort\n");
                for(int p=0; p<size_arr_all; p++)
                {
                    printf("%c \t",arr9[p]);
                }
                printf("\nIf You Want To Search With Binary Search \nPress 1\n");
                int flag11=0;
                scanf("%d",&flag11);
                if(((flag11)==1))
                {
                    printf("Enter The Value Of The Element That You Want To Search For\n");
                    char bi[1];
                    scanf("%s",bi);
                    int g;
                    g= binary_search_char(arr9,size_arr_all,bi,1);
                    if(g==-1)
                    {
                        printf("Not Found Element\n");
                    }
                    else
                    {
                        printf("Found In Index %d\n",g);
                    }
                }
                else
                {
                }
            }
            else if(op7==2)
            {
                printf("Array Before Bubble Sort\n");
                for(int p=0; p<size_arr_all; p++)
                {
                    printf("%c \t",arr9[p]);
                }
                printf("\n\n\n");
                bubble_sort_char(arr9,size_arr_all);
                printf("Array After Bubble Sort\n");
                for(int p=0; p<size_arr_all; p++)
                {
                    printf("%c \t",arr9[p]);
                }
                printf("\nIf You Want To Search With Binary Search \nPress 1\n");
                int flag11=0;
                scanf("%d",&(flag11));
                if(flag11==1)
                {
                    printf("Enter The Value Of The Element That You Want To Search For\n");
                    char bi[1];
                    scanf("%s",bi);
                    int g= binary_search_char(arr9,size_arr_all,bi,1);
                    if(g!=-1)
                    {
                        printf("Found In Index %d\n",g);
                    }
                    else
                    {
                        printf("Not Found Element\n");
                    }
                }
            }
            else
            {
            }
        }
        printf("\nEnter -1 to exit otherwise but int execution will be done\n");
        scanf("%d",&flag);
    }
    return 0;
}
