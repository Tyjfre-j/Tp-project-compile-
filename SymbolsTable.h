#ifndef SymbolsTable_H
#define SymbolsTable_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Constants and variables table struct
typedef struct
{ 
    char entity_name[20];  
    char entity_code[20];  
    char entity_nature[20];
    char entity_type[10];
    char entity_array_size[20];  
    char entity_value[20]; 
          
}Type_Constant_Variable_Table;

// keywords and seperators table structure
typedef struct 
{   
    char entity_name[20];
    char entity_code[20];
}Type_Keword_Seperator_Table;

// Variables declaration
extern Type_Constant_Variable_Table idf_table[100];  
extern Type_Keword_Seperator_Table keyword_table[100];
extern Type_Keword_Seperator_Table seperator_table[100]; 
extern int idf_table_counter;
extern int keyword_table_counter;
extern int seperator_table_counter; 

// Functions declaration


// search functions
int search_in_idf_table(char *entity);
int search_in_keyword_table(char *entity);
int search_in_seperator_table(char *entity);

// insert funtions 
void insert_into_idf_table(char *entity, char *code, char *nature, char *type, char* array_size, char* value);
void insert_into_keyword_table(char *entity, char *code);
void insert_into_seperator_table(char *entity, char *code);

// print functions
void show_idf_table();
void show_keyword_table();
void show_seperator_table();

#endif
