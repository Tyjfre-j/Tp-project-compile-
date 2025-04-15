#include "SymbolsTable.h"
#include <string.h>

// Variables definition
Type_Constant_Variable_Table idf_table[100];
Type_Keword_Seperator_Table keyword_table[100];
Type_Keword_Seperator_Table seperator_table[100];  
int idf_table_counter = 0;
int keyword_table_counter = 0;
int seperator_table_counter = 0;

// Functions definition

// search functions
int search_in_idf_table(char *entity)
{
    int i = 0;
    while (i < idf_table_counter)
    {
    if (strcmp(entity, idf_table[i].entity_name) == 0)
    {
        return i;
    }
    i++;
    }
    return -1;
}

int search_in_keyword_table(char *entity)
{
    int i = 0;
    while (i < keyword_table_counter)
    {
    if (strcmp(entity, keyword_table[i].entity_name) == 0)
    {
        return i;
    }
    i++;
    }
    return -1;
}

int search_in_seperator_table(char *entity)
{
    int i = 0;
    while (i < seperator_table_counter)
    {
    if (strcmp(entity, seperator_table[i].entity_name) == 0)
    {
        return i;
    }
    i++;
    }
    return -1;
}
// insert functions
void insert_into_idf_table(char *entity, char *code, char *nature, char *type, char *array_size, char* value)
{
    if (search_in_idf_table(entity) == -1) 
    {
        strcpy(idf_table[idf_table_counter].entity_name, entity);
        strcpy(idf_table[idf_table_counter].entity_code, code);
        strcpy(idf_table[idf_table_counter].entity_nature, nature);
        strcpy(idf_table[idf_table_counter].entity_type, type);
        strcpy(idf_table[idf_table_counter].entity_array_size, array_size);
        strcpy(idf_table[idf_table_counter].entity_value, value);
        idf_table_counter++;
    }
}

void insert_into_keyword_table(char *entity, char *code)
{
    if (search_in_keyword_table(entity) == -1)
    {
        strcpy(keyword_table[keyword_table_counter].entity_name, entity);
        strcpy(keyword_table[keyword_table_counter].entity_code, code);
        keyword_table_counter++;
    }
    
}

void insert_into_seperator_table(char *entity, char *code)
{
    if (search_in_seperator_table(entity) == -1)
    {
        strcpy(seperator_table[seperator_table_counter].entity_name, entity);
        strcpy(seperator_table[seperator_table_counter].entity_code, code);
        seperator_table_counter++;
    }
    
}

// print functions
void show_idf_table() {
    printf("\n/*************** Idfs table ******************/\n");
    printf("+------------------+------------------+--------------+--------------+--------------+-----------+\n");
    printf("| %-16s | %-16s | %-12s | %-12s | %-12s | %-9s |\n", "NomEntite", "CodeEntite", "Type", "Nature", "Array size", "Value");
    printf("+------------------+------------------+--------------+--------------+--------------+-----------+\n");
    int i;
    for (i = 0; i < idf_table_counter; i++) {
        printf("| %-16s | %-16s | %-12s | %-12s | %-12s | %-9s |\n", 
            idf_table[i].entity_name, 
            idf_table[i].entity_code, 
            idf_table[i].entity_type, 
            idf_table[i].entity_nature,
            idf_table[i].entity_array_size, 
            idf_table[i].entity_value);
    }

    printf("+------------------+------------------+--------------+--------------+--------------+-----------+\n");
}

void show_keyword_table() {
    printf("\n/*************** Keywords table ******************/\n");
    printf("+------------------+------------------+\n");
    printf("| %-16s | %-16s |\n", "NomEntite", "CodeEntite");
    printf("+------------------+------------------+\n");
    int i;
    for (i = 0; i < keyword_table_counter; i++) {
        printf("| %-16s | %-16s |\n", keyword_table[i].entity_name, keyword_table[i].entity_code);
    }

    printf("+------------------+------------------+\n");
}

void show_seperator_table() {
    printf("\n/*************** Seperators table ******************/\n");
    printf("+------------------+------------------+\n");
    printf("| %-16s | %-16s |\n", "NomEntite", "CodeEntite");
    printf("+------------------+------------------+\n");
    int i;
    for (i = 0; i < seperator_table_counter; i++) {
        printf("| %-16s | %-16s |\n", seperator_table[i].entity_name, seperator_table[i].entity_code);
    }
    printf("+------------------+------------------+\n");
}
