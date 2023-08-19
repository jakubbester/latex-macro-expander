/**
 * A TeX-like Macro Processor that handles user-defined and system macros
 * expanding, evaluating, and printing out the results to standard output
 * @author Jakub Bester
 * @course CPSC 323 - Systems Programming and Computer Organization
 * @assignment Project #1 - A TeX-like Macro Processor
 */

#include "proj1.h"

#define INITIAL_CAPACITY_STRING 20
#define INITIAL_CAPACITY_MACRO 5
#define STORAGE_CAPACITY 4
#define BALANCE_CAPACITY 2

// meta data struct for string data structure
typedef struct _string
{
  char *string;
  size_t size;
  size_t capacity;
} string;

/**
 * Allocates memory for string data structure and initializes values.
 * @return pointer to a string struct
 */
string *string_create()
{
  string *s = (string *)malloc(sizeof(string));
  s->string = (char *)malloc(sizeof(char) * INITIAL_CAPACITY_STRING);
  s->capacity = INITIAL_CAPACITY_STRING;
  s->string[0] = '\0';
  s->size = 0;
  return s;
}

/**
 * Creates an array of strings.
 * @return an array of strings
 */
string **storage_create()
{
  string **s = (string **)malloc(sizeof(string *) * STORAGE_CAPACITY);
  for (size_t i = 0; i < STORAGE_CAPACITY; i++)
  {
    s[i] = string_create();
  }
  return s;
}

/**
 * Resizes the string in accordance with the size specified in the function.
 * @param s pointer to the string data structure
 * @param n new size to resize the string to
 */
void string_resize(string *s, size_t n)
{
  s->string = (char *)realloc(s->string, sizeof(char) * n);
  s->capacity = n;
}

/**
 * Places a specified character into the string data structure.
 * @param s pointer to the string data structure
 * @param c character to add to the data structure
 */
void string_putchar(string *s, char c)
{
  if (s->size + 1 == s->capacity)
  {
    string_resize(s, s->capacity * 2);
  }
  s->string[s->size + 1] = '\0';
  s->string[s->size] = c;
  s->size++;
}

/**
 * Places a specified string into the string data structure.
 * @param s pointer to the string data structure
 * @param c character to add to the data structure
 * @param n size to make new string data structure
 */
void string_putstring(string *s, char *c, size_t n)
{
  for (size_t i = 0; i < n; i++)
  {
    string_putchar(s, c[i]);
  }
}

/**
 * Copies storage strings over from one to the next
 * @param new_storage pointer to array of strings
 * @param old_storage pointer to array of strings
 */
void storage_copy(string **new_storage, string **old_storage)
{
  for (size_t i = 0; i < STORAGE_CAPACITY; i++)
  {
    string_putstring(new_storage[i], old_storage[i]->string, old_storage[i]->size);
  }
}

/**
 * Prints the string data structure out into standard output.
 * @param s pointer to the string data structure
 */
void string_print(string *s)
{
  printf("%s", s->string);
}

/**
 * Destroys the inputted string by freeing all memory.
 * @param s pointer to the string data structure
 */
void string_destroy(string *s)
{
  free(s->string);
  free(s);
}

/**
 * Destroys the storage array of strings
 * @param s pointer to array of strings
 */
void storage_destroy(string **s)
{
  for (size_t i = 0; i < STORAGE_CAPACITY; i++)
  {
    string_destroy(s[i]);
  }
  free(s);
}

/**
 * Cleans out string
 * @param s pointer to string
 */
void string_flush(string *s)
{
  string_resize(s, INITIAL_CAPACITY_STRING);
  s->capacity = INITIAL_CAPACITY_STRING;
  s->string[0] = '\0';
  s->size = 0;
}

/**
 * Cleans out the array stringds
 * @param s pointer to array of strings
 */
void storage_flush(string **s)
{
  for (size_t i = 0; i < STORAGE_CAPACITY; i++)
  {
    string_flush(s[i]);
  }
}

