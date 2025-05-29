//The client sends a file name to the server, and the server returns to the client the names of all directories that contain the specified file.
//NOTE: The client and server are two processes
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <dirent.h>
#include <sys/stat.h>

#define BUF_SIZE 1024

// Recursively search for files named `target` starting from `dir`.
// Write matching directory names to `out_fd`.
void search(const char *dir, const char *target, int out_fd) {
    DIR *dp = opendir(dir);
    if (!dp){
        perror("Error opening dir");
        return;
    }

    struct dirent *entry;//pointer to a directory entry
    char path[BUF_SIZE];

    while ((entry = readdir(dp)) != NULL) {     //readdir reads the nest entry in the directory
        // Skip current and parent directory entries
        if (strcmp(entry->d_name, ".") == 0 || strcmp(entry->d_name, "..") == 0)
            continue;

        snprintf(path, sizeof(path), "%s/%s", dir, entry->d_name);      //build the full path to the file

        struct stat st;         //used to store information about file or directory
        if (stat(path, &st) == -1) continue;        //fails if the file does not exists

        if (S_ISDIR(st.st_mode)) {      //checks if it is a directory
            // Recurse into subdirectory
            search(path, target, out_fd);
        } else if (S_ISREG(st.st_mode)) {       //checks if it is a regular file
            // If the file matches the target filename
            if (strcmp(entry->d_name, target) == 0) {
                // Write directory path to pipe
                dprintf(out_fd, "%s\n", dir);
            }
        }
    }

    closedir(dp);
}

int main() {
    int pipe1[2]; // client -> server
    int pipe2[2]; // server -> client

    if (pipe(pipe1) == -1 || pipe(pipe2) == -1) {
        perror("pipe");
        exit(EXIT_FAILURE);
    }

    pid_t pid = fork();

    if (pid < 0) {
        perror("fork");
        exit(EXIT_FAILURE);
    }

    if (pid == 0) {
        //Server process
        close(pipe1[1]); // close write end of pipe1
        close(pipe2[0]); // close read end of pipe2

        char filename[BUF_SIZE];
        read(pipe1[0], filename, BUF_SIZE);
        filename[strcspn(filename, "\n")] = 0; // remove newline

        // Start search from current directory
        search(".", filename, pipe2[1]);

        close(pipe1[0]);
        close(pipe2[1]);
    } else {
        //Client process
        close(pipe1[0]); // close read end of pipe1
        close(pipe2[1]); // close write end of pipe2

        char filename[BUF_SIZE];
        printf("Enter filename to search: ");
        fgets(filename, BUF_SIZE, stdin);

        // Send filename to server
        write(pipe1[1], filename, strlen(filename) + 1);

        // Read results from server
        char buffer[BUF_SIZE];
        printf("\nDirectories containing '%s':\n", filename);
        ssize_t bytes_read;     //ssize_t = signed size type
        while ((bytes_read = read(pipe2[0], buffer, sizeof(buffer)-1)) > 0) {
            buffer[bytes_read] = '\0';
            printf("%s", buffer);
        }

        close(pipe1[1]);
        close(pipe2[0]);
    }

    return 0;
}
