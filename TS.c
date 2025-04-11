#include "TS.h"
#include <string.h>

TypeTS ts[100];  
int CpTS = 0;

const char* keywords[] = {
    "if", "else", "while", "for", "do", "input", "output", "define", "const", "begin", "end", "MainPrgm"
};

int recherche(char *entite) {
    int i = 0;
    while (i < CpTS) {
        if (strcmp(entite, ts[i].NomEntite) == 0)
            return i;  
        i++;
    }
    return -1;
}

void inserer(char *entite, char *code, char *type, Value value) {
    int i;
    for (i = 0; i < sizeof(keywords) / sizeof(keywords[0]); i++) {
        if (strcmp(entite, keywords[i]) == 0) {
            strcpy(ts[CpTS].NomEntite, entite);
            strcpy(ts[CpTS].CodeEntite, code);
            strcpy(ts[CpTS].TypeEntite, "keyword");
            CpTS++;
            return;
        }
    }
    if (recherche(entite) == -1) {
        strcpy(ts[CpTS].NomEntite, entite);
        strcpy(ts[CpTS].CodeEntite, code);
        strcpy(ts[CpTS].TypeEntite, type);

        if (strcmp(type, "int") == 0) {
            ts[CpTS].value.entier = value.entier;
        } else if (strcmp(type, "float") == 0) {
            ts[CpTS].value.floatval = value.floatval;  
        }

        CpTS++;
    }
}

void afficher() {
    printf("\n/*************** Table des symboles ******************/\n");
    printf("_________________________________________________________\n");
    printf("\t| %-10s | %-12s | %-8s | %-6s |\n", "NomEntite", "CodeEntite", "Type", "Value");
    printf("_________________________________________________________\n");
    int i;
    for (i = 0; i < CpTS; i++) {
        if (strcmp(ts[i].TypeEntite, "int") == 0) {
            printf("\t| %-10s | %-12s | %-8s | %-6d |\n", ts[i].NomEntite, ts[i].CodeEntite, ts[i].TypeEntite, ts[i].value.entier);
        } else if (strcmp(ts[i].TypeEntite, "float") == 0) {
            printf("\t| %-10s | %-12s | %-8s | %-6.2f |\n", ts[i].NomEntite, ts[i].CodeEntite, ts[i].TypeEntite, ts[i].value.floatval);
        } else if (strcmp(ts[i].TypeEntite, "keyword") == 0) {
            printf("\t| %-10s | %-12s | %-8s | %-6s |\n", ts[i].NomEntite, ts[i].CodeEntite, ts[i].TypeEntite, "N/A");
        }
    }
    printf("_________________________________________________________\n");
}