// (NAME, VALUE) pair struct for user-defined macros
typedef struct _macro_node
{
  string *name;
  string *value;
} macro_node;

// meta-data struct for the list of user-defined macros
typedef struct _macro_list
{
  macro_node **macro_list;
  size_t size;
  size_t capacity;
} macro_list;

/**
 * Creates a new list to store user-defined macros.
 * @return pointer to a macro list
 */
macro_list *macro_list_create()
{
  macro_list *m = (macro_list *)malloc(sizeof(macro_list));
  m->macro_list = (macro_node **)malloc(sizeof(macro_node *) * INITIAL_CAPACITY_MACRO);
  m->size = 0;
  m->capacity = INITIAL_CAPACITY_MACRO;
  return m;
}

/**
 * Resizes the list when it becomes full (either larger or smaller).
 * @param m pointer to list of macros
 * @param n new size of list of macros
 */
void macro_list_resize(macro_list *m, size_t n)
{
  m->macro_list = (macro_node **)realloc(m->macro_list, sizeof(macro_node *) * n);
  m->capacity = n;
}

/**
 * Adds a user-defined macro to the list.
 * @param m pointer to list of macros
 * @param name pointer to string of custom macro name
 * @param value pointer to string of custom macro value
 */
void macro_list_add(macro_list *m, char *name, size_t o, char *value, size_t p)
{
  if (m->size == m->capacity)
  {
    macro_list_resize(m, m->capacity * 2);
  }
  macro_node *n = (macro_node *)malloc(sizeof(macro_node));

  // create a deep copy of the macro name
  string *temporary_name = string_create();
  string_putstring(temporary_name, name, o);
  n->name = temporary_name;

  // create a deep copy of the macro value
  string *temporary_value = string_create();
  string_putstring(temporary_value, value, p);
  n->value = temporary_value;

  m->macro_list[m->size] = n;
  m->size++;
}

/**
 * Computes the index of the location of the macro in the list.
 * @param m pointer to list of macros
 * @param name pointer to string of custom macro name
 * @return the index/location of the macro
 */
int macro_list_compute_index(macro_list *m, char *name)
{
  for (size_t i = 0; i < m->size; i++)
  {
    if (strcmp(m->macro_list[i]->name->string, name) == 0)
    {
      return i;
    }
  }
  return -1;
}

/**
 * Removes the inputted macro from the list.
 * @param m pointer to list of macros
 * @param name pointer to string of custom macro name
 */
void macro_list_remove(macro_list *m, char *name)
{
  size_t index = macro_list_compute_index(m, name);

  string_destroy(m->macro_list[index]->name);
  string_destroy(m->macro_list[index]->value);
  free(m->macro_list[index]);

  for (size_t i = index; i < m->size - 1; i++)
  {
    m->macro_list[i] = m->macro_list[i + 1];
  }

  if (m->size < m->capacity / 2)
  {
    macro_list_resize(m, m->capacity / 2);
  }

  m->size--;
}

/**
 * Destroys and frees all memory of the macro list after use.
 * @param m pointer to list macros
 */
void macro_list_destroy(macro_list *m)
{
  for (size_t i = 0; i < m->size; i++)
  {
    string_destroy(m->macro_list[i]->name);
    string_destroy(m->macro_list[i]->value);
    free(m->macro_list[i]);
  }
  free(m->macro_list);
  free(m);
}

/**
 * Creates a new arguments array
 * @return a pointer to the array
 */
size_t *arguments_create()
{
  size_t *a = (size_t *)calloc(BALANCE_CAPACITY, sizeof(size_t));
  return a;
}

/**
 * Resets values of the array.
 * @param a pointer to the array
 */
void arguments_reset(size_t *a)
{
  for (size_t i = 0; i < BALANCE_CAPACITY; i++)
  {
    a[i] = 0;
  }
}

/**
 * Copies argument values over from one to the next.
 * @param old_arguments pointer to the array
 * @param new_arguments pointer to the array
 */
