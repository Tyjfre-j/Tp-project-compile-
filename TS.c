

#include "TS.h"

TypeTS ts[100];  
int CpTS = 0;


int recherche(char entite[])
{
int i = 0;
while (i < CpTS)
{
if (strcmp(entite, ts[i].NomEntite) == 0)
return i;
i++;
}

return -1;
}


void inserer(char entite[], char code[])
{
if (recherche(entite) == -1) 
{
strcpy(ts[CpTS].NomEntite, entite);
strcpy(ts[CpTS].CodeEntite, code);
CpTS++;
}
}

void afficher()
{
printf("\n/***************Table des symboles ******************/\n");
printf("____________________________________\n");
printf("\t| NomEntite | CodeEntite | \n");
printf("____________________________________\n");
int i = 0;
while (i < CpTS)
{
printf("\t|%10s |%12s |\n", ts[i].NomEntite, ts[i].CodeEntite);
i++;
}
}
