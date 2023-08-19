/*
***********************************************************************
  CODEGEN.C : IMPLEMENT CODE GENERATION HERE
************************************************************************
*/
#include "codegen.h"

int argCounter;
int lastUsedOffset;
char lastOffsetUsed[100];
FILE *fptr;
regInfo *regList, *regHead, *regLast;
varStoreInfo *varList, *varHead, *varLast;

/*
*************************************************************************************
   YOUR CODE IS TO BE FILLED IN THE GIVEN TODO BLANKS. YOU CAN CHOOSE TO USE ALL
   UTILITY FUNCTIONS OR NONE. YOU CAN ADD NEW FUNCTIONS. BUT DO NOT FORGET TO
   DECLARE THEM IN THE HEADER FILE.
**************************************************************************************
*/

/*
***********************************************************************
  FUNCTION TO INITIALIZE THE ASSEMBLY FILE WITH FUNCTION DETAILS
************************************************************************
*/
void InitAsm(char* funcName) {
    fprintf(fptr, "\n.globl %s", funcName);
    fprintf(fptr, "\n%s:\n", funcName); 

    // Init stack and base ptr
    fprintf(fptr, "\npushq %%rbp");  
    fprintf(fptr, "\nmovq %%rsp, %%rbp\n"); 
}

/*
***************************************************************************
   FUNCTION TO WRITE THE RETURNING CODE OF A FUNCTION IN THE ASSEMBLY FILE
****************************************************************************
*/
void RetAsm() {
    fprintf(fptr,"\npopq  %%rbp");
    fprintf(fptr, "\nretq\n");
} 

/*
***************************************************************************
  FUNCTION TO CONVERT OFFSET FROM LONG TO CHAR STRING 
****************************************************************************
*/
void LongToCharOffset() {
     lastUsedOffset = lastUsedOffset - 8;
     snprintf(lastOffsetUsed, 100,"%d", lastUsedOffset);
     strcat(lastOffsetUsed,"(%rbp)");
}

/*
***************************************************************************
  FUNCTION TO CONVERT CONSTANT VALUE TO CHAR STRING
****************************************************************************
*/
void ProcessConstant(Node* opNode) {
     char value[10];
     LongToCharOffset();
     snprintf(value, 10,"%ld", opNode->value);
     char str[100];
     snprintf(str, 100,"%d", lastUsedOffset);
     strcat(str,"(%rbp)");
     AddVarInfo("", str, opNode->value, true);
     fprintf(fptr, "\nmovq  $%s, %s", value, str);
}

/*
***************************************************************************
  FUNCTION TO SAVE VALUE IN ACCUMULATOR (RAX)
****************************************************************************
*/
void SaveValInRax(char* name) {
    char *tempReg;
    tempReg = GetNextAvailReg(true);
    if(!(strcmp(tempReg, "NoReg"))) {
        LongToCharOffset();
        fprintf(fptr, "\nmovq %%rax, %s", lastOffsetUsed);
        UpdateVarInfo(name, lastOffsetUsed, INVAL, false);
        UpdateRegInfo("%rax", 1);
    }
    else {
        fprintf(fptr, "\nmovq %%rax, %s", tempReg);
        UpdateRegInfo(tempReg, 0);
        UpdateVarInfo(name, tempReg, INVAL, false);
        UpdateRegInfo("%rax", 1);
    }
}



/*
***********************************************************************
  FUNCTION TO ADD VARIABLE INFORMATION TO THE VARIABLE INFO LIST
************************************************************************
*/
void AddVarInfo(char* varName, char* location, long val, bool isConst) {
   varStoreInfo* node = malloc(sizeof(varStoreInfo));
   node->varName = varName;
   node->value = val;
   strcpy(node->location,location);
   node->isConst = isConst;
   node->next = NULL;
   node->prev = varLast;
   if(varHead==NULL) {
       varHead = node;
       varLast = node;;
       varList = node;
   } else {
       //node->prev = varLast;
       varLast->next = node;
       varLast = varLast->next;
   }
   varList = varHead;
}

/*
***********************************************************************
  FUNCTION TO FREE THE VARIABLE INFORMATION LIST
************************************************************************
*/
void FreeVarList()
{  
   varStoreInfo* tmp;
   while (varHead != NULL)
    {  
       tmp = varHead;
       varHead = varHead->next;
       free(tmp);
    }

}

