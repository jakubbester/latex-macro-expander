#include "process.h"

// PIPE DEFINITIONS/MACROS
#define PIPE_READ 0
#define PIPE_WRITE 1

// STACK IMPLEMENTATION MACROS
#define INITIAL_CAPACITY 10

// ERROR HANDLING MACROS
#define ERROR -1

// TEMPLATE MACROS
#define TEMPLATE_SIZE 20

// STACK IMPLEMENTATION
typedef struct _node
{
    char *name;
} node;

typedef struct _stack
{
    node **table;
    int index;
    int capacity;
} stack;

stack *stack_create()
{
    stack *s = (stack *)malloc(sizeof(stack));
    s->table = (node **)malloc(sizeof(node *) * INITIAL_CAPACITY);
    s->capacity = INITIAL_CAPACITY;
    s->index = 0;
    return s;
}

bool stack_isFull(stack *s)
{
    return s->index == s->capacity;
}

bool stack_isEmpty(stack *s)
{
    return s->index == 0;
}

void stack_push(stack *s, char *nm)
{
    if (stack_isFull(s)) {
        s->table = (node **)realloc(s->table, s->capacity *= 2);
    }
    node *n = (node *)malloc(sizeof(node));
    n->name = (char *)malloc(sizeof(char) * (strlen(nm) + 1));
    strcpy(n->name, nm);
    s->table[s->index] = n;
    s->index++;
}

node *stack_pop(stack *s)
{
    if (stack_isEmpty(s)) {
        return NULL;
    }
    s->index--;
    node *tmp = s->table[s->index];
    s->table[s->index] = NULL;
    return tmp;
}

void stack_print(stack *s)
{
    for (int i = s->index - 1; i > 0; i--) {
        printf("%s ", s->table[i]->name);
    }
    printf("%s\n", s->table[0]->name);
}

// CREATE GLOBAL STACK
bool stackExists = false;
stack *s;

// DEFINE ALL HELPER FUNCTIONS

// BACKGROUND HANDLER FUNCTION
int handle_background(const CMD *cmdList, int flag);

// will have to add redirection, locals, and whatnot

