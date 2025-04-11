#ifndef TS_H
#define TS_H



#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern const char* keywords[];
#define NUM_KEYWORDS (sizeof(keywords) / sizeof(keywords[0])) 
typedef union {
    int entier;
    float floatval;
} Value;

// symbols table struct
typedef struct {
    char NomEntite[20];  
    char CodeEntite[20];  
    char TypeEntite[10];  
    Value value;             
} TypeTS;

// variables
extern TypeTS ts[100];  
extern int CpTS; 



// functions
void inserer(char *entite, char *code, char *type, Value value);
int recherche(char entite[]);
void afficher();

#endif