void arguments_copy(size_t *old_arguments, size_t *new_arguments)
{
  for (size_t i = 0; i < BALANCE_CAPACITY; i++)
  {
    old_arguments[i] = new_arguments[i];
  }
}

/**
 * Destroys array.
 * @param a pointer to the array
 */
void arguments_destroy(size_t *a)
{
  free(a);
}

/**
 * States for the FSM (Finite State Machine) remove_comments
 * REMOVE_COMMENTS_PLAINTEXT --> reading any form of other text being used
 * REMOVE_COMMENTS_ESCAPE --> escape character case (example: \%)
 * REMOVE_COMMENTS_COMMENT --> comment case (anything after % is ommitted up until '\n')
 * REMOVE_COMMENTS_NEWLINE --> newline case (removal of white space after newline)
 */
typedef enum remove_comments
{
  REMOVE_COMMENTS_PLAINTEXT,
  REMOVE_COMMENTS_ESCAPE,
  REMOVE_COMMENTS_COMMENT,
  REMOVE_COMMENTS_NEWLINE
} remove_comments;

/**
 * States for the AFSM (Augmented Finite State Machine) parse_macros
 * MAIN_PARSER_PLAINTEXT --> reading any form of other text being used
 * MAIN_PARSER_ESCAPE --> escape character case (examples: \% \{ \})
 * MAIN_PARSER_MACRO --> expanding/performing a macro
 * MAIN_PARSER_ARGUMENTS --> argument(s) detection using a counter ({{}})
 */
typedef enum main_parser
{
  MAIN_PARSER_PLAINTEXT,
  MAIN_PARSER_ESCAPE,
  MAIN_PARSER_MACRO,
  MAIN_PARSER_ARGUMENTS
} main_parser;

/**
 * Determines proper state and changes it according to the character input.
 * @param remove_comments_current current state of the finite state machine
 * @param character pointer to character being read in
 * @param file_input pointer to the character buffer in which to store data
 */
void remove_comments_state_machine(remove_comments *remove_comments_current, char *character, string *file_input)
{
  switch (*remove_comments_current)
  {
    case REMOVE_COMMENTS_PLAINTEXT:
      if (*character == '%')
      {
        *remove_comments_current = REMOVE_COMMENTS_COMMENT;
      }
      else if (*character == '\\')
      {
        string_putchar(file_input, *character);
        *remove_comments_current = REMOVE_COMMENTS_ESCAPE;
      }
      else
      {
        string_putchar(file_input, *character);
      }
      break;
    case REMOVE_COMMENTS_ESCAPE:
      string_putchar(file_input, *character);
      *remove_comments_current = REMOVE_COMMENTS_PLAINTEXT;
      break;
    case REMOVE_COMMENTS_COMMENT:
      if (*character == '\n')
      {
        *remove_comments_current = REMOVE_COMMENTS_NEWLINE;
      }
      break;
    case REMOVE_COMMENTS_NEWLINE:
      if (*character == '%')
      {
        *remove_comments_current = REMOVE_COMMENTS_COMMENT;
      }
      else if (*character == '\\')
      {
        string_putchar(file_input, *character);
        *remove_comments_current = REMOVE_COMMENTS_ESCAPE;
      }
      else if (*character != ' ' && *character != '\t')
      {
        string_putchar(file_input, *character);
        *remove_comments_current = REMOVE_COMMENTS_PLAINTEXT;
      }
      break;
  }
}

/**
 * Determines proper state and changes it according to the character input.
 * @param main_parser_current current state of the augmented finite state machine
 * @param character pointer to character being read in
 * @param result pointer to the resulting string
 * @param macro_list pointer to the macro list data structure
 * @param storage pointers to a storage string
 * @param arguments pointer to counter variables
 */
