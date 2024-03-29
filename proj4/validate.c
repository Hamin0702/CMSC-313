// Hamin Han, XK26538, haminh1@gl.umbc.edu
// c file that is used by main.asm
// Contains the read, display, replace, and free subroutines

// Including libraries 
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <sys/wait.h>
#include <ctype.h>
#include <math.h>
#include <stdbool.h>
#include <time.h>
#include <string.h>


int counter = 0;
int element = 0;
int boolFreeAll = 0;

// Find and replace function
void findReplace(char * main_str, char * seq, char * rep){

  // Setting up the strings 
  char string[strlen(main_str)];
  char sequence[strlen(seq)];
  char replacement[strlen(rep)];

  strcpy(string, main_str);
  strcpy(sequence, seq);
  strcpy(replacement, rep);
  
  
  // Points to the first character where the sequence occurs, null if no sequence can be found	      
  char *ptr = strstr(string, sequence);

  // Loop to replace the sequence
  while(ptr != NULL){

    int i = 0;
    while(replacement[i] != '\0'){

      ptr[i] = replacement[i];
      i++;
    }

    ptr = strstr(string, sequence);
  }
	      
  printf("The new text is: %s\n\n", string);

}

// Easter egg function
void easterEgg(){

  counter++;

  if(counter == 4){
    printf("EASTER EGG!!\n");

    // Print picture
    printf("▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓\n");
    printf("▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓\n");
    printf("▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓\n");
    printf("▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓\n");
    printf("▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓\n");
    printf("▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓\n");
    printf("▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓██████▓▓██████████▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓████████▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓\n");
    printf("▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓██    ██████▒▒▒▒▒▒▒▒██▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓██        ██▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓\n");
    printf("▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓██          ▒▒▒▒▒▒▒▒▒▒▒▒██▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓██        ▒▒▒▒██▓▓▓▓▓▓▓▓▓▓▓▓▓▓\n");
    printf("▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓██    ██    ▒▒▒▒▒▒██████▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓██▒▒▒▒      ▒▒▒▒▒▒██▓▓▓▓▓▓▓▓▓▓▓▓\n");
    printf("▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓██          ▒▒▒▒██▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓██▒▒▒▒      ▒▒▒▒▒▒██▓▓▓▓▓▓▓▓▓▓▓▓\n");
    printf("▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓████      ▒▒▒▒██▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓██▒▒▒▒▒▒        ▒▒▒▒  ██▓▓▓▓▓▓▓▓▓▓\n");
    printf("▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓██▒▒▒▒▒▒▒▒▒▒▒▒██▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓██▒▒▒▒                ██▓▓▓▓▓▓▓▓▓▓\n");
    printf("▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓██▒▒▒▒▒▒▒▒▒▒██▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓██          ▒▒▒▒▒▒        ██▓▓▓▓▓▓▓▓\n");
    printf("▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓████▒▒▒▒▒▒  ██▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓██        ▒▒▒▒▒▒▒▒▒▒      ██▓▓▓▓▓▓▓▓\n");
    printf("▓▓▓▓▓▓▓▓▓▓██▓▓████▒▒▒▒▒▒    ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓██▒▒▒▒    ▒▒▒▒▒▒▒▒▒▒      ██▓▓▓▓▓▓▓▓\n");
    printf("▓▓▓▓▓▓▓▓▓▓████▒▒▒▒▒▒▒▒      ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓██▒▒▒▒▒▒  ▒▒▒▒▒▒▒▒▒▒  ▒▒▒▒██▓▓▓▓▓▓▓▓\n");
    printf("▓▓▓▓▓▓▓▓▓▓██▒▒▒▒▒▒▒▒        ██▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓██▒▒▒▒    ▒▒▒▒▒▒  ▒▒▒▒██▓▓▓▓▓▓▓▓▓▓\n");
    printf("▓▓▓▓▓▓▓▓▓▓██▒▒████████████    ██▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓██▒▒▒▒            ▒▒▒▒██▓▓▓▓▓▓▓▓▓▓\n");
    printf("▓▓▓▓▓▓▓▓▓▓██  ██▒▒▒▒▒▒▒▒██      ████▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓██              ▒▒██▓▓▓▓▓▓▓▓▓▓▓▓\n");
    printf("▓▓▓▓▓▓▓▓▓▓▓▓████▒▒▒▒▒▒▒▒  ████      ██▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓████        ████▓▓▓▓▓▓▓▓▓▓▓▓▓▓\n");
    printf("▓▓▓▓▓▓▓▓▓▓▓▓▓▓████████████████████████▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓████████▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓\n");
    printf("▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓\n");
    printf("▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓\n");
    printf("▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓\n");
    printf("▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓\n");
    printf("▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓\n");
    printf("▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓\n");
    printf("Image from textart.sh\n\n");
    
    // Print definitions
    printf("Definition: \n");
    printf("\"1. a hard-boiled egg that is dyed and often decorated as part of the Easter celebration\"\n");
    printf("\"2. an unexpected or undocumented feature in a piece of computer software or on a DVD, included as a joke or a bonus\"\n\n");
    counter = 0;
  }else{
    printf("Invalid option! Try again!\n\n");
  }

}

// Find the length of the string
int stringLength(char * str){

  return strlen(str);

}

// Generates a random number
int randomNumber(){

  int max = 10, min = 1;
  
  srand(time(0));
  int num = rand() % ((max + 1) - min) + min;
  return num;
  
}

// Displays all contents of the array
void display(char *arr[]){
  
  for (int i = 0; i < 10; ++i){
    printf("[%d]: %s\n", i, arr[i]);
  }

  printf("\n");
  
}

// Update the array with user input
void update(char *arr[], char * msg){
  
  arr[element] = msg;
  element++;

  if(element == 10){
    element = 0;
    boolFreeAll = 1;
  }
  
}

// Reads the message from user and make sure it follows the criterias
int checkMsg(char * messages){

  int last = strlen(messages) - 1;
  
  // If the first letter is not a capital letter, returns 0 
  if(!isupper(messages[0])){
    return 0;
  }

  // If the last letter doesn't end with either '.' '?' or '!', returns 0
  if(messages[last] != '.' &&  messages[last] != '?' &&  messages[last] != '!'){
    return 0;
  }

  // Returns 1 if the string is valid  
  return 1;
  
}

// Reads in a message from user and makes sure it can be any length
char * validate(){

  int buffer = 256;
  int position = 0;

  // Create a string of size = buffer chars (256 chars)
  char* cmd = malloc(sizeof(char) * buffer);

  // Init variable for current character and loop control var
  int cha;
  int cont = 1;

  while (cont == 1){

    // Get input from stdin char by char
    cha = fgetc(stdin);

    // If current cha is the End of FIle or newline character
    if (cha == EOF || cha == '\n'){

      // Null terminate string and break loop
      cmd[position] = '\0';
      cont = 0;

    }else{

      // Set index in command string equal to current char
      cmd[position] = cha;
    }

    // Increment to next position
    position++;

    // If size of string exceeds currently allocated space
    if (position >= buffer){

      // Increase buffer size by 1 buffer and reallocate
      buffer += 256;
      cmd = realloc(cmd, buffer);
    } 
  }

  return cmd;

}

// Frees up all the memory allocated by validate
void freeUp (char * arr[]){

  if(boolFreeAll == 1){
    for(int i = 0; i < 10; i++){
      free(arr[i]);
    }
  }else if(element > 0){
    for(int i = 0; i < element; i++){
      free(arr[i]);
    }
  }
}