/*
***********************************************************************
  FUNCTION TO LOOKUP VARIABLE INFORMATION FROM THE VARINFO LIST
************************************************************************
*/
char* LookUpVarInfo(char* name, long val) {
    varList = varLast;
    if(varList == NULL) printf("NULL varlist");
    while(varList!=NULL) {
        if(varList->isConst == true) {
            if(varList->value == val) return varList->location;
        }
        else {
            if(!strcmp(name,varList->varName)) return varList->location;
        }
        varList = varList->prev;
    }
    varList = varHead;
    return "";
}

/*
***********************************************************************
  FUNCTION TO UPDATE VARIABLE INFORMATION 
************************************************************************
*/
void UpdateVarInfo(char* varName, char* location, long val, bool isConst) {
  
   if(!(strcmp(LookUpVarInfo(varName, val), ""))) {
       AddVarInfo(varName, location, val, isConst);
   }
   else {
       varList = varHead;
       if(varList == NULL) printf("NULL varlist");
       while(varList!=NULL) {
           if(!strcmp(varList->varName,varName)) {
               varList->value = val;
               strcpy(varList->location,location);
               varList->isConst = isConst;
               break;
        }
        varList = varList->next;
       }
    }
    varList = varHead;
}

/*
***********************************************************************
  FUNCTION TO PRINT THE VARIABLE INFORMATION LIST
************************************************************************
*/
void PrintVarListInfo() {
    varList = varHead;
    if(varList == NULL) printf("NULL varlist");
    while(varList!=NULL) {
        if(!varList->isConst) {
            printf("\t %s : %s", varList->varName, varList->location);
        }
        else {
            printf("\t %ld : %s", varList->value, varList->location);
        }
        varList = varList->next;
    }
    varList = varHead;
}

/*
***********************************************************************
  FUNCTION TO ADD NEW REGISTER INFORMATION TO THE REGISTER INFO LIST
************************************************************************
*/
void AddRegInfo(char* name, int avail) {

   regInfo* node = malloc(sizeof(regInfo));
   node->regName = name;
   node->avail = avail;
   node->next = NULL; 

   if(regHead==NULL) {
       regHead = node;
       regList = node;
       regLast = node;
   } else {
       regLast->next = node;
       regLast = node;
   }
   regList = regHead;
}

/*
***********************************************************************
  FUNCTION TO FREE REGISTER INFORMATION LIST
************************************************************************
*/
void FreeRegList()
{  
   regInfo* tmp;
   while (regHead != NULL)
    {  
       tmp = regHead;
       regHead = regHead->next;
       free(tmp);
    }

}

/*
***********************************************************************
  FUNCTION TO UPDATE THE AVAILIBILITY OF REGISTERS IN THE REG INFO LIST
************************************************************************
*/
void UpdateRegInfo(char* regName, int avail) {
    while(regList!=NULL) {
        if(regName == regList->regName) {
            regList->avail = avail;
        }
        regList = regList->next;
    }
    regList = regHead;
}

/*
***********************************************************************
  FUNCTION TO RETURN THE NEXT AVAILABLE REGISTER
************************************************************************
*/
char* GetNextAvailReg(bool noAcc) {
    regList = regHead;
    if(regList == NULL) printf("NULL reglist");
    while(regList!=NULL) {
        if(regList->avail == 1) {
            if(!noAcc) return regList->regName;
            // if not rax and dont return accumulator set to true, return the other reg
            // if rax and noAcc == true, skip to next avail
            if(noAcc && strcmp(regList->regName, "%rax")) { 
                return regList->regName;
            }
        }
        regList = regList->next;
    }
    regList = regHead;
    return "NoReg";
}

/*
***********************************************************************
  FUNCTION TO DETERMINE IF ANY REGISTER APART FROM OR INCLUDING 
  THE ACCUMULATOR(RAX) IS AVAILABLE
************************************************************************
*/
int IfAvailReg(bool noAcc) {
    regList = regHead;
    if(regList == NULL) printf("NULL reglist");
    while(regList!=NULL) {
        if(regList->avail == 1) {
            // registers available
            if(!noAcc) return 1;
            if(noAcc && strcmp(regList->regName, "%rax")) {
                return 1;
            }
        }
        regList = regList->next;
    }
    regList = regHead;
    return 0;
}

/*
***********************************************************************
  FUNCTION TO DETERMINE IF A SPECIFIC REGISTER IS AVAILABLE
************************************************************************
*/
bool IsAvailReg(char* name) {
    regList = regHead;
    if(regList == NULL) printf("NULL reglist");
    while(regList!=NULL) {
        if(!strcmp(regList->regName, name)) {
           if(regList->avail == 1) {
               return true;
           } 
        }
        regList = regList->next;
    }
    regList = regHead;
    return false;
}

