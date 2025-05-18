//We have a file that contains N integer numbers. Using two types of processes
//(one for determining the minimum and the other to determine the maximum value from an array),
// write a program that determines the kth element in increasing order of the integer array, without sorting the array.

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <limits.h>
#include <sys/wait.h>

#define MAX_SIZE 1000

//Function that reads numbers from the file
int read_numbers(const char *filename, int *arr){
    FILE *file = fopen(filename, "r");
    if(file == NULL){
        perror("Faild to open the file");
        exit(1);
    }

    int count = 0;
    //read one number from the file and store it in arr[count]
    while(fscanf(file, "%d", &arr[count]) == 1){
        count++;
    }

    fclose(file);
    return count;
}

//Forked process to find the next minimum > current_min
int find_next_min(int *arr, int n, int current_min){
    int pipefd[2];
    pipe(pipefd);// pipefd[0]-read end of the pipe, pipefd[1]-write end of the pipe

    //Creating a child process  (pid == 0 child pid > 0 parent)
    pid_t pid = fork();
    if(pid == 0){
        //Child process
        close(pipefd[0]); //the child only writes so we close the read end of the pipe
        //Simple for loop to the next elemnt in the array without sorting
        int min = INT_MAX;
        for(int i = 0; i < n; i++){
            if(arr[i] > current_min && arr[i] < min){
                min = arr[i];
            }
        }
        //Child process writes the next element of the array
        write(pipefd[1], &min, sizeof(int));
        //Close the write end part of the pipe
        close(pipefd[1]);
        //Terminate the child process
        exit(0);
    }else{
        //Parent process
        close(pipefd[1]);  //Close the write end of the pipe because the parent needs only the read end
        int min;
        //The parent process reads the min computed by the child
        read(pipefd[0],&min,sizeof(int));
        //Close the read end part of the pipe
        close(pipefd[0]);
        //Waits for the child process to terminate,(NULL) without caring about the exit status
        wait(NULL);
        return min;
    }
}

int main(int argc, char *argv[]){
    //Check the number of arguments
    if(argc != 3){
        fprintf(stderr, "Usage: %s <k> <filename>\n", argv[0]);
        return 1;
    }
    int k = atoi(argv[1]); //atoi() - ascii to integer
    const char *filename = argv[2];  //the filename

    //read the array from the file
    int arr[MAX_SIZE];
    int n = read_numbers(filename, arr);

    //Check the value of k to be in the range
    if(k < 1 || k > n){
        fprintf(stderr, "Error: k must be between 1 and %d\n", n);
        return 1;
    }

    //for loop to find the kth elemnt in ascending order
    int current_min = INT_MIN;
    int kth = INT_MIN;

    for(int i = 0; i<k; i++){
        kth = find_next_min(arr, n, current_min);
        current_min = kth;
    }

    //print results
    printf("The %d-th smallest elemnt is: %d\n", k, kth);
    return 0;
}
