

#ifndef TS_H
#define TS_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// symbols table struct
typedef struct {
    char NomEntite[20];
    char CodeEntite[20];
} TypeTS;

// variables
extern TypeTS ts[100];  
extern int CpTS; 

// functions
void inserer(char entite[], char code[]);
int recherche(char entite[]);
void afficher();

#endif