/*
************************************************************************
  FUNCTION TO PRINT THE REGISTER INFORMATION
************************************************************************
*/
void PrintRegListInfo() {
    regList = regHead;
    if(regList == NULL) printf("NULL reglist");
    while(regList!=NULL) {
        printf("\t %s : %d", regList->regName, regList->avail);
        regList = regList->next;
    }
    regList = regHead;
}

/*
************************************************************************
  FUNCTION TO CREATE THE REGISTER LIST
************************************************************************
*/
void CreateRegList() {
    // Create the initial reglist which can be used to store variables.
    // 4 general purpose registers : AX, BX, CX, DX
    // 4 special purpose : SP, BP, SI , DI. 
    // Other registers: r8, r9
    // You need to decide which registers you will add in the register list 
    // use. Can you use all of the above registers?
}


/*
************************************************************************
  THIS FUNCTION IS MEANT TO PUT THE FUNCTION ARGUMENTS ON STACK
************************************************************************
*/
int PutArgumentsFromStack(NodeList* arguments) {
    argCounter = 0;
    while (arguments!= NULL) {
        argCounter++;
        char* location = LookUpVarInfo(arguments->node->name, arguments->node->value);
        switch (argCounter) {
            case 1:
                if (arguments->node->exprCode == CONSTANT) {
                    fprintf(fptr, "\nmovq $%lu, %%rdi", arguments->node->value);
                } else {
                    fprintf(fptr, "\nmovq %s, %%rdi", location);
                }
                break;
            case 2:
                if (arguments->node->exprCode == CONSTANT) {
                    fprintf(fptr, "\nmovq $%lu, %%rsi", arguments->node->value);
                } else {
                    fprintf(fptr, "\nmovq %s, %%rsi", location);
                }
                break;
            case 3:
                if (arguments->node->exprCode == CONSTANT) {
                    fprintf(fptr, "\nmovq $%lu, %%rdx", arguments->node->value);
                } else {
                    fprintf(fptr, "\nmovq %s, %%rdx", location);
                }
                break;
            case 4:
                if (arguments->node->exprCode == CONSTANT) {
                    fprintf(fptr, "\nmovq $%lu, %%rcx", arguments->node->value);
                } else {
                    fprintf(fptr, "\nmovq %s, %%rcx", location);
                }
                break;
            case 5:
                if (arguments->node->exprCode == CONSTANT) {
                    fprintf(fptr, "\nmovq $%lu, %%r8", arguments->node->value);
                } else {
                    fprintf(fptr, "\nmovq %s, %%r8", location);
                }
                break;
            case 6:
                if (arguments->node->exprCode == CONSTANT) {
                    fprintf(fptr, "\nmovq $%lu, %%r9", arguments->node->value);
                } else {
                    fprintf(fptr, "\nmovq %s, %%r9", location);
                }
                break;
            default:
                break;
        }
        arguments = arguments->next;
    }
    return argCounter;
}


/*
**************************************************************************
  THIS FUNCTION IS MEANT TO GET THE FUNCTION ARGUMENTS FROM THE STACK
**************************************************************************
*/
void PutArgumentsOnStack(NodeList* arguments) {
    Node *node;
    size_t argument_counter = 0;
    while (arguments != NULL) {
        argument_counter++;
        node = arguments->node;
        switch (argument_counter) {
            case 1:
                AddVarInfo(node->name, "%rdi", node->value, false);
                break;
            case 2:
                AddVarInfo(node->name, "%rsi", node->value, false);
                break;
            case 3:
                AddVarInfo(node->name, "%rdx", node->value, false);
                break;
            case 4:
                AddVarInfo(node->name, "%rcx", node->value, false);
                break;
            case 5:
                AddVarInfo(node->name, "%r8", node->value, false);
                break;
            case 6:
                AddVarInfo(node->name, "%r9", node->value, false);
                break;
            default:
                break;
        }
        arguments = arguments->next;
    }
}


/*
 ************************************************************************
  THIS FUNCTION IS MEANT TO PROCESS EACH CODE STATEMENT AND GENERATE 
  ASSEMBLY FOR IT. 
  TIP: YOU CAN MODULARIZE BETTER AND ADD NEW SMALLER FUNCTIONS IF YOU 
  WANT THAT CAN BE CALLED FROM HERE.
 ************************************************************************
 */  
