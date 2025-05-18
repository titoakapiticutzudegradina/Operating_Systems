//Write a C Program that deletes from a file the bytes from even offsets. The name of the file is provided as a command line argument.

#include <stdio.h>

int main(int argc, char *argv[]){
    //Check if the file name is given as an argument
    if(argc != 2){
        printf("Usage: %s <filename>\n", argv[0]);
        return 1;
    }

    //Open the file in read mode
    FILE *file = fopen(argv[1], "rb");   //rb is from read binary
    if(file == NULL){
        perror("Error opening file");
        return 1;
    }

    //Temporary file to put the modified content
    FILE *tempF = fopen("tempfile", "wb");  //wb is from write binary
    if(file == NULL) {
        perror("Error creating the temporary file");
        fclose(file);   //Closing the successfully opened file before we exit the program
        return 1;
    }

    int byte;
    int offset = 0;
    //Read byte by byte until the end of our file
    //fgetc() - read a single character(byte) from the file
    while((byte = fgetc(file)) != EOF){
        if(offset % 2 !=0 ) {   //Check if the offset is odd
            //fputc() - write a single character(byte) to a file
            fputc(byte, tempF);    //We get from the file only the information we want (i.e. the bytes from odd offsets)
        }
        offset++;
    }

    //Close the files
    fclose(file);
    fclose(tempF);

    //Remove the file given as a parameter
    if(remove(argv[1]) != 0){   //remove() returns 0 if the file is successfully deleted
        perror("Error deleting the original file");
        return 1;
    }

    //Rename the temporary file to the original file name
    if(rename("tempfile",argv[1]) != 0){   //rename() returns 0 if the file is successfully renamed
        perror("Error for renaming the temporary file");
        return 1;
    }
}
