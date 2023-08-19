/*
********************************************************************************
  CONSTPROP.C : IMPLEMENT THE DOWNSTREAM CONSTANT PROPOGATION OPTIMIZATION HERE
*********************************************************************************
*/

#include "constprop.h"

refConst *lastNode, *headNode;
/*
*************************************************************************************
   YOUR CODE IS TO BE FILLED IN THE GIVEN TODO BLANKS. YOU CAN CHOOSE TO USE ALL
   UTILITY FUNCTIONS OR NONE. YOU CAN ADD NEW FUNCTIONS. BUT DO NOT FORGET TO
   DECLARE THEM IN THE HEADER FILE.
**************************************************************************************
*/

/*
***********************************************************************
  FUNCTION TO FREE THE CONSTANTS-ASSOCIATED VARIABLES LIST
************************************************************************
*/
void FreeConstList()
{
   refConst* tmp;
   while (headNode != NULL)
    {
       tmp = headNode;
       headNode = headNode->next;
       free(tmp);
    }

}

/*
*************************************************************************
  FUNCTION TO ADD A CONSTANT VALUE AND THE ASSOCIATED VARIABLE TO THE LIST
**************************************************************************
*/
void UpdateConstList(char* name, long val) {
    refConst* node = malloc(sizeof(refConst));
    if (node == NULL) return;
    node->name = name;
    node->val = val;
    node->next = NULL;
    if(headNode == NULL) {
        lastNode = node;
        headNode = node;
    }
    else {
        lastNode->next = node;
        lastNode = node;
    }
}

/*
*****************************************************************************
  FUNCTION TO LOOKUP IF A CONSTANT ASSOCIATED VARIABLE IS ALREADY IN THE LIST
******************************************************************************
*/
refConst* LookupConstList(char* name) {
    refConst *node;
    node = headNode; 
    while(node!=NULL){
        if(!strcmp(name, node->name))
            return node;
        node = node->next;
    }
    return NULL;
}

/*
**********************************************************************************************************************************
 YOU CAN MAKE CHANGES/ADD AUXILLIARY FUNCTIONS BELOW THIS LINE
**********************************************************************************************************************************
*/

void TrackVariable(Node *node) {
    refConst *tmpNode;
    if (node->exprCode == VARIABLE) {
        if ((tmpNode = LookupConstList(node->name)) != NULL) {
            node->exprCode = CONSTANT;
            node->value = tmpNode->val;
        }
    }
}

/*
************************************************************************************
  THIS FUNCTION IS MEANT TO UPDATE THE CONSTANT LIST WITH THE ASSOCIATED VARIABLE
  AND CONSTANT VALUE WHEN ONE IS SEEN. IT SHOULD ALSO PROPOGATE THE CONSTANTS WHEN 
  WHEN APPLICABLE. YOU CAN ADD A NEW FUNCTION IF YOU WISH TO MODULARIZE BETTER.
*************************************************************************************
*/
void TrackConst(NodeList* statements) {
    Node* node;
    while(statements != NULL) {
        node = statements->node;
        if (node->stmtCode == ASSIGN) {
            Node *leftNode = node->right->left;
            Node *rightNode = node->right->right;
            if (node->right->exprCode == CONSTANT) {
                if (LookupConstList(node->name) == NULL) {
                    UpdateConstList(node->name, node->right->value);
                }
            } else if (node->right->exprCode == OPERATION && node->right->opCode == FUNCTIONCALL) {
                NodeList *tmp = node->right->arguments;
                while (tmp != NULL) {
                    TrackVariable(tmp->node);
                    tmp = tmp->next;
                }
            } else if (node->right->exprCode == OPERATION && leftNode != NULL && rightNode != NULL) {
                TrackVariable(leftNode);
                TrackVariable(rightNode);
            }
        } else if (node->stmtCode == RETURN) {
            TrackVariable(node->left);
        }
        statements = statements->next;
    }
}


bool ConstProp(NodeList* worklist) {
    while (worklist != NULL) {
        TrackConst(worklist->node->statements);
        FreeConstList();
        worklist = worklist->next;
    }
    return madeChange;
}

/*
**********************************************************************************************************************************
 YOU CAN MAKE CHANGES/ADD AUXILLIARY FUNCTIONS ABOVE THIS LINE
**********************************************************************************************************************************
*/