void main_parser_state_machine(main_parser *main_parser_current, char *character, string *result, macro_list *macro_list, string **storage, size_t *arguments)
{
  switch (*main_parser_current)
  {
    case MAIN_PARSER_PLAINTEXT:
      switch (*character)
      {
        case '\\':
          *main_parser_current = MAIN_PARSER_ESCAPE;
          break;
        default:
          string_putchar(result, *character);
          break;
      }
      break;
    case MAIN_PARSER_ESCAPE:
      if (*character == '\\' || *character == '#' || *character == '%' || *character == '{' || *character == '}')
      {
        string_putchar(result, *character);
        *main_parser_current = MAIN_PARSER_PLAINTEXT;
      }
      else if (isalnum(*character))
      {
        string_putchar(storage[0], *character);
        *main_parser_current = MAIN_PARSER_MACRO;
      }
      else
      {
        string_putchar(result, '\\');
        string_putchar(result, *character);
        *main_parser_current = MAIN_PARSER_PLAINTEXT;
      }
      break;
    case MAIN_PARSER_MACRO:
      if (*character == '{')
      {
        arguments[0]++;
        arguments[1]++;
        *main_parser_current = MAIN_PARSER_ARGUMENTS;
      }
      else if (!isalnum(*character))
      {
        DIE("%s", "macro name contains a non-alphanumeric character");
      }
      else
      {
        string_putchar(storage[0], *character);
      }
      break;
    case MAIN_PARSER_ARGUMENTS:
      if (strcmp(storage[0]->string, "def") == 0)
      {
        switch (arguments[1])
        {
          case 1:
            if (*character == '}')
            {
              arguments[1]++;
              arguments[0]--;
            }
            else
            {
              string_putchar(storage[1], *character);
            }
            break;
          case 2:
            if (*character == '{')
            {
              if (arguments[0] == 0)
              {
                arguments[0]++;
              }
              else
              {
                string_putchar(storage[2], *character);
                arguments[0]++;
              }
            }
            else if (*character == '}')
            {
              if (arguments[0] == 1)
              {
                if (macro_list_compute_index(macro_list, storage[1]->string) > -1)
                {
                  DIE("%s", "the macro is already defined");
                }

                // adds a user defined macro to the list of macros
                macro_list_add(macro_list, storage[1]->string, storage[1]->size, storage[2]->string, storage[2]->size);

                storage_flush(storage);
                arguments[0]--;
                arguments[1] = 0;

                *main_parser_current = MAIN_PARSER_PLAINTEXT;
              }
              else
              {
                string_putchar(storage[2], *character);
                arguments[0]--;
              }
            }
            else
            {
              string_putchar(storage[2], *character);
            }

            // error handling
            if (!isalnum(*character) && *character != '{' && *character != '}' && arguments[0] == 0)
            {
              DIE("%s", "missing arguments");
            }
            break;
        }
      }
      else if (strcmp(storage[0]->string, "undef") == 0)
      {
        if (*character == '}')
        {
          macro_list_remove(macro_list, storage[1]->string);

          storage_flush(storage);
          arguments[0]--;
          arguments[1] = 0;

          *main_parser_current = MAIN_PARSER_PLAINTEXT;
        }
        else
        {
          string_putchar(storage[1], *character);
        }
      }
      else if (strcmp(storage[0]->string, "if") == 0)
      {
        switch (arguments[1])
        {
          case 1:
            if (*character == '}')
            {
              arguments[0]--;
              arguments[1]++;
            }
            else
            {
              string_putchar(storage[1], *character);
            }
            break;
          case 2:
            if (*character == '{')
            {
              if (arguments[0] == 0)
              {
                arguments[0]++;
              }
              else
              {
                string_putchar(storage[2], *character);
                arguments[0]++;
              }
            }
            else if (*character == '}')
            {
              if (arguments[0] == 1)
              {
                arguments[0]--;
                arguments[1]++;
              }
              else
              {
                string_putchar(storage[2], *character);
                arguments[0]--;
              }
            }
            else
            {
              string_putchar(storage[2], *character);
            }

            // error handling
            if (!isalnum(*character) && *character != '{' && *character != '}' && arguments[0] == 0)
            {
              DIE("%s", "missing arguments");
            }
            break;
          case 3:
            if (*character == '{')
            {
              if (arguments[0] == 0)
              {
                arguments[0]++;
              }
              else
              {
                string_putchar(storage[3], *character);
                arguments[0]++;
              }
            }
            else if (*character == '}')
            {
              if (arguments[0] == 1)
              {
                *main_parser_current = MAIN_PARSER_PLAINTEXT;

                string **if_storage = storage_create();
                size_t *if_arguments = arguments_create();

                if (storage[1]->size > 0)
                {
                  for (size_t i = 0; i < storage[2]->size; i++)
                  {
                    main_parser_state_machine(main_parser_current, &storage[2]->string[i], result, macro_list, if_storage, if_arguments);
                  }
                }
                else
                {
                  for (size_t i = 0; i < storage[3]->size; i++)
                  {
                    main_parser_state_machine(main_parser_current, &storage[3]->string[i], result, macro_list, if_storage, if_arguments);
                  }
                }

                storage_flush(storage);
                arguments[0]--;
                arguments[1] = 0;

                storage_copy(storage, if_storage);
                arguments[0] += if_arguments[0];
                arguments[1] = if_arguments[1];

                storage_destroy(if_storage);
                arguments_destroy(if_arguments);
              }
              else
              {
                string_putchar(storage[3], *character);
                arguments[0]--;
              }
            }
            else
            {
              string_putchar(storage[3], *character);
            }

            // error handling
            if (!isalnum(*character) && *character != '{' && *character != '}' && arguments[0] == 0)
            {
              DIE("%s", "missing arguments");
            }
            break;
        }
      }
      else if (strcmp(storage[0]->string, "ifdef") == 0)
      {
        switch (arguments[1])
        {
          case 1:
            if (*character == '}')
            {
              arguments[0]--;
              arguments[1]++;
            }
            else
            {
              string_putchar(storage[1], *character);
            }
            break;
          case 2:
            if (*character == '{')
            {
              if (arguments[0] == 0)
              {
                arguments[0]++;
              }
              else
              {
                string_putchar(storage[2], *character);
                arguments[0]++;
              }
            }
            else if (*character == '}')
            {
              if (arguments[0] == 1)
              {
                arguments[0]--;
                arguments[1]++;
              }
              else
              {
                string_putchar(storage[2], *character);
                arguments[0]--;
              }
            }
            else
            {
              string_putchar(storage[2], *character);
            }

            // error handling
            if (!isalnum(*character) && *character != '{' && *character != '}' && arguments[0] == 0)
            {
              DIE("%s", "missing arguments");
            }
            break;
          case 3:
            if (*character == '{')
            {
              if (arguments[0] == 0)
              {
                arguments[0]++;
              }
              else
              {
                string_putchar(storage[3], *character);
                arguments[0]++;
              }
            }
            else if (*character == '}')
            {
              if (arguments[0] == 1)
              {
                *main_parser_current = MAIN_PARSER_PLAINTEXT;

                string **ifdef_storage = storage_create();
                size_t *ifdef_arguments = arguments_create();

                if (macro_list_compute_index(macro_list, storage[1]->string) < 0)
                {
                  for (size_t i = 0; i < storage[3]->size; i++)
                  {
                    main_parser_state_machine(main_parser_current, &storage[3]->string[i], result, macro_list, ifdef_storage, ifdef_arguments);
                  }
                }
                else
                {
                  for (size_t i = 0; i < storage[2]->size; i++)
                  {
                    main_parser_state_machine(main_parser_current, &storage[2]->string[i], result, macro_list, ifdef_storage, ifdef_arguments);
                  }
                }

                storage_flush(storage);
                arguments[0]--;
                arguments[1] = 0;

                storage_copy(storage, ifdef_storage);
                arguments[0] += ifdef_arguments[0];
                arguments[1] = ifdef_arguments[1];

                storage_destroy(ifdef_storage);
                arguments_destroy(ifdef_arguments);
              }
              else
              {
                string_putchar(storage[3], *character);
                arguments[0]--;
              }
            }
            else
            {
              string_putchar(storage[3], *character);
            }

            // error handling
            if (!isalnum(*character) && *character != '{' && *character != '}' && arguments[0] == 0)
            {
              DIE("%s", "missing arguments");
            }
            break;
        }
      }
      else if (strcmp(storage[0]->string, "include") == 0)
      {
        if (*character == '}')
        {
          // current state of the remove comments parser
          remove_comments include_remove_comments_current = REMOVE_COMMENTS_PLAINTEXT;

          // store all file input in string data structure
          string *include_file_input = string_create();

          // parse through input and remove comments accordingly
          FILE *f = fopen(storage[1]->string, "r");
          if (f == NULL)
          {
            DIE("%s", "file input not found");
          }

          while ((*character = fgetc(f)) != EOF)
          {
            remove_comments_state_machine(&include_remove_comments_current, character, include_file_input);
          }
          fclose(f);

          // current state of the main parser
          main_parser include_main_parser_current = MAIN_PARSER_PLAINTEXT;

          string **include_storage = storage_create();
          size_t *include_arguments = arguments_create();

          for (size_t i = 0; i < include_file_input->size; i++)
          {
            main_parser_state_machine(&include_main_parser_current, &include_file_input->string[i], result, macro_list, include_storage, include_arguments);
          }

          string_destroy(include_file_input);

          storage_flush(storage);
          arguments[0]--;
          arguments[1] = 0;

          storage_copy(storage, include_storage);
          arguments[0] += include_arguments[0];
          arguments[1] = include_arguments[1];

          storage_destroy(include_storage);
          arguments_destroy(include_arguments);

          *main_parser_current = include_main_parser_current;
        }
        else
        {
          string_putchar(storage[1], *character);
        }
      }
      else if (strcmp(storage[0]->string, "expandafter") == 0)
      {
        switch (arguments[1])
        {
          case 1:
            if (*character == '}')
            {
              if (arguments[0] == 1)
              {
                arguments[0]--;
                arguments[1]++;
              }
              else
              {
                string_putchar(storage[1], *character);
                arguments[0]--;
              }
            }
            else if (*character == '{')
            {
              string_putchar(storage[1], *character);
              arguments[0]++;
            }
            else
            {
              string_putchar(storage[1], *character);
            }
            break;
          case 2:
            if (*character == '}')
            {
              if (arguments[0] == 1)
              {
                // current state of the main parser
                main_parser expandafter_main_parser_current = MAIN_PARSER_PLAINTEXT;

                string **expandafter_storage = storage_create();
                size_t *expandafter_arguments = arguments_create();

                for (size_t i = 0; i < storage[2]->size; i++)
                {
                  main_parser_state_machine(&expandafter_main_parser_current, &storage[2]->string[i], storage[1], macro_list, expandafter_storage, expandafter_arguments);
                }

                expandafter_main_parser_current = MAIN_PARSER_PLAINTEXT;

                storage_flush(expandafter_storage);
                arguments_reset(expandafter_arguments);

                for (size_t i = 0; i < storage[1]->size; i++)
                {
                  main_parser_state_machine(&expandafter_main_parser_current, &storage[1]->string[i], result, macro_list, expandafter_storage, expandafter_arguments);
                }

                storage_flush(storage);
                arguments[0]--;
                arguments[1] = 0;

                storage_copy(storage, expandafter_storage);
                arguments[0] += expandafter_arguments[0];
                arguments[1] = expandafter_arguments[1];

                storage_destroy(expandafter_storage);
                arguments_destroy(expandafter_arguments);

                *main_parser_current = expandafter_main_parser_current;
              }
              else
              {
                string_putchar(storage[2], *character);
                arguments[0]--;
              }
            }
            else if (*character == '{')
            {
              if (arguments[0] == 0)
              {
                arguments[0]++;
              }
              else
              {
                string_putchar(storage[2], *character);
                arguments[0]++;
              }
            }
            else
            {
              string_putchar(storage[2], *character);
            }

            // error handling
            if (!isalnum(*character) && *character != '{' && *character != '}' && arguments[0] == 0)
            {
              DIE("%s", "missing arguments");
            }
            break;
        }
      }
      else
      {
        if (*character == '}')
        {
          if (arguments[0] == 1)
          {
            int index = macro_list_compute_index(macro_list, storage[0]->string);
            if (index >= 0)
            {
              // current state of the main parser
              main_parser user_defined_main_parser_current = MAIN_PARSER_PLAINTEXT;

              string **user_defined_storage = storage_create();
              size_t *user_defined_arguments = arguments_create();

              for (size_t i = 0; i < macro_list->macro_list[index]->value->size; i++)
              {
                if (macro_list->macro_list[index]->value->string[i] == '#')
                {
                  for (size_t i = 0; i < storage[1]->size; i++)
                  {
                    main_parser_state_machine(&user_defined_main_parser_current, &storage[1]->string[i], storage[2], macro_list, user_defined_storage, user_defined_arguments);
                  }

                  storage_flush(user_defined_storage);
                  arguments_reset(user_defined_arguments);

                  user_defined_main_parser_current = MAIN_PARSER_PLAINTEXT;
                }
                else
                {
                  string_putchar(storage[2], macro_list->macro_list[index]->value->string[i]);
                }
              }

              for (size_t i = 0; i < storage[2]->size; i++)
              {
                main_parser_state_machine(&user_defined_main_parser_current, &storage[2]->string[i], result, macro_list, user_defined_storage, user_defined_arguments);
              }

              storage_flush(storage);
              arguments[0]--;
              arguments[1] = 0;

              storage_copy(storage, user_defined_storage);
              arguments[0] += user_defined_arguments[0];
              arguments[1] = user_defined_arguments[1];

              storage_destroy(user_defined_storage);
              arguments_destroy(user_defined_arguments);

              *main_parser_current = user_defined_main_parser_current;
            }
            else
            {
              DIE("%s", "macro was not found");
            }
          }
          else
          {
            string_putchar(storage[1], *character);
            arguments[0]--;
          }
        }
        else if (*character == '{')
        {
          string_putchar(storage[1], *character);
          arguments[0]++;
        }
        else
        {
          string_putchar(storage[1], *character);
        }
      }
      break;
  }
}