int process(const CMD *cmdList)
{
    // CREATE GLOBAL STACK IF NOT ALREADY MADE
    if (!stackExists) {
        s = stack_create();
        stackExists = true;
    }

    // REAP ALL ZOMBIES CREATED BY THE PROCESS
    int zombieStatus;
    pid_t zombieID;
    if ((zombieID = waitpid(-1, &zombieStatus, WNOHANG)) > 0) {
        fprintf(stderr, "Completed: %d (%d)\n", zombieID, zombieStatus);
    }

    // CREATE ALL CMDLIST VARIABLES FOR EASE
    int type = cmdList->type;           // node type: SIMPLE, PIPE, SEP_AND, SEP_OR, SEP_END, SEP_BG, SUBCMD, or NONE (default)

    int  argc = cmdList->argc;          // number of command-line arguments
    char **argv = cmdList->argv;        // null-terminated argument vector or NULL

    int  nLocal = cmdList->nLocal;      // number of local variable assignments
    char **locVar = cmdList->locVar;    // array of local variable names and the values to
    char **locVal = cmdList->locVal;    // assign to them when the command executes

    int  fromType = cmdList->fromType;  // redirect stdin: NONE (default), RED_IN (<), or RED_IN_HERE (<<)
    char *fromFile = cmdList->fromFile; // file to redirect stdin, contents of here document, or NULL (default)

    int toType = cmdList->toType;       // redirect stdout: NONE (default), RED_OUT (>), or RED_OUT_APP (>>)
    char *toFile = cmdList->toFile;     // file to redirect stdout or NULL (default)

    struct cmd *left  = cmdList->left;  // left subtree or NULL (default)
    struct cmd *right = cmdList->right; // right subtree or NULL (default)

    // HANDLE COMMAND TYPE
    switch (type) {
        case SIMPLE: {
                int pid = fork();

                if (pid < 0) {
                    perror("fork");
                    exit(EXIT_FAILURE);
                } else if (pid == 0) {

                    if (strcmp(argv[0], "cd") == 0) {
                        if (argc == 2) {
                            if (chdir(argv[1]) == -1) {
                                perror("chdir");
                                exit(EXIT_FAILURE);
                            }
                        } else if (argc == 1) {
                            if (chdir(getenv("HOME")) == -1) {
                                perror("chdir");
                                exit(EXIT_FAILURE);
                            }
                        } else {
                            perror("argc");
                            exit(EXIT_FAILURE);
                        }
                        exit(EXIT_SUCCESS);
                    } else if (strcmp(argv[0], "pushd") == 0) {
                        char *cwd = getcwd(NULL, 0);
                        stack_push(s, cwd);
                        free(cwd);
                        if (chdir(argv[1]) == -1) {
                            perror("chdir");
                            exit(EXIT_FAILURE);
                        }
                        exit(EXIT_SUCCESS);
                    } else if (strcmp(argv[0], "popd") == 0) {
                        node *tmp = stack_pop(s);
                        if (tmp == NULL) {
                            perror("popd");
                            exit(EXIT_FAILURE);
                        }
                        chdir(tmp->name);
                        free(tmp->name);
                        free(tmp);
                        exit(EXIT_SUCCESS);
                    }

                    if (toFile != NULL) {
                        if (toType == RED_OUT) {
                            int new_stdout_fd = open(toFile, O_WRONLY | O_CREAT | O_TRUNC, S_IRUSR | S_IWUSR);
                            if (new_stdout_fd == ERROR) {
                                perror("open");
                                exit(EXIT_FAILURE);
                            }
                            dup2(new_stdout_fd, STDOUT_FILENO);
                            close(new_stdout_fd);
                        } else if (toType == RED_OUT_APP) {
                            int new_stdout_fd = open(toFile, O_APPEND | O_CREAT, S_IRUSR | S_IWUSR);
                            if (new_stdout_fd == ERROR) {
                                perror("open");
                                exit(EXIT_FAILURE);
                            }
                            dup2(new_stdout_fd, STDOUT_FILENO);
                            close(new_stdout_fd);
                        }
                    }

                    if (fromFile != NULL) {
                        if (fromType == RED_IN) {
                            int new_stdin_fd = open(fromFile, O_RDONLY);
                            if (new_stdin_fd == ERROR) {
                                perror("open");
                                exit(EXIT_FAILURE);
                            }
                            dup2(new_stdin_fd, STDIN_FILENO);
                            close(new_stdin_fd);
                        } else if (fromType == RED_IN_HERE) {
                            char tplate[TEMPLATE_SIZE] = "Bash_heredoc_XXXXXX";
                            int new_stdin_fd = mkstemp(tplate);
                            write(new_stdin_fd, fromFile, strlen(fromFile));
                            int new_stdin_fd1 = open(tplate, O_RDONLY);
                            if (new_stdin_fd1 == ERROR) {
                                perror("open");
                                exit(EXIT_FAILURE);
                            }
                            dup2(new_stdin_fd1, STDIN_FILENO);
                            unlink(tplate);
                            close(new_stdin_fd1);
                        }
                    }

                    if (nLocal > 0) {
                        for (int i = 0; i < nLocal; i++) {
                            setenv(locVar[i], locVal[i], 1);
                        }
                    }

                    if (execvp(argv[0], argv) == -1) {
                        perror("execvp");
                        exit(EXIT_FAILURE);
                    }

                } else {
                    int child_status;
                    waitpid(pid, &child_status, 0);

                    if (STATUS(child_status) == 0) {
                        if (strcmp(argv[0], "cd") == 0) {
                            if (argc == 2) {
                                if (chdir(argv[1]) == -1) {
                                    perror("chdir");
                                    exit(EXIT_FAILURE);
                                }
                            } else if (argc == 1) {
                                if (chdir(getenv("HOME")) == -1) {
                                    perror("chdir");
                                    exit(EXIT_FAILURE);
                                }
                            } else {
                                exit(EXIT_FAILURE);
                            }
                        } else if (strcmp(argv[0], "pushd") == 0) {
                            char *cwd = getcwd(NULL, 0);
                            if (cwd == NULL) {
                                perror("getcwd");
                                exit(EXIT_FAILURE);
                            }
                            stack_push(s, cwd);
                            free(cwd);
                            char *path = realpath(argv[1], NULL);
                            printf("%s ", path);
                            free(path);
                            stack_print(s);
                            if (chdir(argv[1]) == -1) {
                                perror("chdir");
                                exit(EXIT_FAILURE);
                            }
                            chdir(argv[1]);
                        }
                        else if (strcmp(argv[0], "popd") == 0) {
                            stack_print(s);
                            node *tmp = stack_pop(s);
                            if (tmp == NULL) {
                                perror("popd");
                                exit(EXIT_FAILURE);
                            }
                            if (chdir(tmp->name) == -1) {
                                perror("chdir");
                                exit(EXIT_FAILURE);
                            }
                            free(tmp->name);
                            free(tmp);
                        }
                    }

                    char buffer[20];
                    sprintf(buffer, "%d", STATUS(child_status));
                    setenv("?", buffer, 1);
                    return STATUS(child_status);
                }

        } break;

        case PIPE: {

            // make sure these work with built-ins

            // CREATE PIPE AND FILE DESCRIPTOR HANDLE
            int fds[2];
            if (pipe(fds) == -1) {
                perror("pipe");
                exit(EXIT_FAILURE);
            }

            // PROCESS THE LEFT NODE
            int pid1 = fork();

            if (pid1 < 0) {
                perror("fork");
                exit(EXIT_FAILURE);
            } else if (pid1 == 0) {
                dup2(fds[PIPE_WRITE], STDOUT_FILENO);

                close(fds[PIPE_READ]);
                close(fds[PIPE_WRITE]);

                if (process(left) != 0) {
                    exit(EXIT_FAILURE);
                }
                
                exit(EXIT_SUCCESS);
            }

            // PROCESS THE RIGHT NODE
            int pid2 = fork();

            if (pid2 < 0) {
                perror("fork");
                exit(EXIT_FAILURE);
            } else if (pid2 == 0) {
                dup2(fds[PIPE_READ], STDIN_FILENO);

                close(fds[PIPE_READ]);
                close(fds[PIPE_WRITE]);

                if (process(right) != 0) {
                    exit(EXIT_FAILURE);
                }

                exit(EXIT_SUCCESS);
            }
            
            close(fds[PIPE_READ]);
            close(fds[PIPE_WRITE]);

            int child_status1;
            waitpid(pid1, &child_status1, 0);

            int child_status2;
            waitpid(pid2, &child_status2, 0);

            if (STATUS(child_status2) != 0) {
                char buffer[20];
                sprintf(buffer, "%d", STATUS(child_status2));
                setenv("?", buffer, 1);
                return STATUS(child_status2);
            } else if (STATUS(child_status1) != 0) {
                char buffer[20];
                sprintf(buffer, "%d", STATUS(child_status1));
                setenv("?", buffer, 1);
                return STATUS(child_status1);
            } else {
                char buffer[20];
                sprintf(buffer, "%d", 0);
                setenv("?", buffer, 1);
                return 0;
            }

        } break;

        case SEP_AND: {

            int left_res;
            int right_res;
            
            left_res = process(left);
            if (left_res == 0) {
                right_res = process(right);
                char buffer[20];
                sprintf(buffer, "%d", right_res);
                setenv("?", buffer, 1);
                return right_res;
            }

            char buffer[20];
            sprintf(buffer, "%d", left_res);
            setenv("?", buffer, 1);
            return left_res;

        } break;

        case SEP_OR: {

            int left_res;
            int right_res;

            left_res = process(left);
            if (left_res != 0) {
                right_res = process(right);
                char buffer[20];
                sprintf(buffer, "%d", right_res);
                setenv("?", buffer, 1);
                return right_res;
            }

            char buffer[20];
            sprintf(buffer, "%d", left_res);
            setenv("?", buffer, 1);
            return left_res;

        } break;

        case SEP_END: {

            // PROCESS THE LEFT NODE
            if (left != NULL) {
                process(left);
            }
            
            // REMEMBER TO CHECK FOR ALL SEG FAULTS AND MAKE SURE THAT THEY'RE NOT NULL (RIGHT OR LEFT)

            // PROCESS THE RIGHT NODE
            if (right != NULL) {
                process(right);
            }

        } break;

        case SEP_BG: {

            handle_background(cmdList, 0);

        } break;

        case SUBCMD: {
                
            int pid = fork();

            // REMEMBER TO CREATE SEPERATE FUNCTIONS
            // IMPLEMENT REDIRECTION AND LOCALS

            if (pid == 0) {
                if (fromFile != NULL) {
                    if (fromType == RED_IN) {
                        int new_stdin_fd = open(fromFile, O_RDONLY);
                        if (new_stdin_fd == ERROR) {
                            perror("open");
                            exit(EXIT_FAILURE);
                        }
                        dup2(new_stdin_fd, STDIN_FILENO);
                        close(new_stdin_fd);
                    } else if (fromType == RED_IN_HERE) {
                        char tplate[TEMPLATE_SIZE] = "Bash_heredoc_XXXXXX";
                        int new_stdin_fd = mkstemp(tplate);
                        write(new_stdin_fd, fromFile, strlen(fromFile));
                        int new_stdin_fd1 = open(tplate, O_RDONLY);
                        if (new_stdin_fd1 == ERROR) {
                            perror("open");
                            exit(EXIT_FAILURE);
                        }
                        dup2(new_stdin_fd1, STDIN_FILENO);
                        unlink(tplate);
                        close(new_stdin_fd1);
                    }
                }

                exit(process(left));
            }

            int child_status;
            waitpid(pid, &child_status, 0);

            char buffer[20];
            sprintf(buffer, "%d", STATUS(child_status));
            setenv("?", buffer, 1);
            return STATUS(child_status);

        } break;

        default:
            break;
    }

    return 0;
}

int handle_background(const CMD *cmdList, int flag)
{
    // CREATE ALL CMDLIST VARIABLES FOR EASE
    struct cmd *left  = cmdList->left;  // left subtree or NULL (default)
    struct cmd *right = cmdList->right; // right subtree or NULL (default)

    int pid = fork();

    if (pid == 0) {
        if (left != NULL) {
            exit(process(left));
        }
    } else {
        if (right != NULL) {
            process(right);
        }
        fprintf(stderr, "Backgrounded: %d\n", pid);
    }

    return 0;
    
    // remember to handle more complicated background cases
}
