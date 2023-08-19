#include "optimizer.h"


void Optimizer(NodeList *funcdecls) {
     bool constantFolding = true;
     bool constProp = true;
     bool deadAssign = true;
     while (constantFolding || constProp || deadAssign) {
          constantFolding = ConstantFolding(funcdecls);
          constProp = ConstProp(funcdecls);
          deadAssign = DeadAssign(funcdecls);
     }
}