int main(int argc, char **argv)
{
  // the character that is read in
  char character;

  // current state of the remove comments parser
  remove_comments remove_comments_current = REMOVE_COMMENTS_PLAINTEXT;

  // store all file input in string data structure
  string *file_input = string_create();

  // check if there is file input from the command line
  if (argc > 1)
  {
    // parse through all file input and copy into string ignoring comments
    for (int i = 1; i < argc; i++)
    {
      // open every file in sequence in the command line arguments
      FILE *f = fopen(argv[i], "r");

      // parse through input and remove comments accordingly
      while ((character = fgetc(f)) != EOF)
      {
        remove_comments_state_machine(&remove_comments_current, &character, file_input);
      }
      fclose(f);
    }
  }
  else
  {
    while ((character = getc(stdin)) != EOF)
    {
      remove_comments_state_machine(&remove_comments_current, &character, file_input);
    }
  }

  // current state of the main parser
  main_parser main_parser_current = MAIN_PARSER_PLAINTEXT;

  // store everything in resulting string
  string *result = string_create();

  // create array of structs for user-defined macros
  macro_list *macro_list = macro_list_create();

  // create character buffer + arguments storage container
  string **storage = storage_create();
  size_t *arguments = arguments_create();

  for (size_t i = 0; i < file_input->size; i++)
  {
    // parse through the file input and expand macros
    character = file_input->string[i];
    main_parser_state_machine(&main_parser_current, &character, result, macro_list, storage, arguments);
  }

  if (arguments[0] != 0)
  {
    // terminate the program if it is not brace balanced
    DIE("%s", "program is not brace balanced");
  }

  string_print(result);

  // free all information used by the program
  string_destroy(file_input);

  string_destroy(result);
  macro_list_destroy(macro_list);

  storage_destroy(storage);
  arguments_destroy(arguments);
}