void ProcessStatements(NodeList* statements) {
    Node *node;
    while (statements != NULL) {
        node = statements->node;
        if (node->stmtCode == ASSIGN) {
            if (node->right->opCode == FUNCTIONCALL) {
                PutArgumentsFromStack(node->right->arguments);
                fprintf(fptr, "\ncallq %s", node->right->left->name);
                LongToCharOffset();
                UpdateVarInfo(node->name, lastOffsetUsed, INVAL, false);
                fprintf(fptr, "\nmovq %%rax, %s\n", lastOffsetUsed);
            } else {
                if (node->right->left == NULL || node->right->right == NULL) {          
                    fprintf(fptr, "\nmovq %s, %%rax", LookUpVarInfo(node->right->left->name, INVAL));
                } else if (node->right->left->exprCode == CONSTANT) {
                    fprintf(fptr, "\nmovq $%ld, %%rax", node->right->left->value);
                    fprintf(fptr, "\nmovq %s, %%rcx", LookUpVarInfo(node->right->right->name, INVAL));
                } else if (node->right->right->exprCode == CONSTANT) {
                    fprintf(fptr, "\nmovq %s, %%rax", LookUpVarInfo(node->right->left->name, INVAL));
                    fprintf(fptr, "\nmovq $%ld, %%rcx", node->right->right->value);
                } else {
                    fprintf(fptr, "\nmovq %s, %%rax", LookUpVarInfo(node->right->left->name, INVAL));
                    fprintf(fptr, "\nmovq %s, %%rcx", LookUpVarInfo(node->right->right->name, INVAL));
                }
                switch (node->right->opCode) {
                    case MULTIPLY:
                        fprintf(fptr, "\nimulq %%rcx, %%rax");
                        break;
                    case DIVIDE:
                        fprintf(fptr, "\ncqto");
                        fprintf(fptr, "\nidivq %%rcx, %%rax");
                        break;
                    case ADD:
                        fprintf(fptr, "\naddq %%rcx, %%rax");
                        break;
                    case SUBTRACT:
                        fprintf(fptr, "\nsubq %%rcx, %%rax");
                        break;
                    case NEGATE:
                        fprintf(fptr, "\nnegq %%rax");
                        break;
                    case BOR:
                        fprintf(fptr, "\norq %%rcx, %%rax");
                        break;
                    case BAND:
                        fprintf(fptr, "\nandq %%rcx, %%rax");
                        break;
                    case BXOR:
                        fprintf(fptr, "\nxorq %%rcx, %%rax");
                        break;
                    case BSHR:
                        fprintf(fptr, "\nsarq %%rcx, %%rax");
                        break;
                    case BSHL:
                        fprintf(fptr, "\nsalq %%rcx, %%rax");
                        break;
                    default:
                        break;
                }
                LongToCharOffset();
                UpdateVarInfo(node->name, lastOffsetUsed, INVAL, false);
                fprintf(fptr, "\nmovq %%rax, %s\n", lastOffsetUsed);
            }
        } else if (node->stmtCode == RETURN) {
            if (node->left->exprCode == CONSTANT) {
                fprintf(fptr, "\nmovq $%lu, %%rax\n", node->left->value);
            } else {
                fprintf(fptr, "\nmovq %s, %%rax\n", LookUpVarInfo(node->left->name, INVAL));
            }
        }
        statements = statements->next;
    }
}

/*
 ***********************************************************************
  THIS FUNCTION IS MEANT TO DO CODEGEN FOR ALL THE FUNCTIONS IN THE FILE
 ************************************************************************
*/
void Codegen(NodeList* worklist) {
    fptr = fopen("assembly.s", "w+");
    Node *funcNode;
    if(fptr == NULL) {
        printf("\n Could not create assembly file");
        return; 
    }
    while(worklist != NULL) {
        funcNode = worklist->node;
        InitAsm(funcNode->name);

        size_t count = 0;
        NodeList *statements = funcNode->statements;
        while (statements != NULL) {
            if (statements->node->stmtCode == ASSIGN)
                count++;
            statements = statements->next;
        }
        fprintf(fptr, "subq $%lu, %%rsp", count * 8);

        PutArgumentsOnStack(funcNode->arguments);
        ProcessStatements(funcNode->statements);
        
        fprintf(fptr, "addq $%lu, %%rsp", count * 8);
        RetAsm();

        lastUsedOffset = 0;
        worklist = worklist->next; 
    }
    FreeVarList();
    fclose(fptr);
}

/*
**********************************************************************************************************************************
 YOU CAN MAKE ADD AUXILLIARY FUNCTIONS BELOW THIS LINE. DO NOT FORGET TO DECLARE THEM IN THE HEADER
**********************************************************************************************************************************
*/

/*
**********************************************************************************************************************************
 YOU CAN MAKE ADD AUXILLIARY FUNCTIONS ABOVE THIS LINE. DO NOT FORGET TO DECLARE THEM IN THE HEADER
**********************************************************************************************************************************
*/


