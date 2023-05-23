# Activity 3.3 - Practicando los lenguajes libres de contexto

## Names

- Sebastian Moncada
- Samuel Acevedo

## Exercises

### 1. BNF

**Module**

    <def-module> ::= defmodule <module-name> do\n<body>\nend
    <module-name> ::= <upper_var>
    <body> ::= <function> | <function>\n<body>

**Function**

    <function> ::= <simple-func> | <simple-cond-func> | <large-func>

    <simple-func> ::= <def-defp> <func>, do: <single-output>
    <simple-cond-func> ::= <def-defp> <func> when <cond>, do: <single-output>
    <large-func> ::= <def-defp> <func> do\n<output>\nend

    <def-defp> ::= def | defp
    <func> ::= <func-name>(<parameters>)
    <func-name> ::= <var>

    <statement> ::= <var> | <var> <statement> | <symbols> | <symbols> <statement>
    <parameters> ::= <statement> | <statement>,  <parameters> | <func>,  <parameters>
    <cond> ::= <statement> <cond-symbols> <statement>

    <single-output> ::= <statement> | <func> | <statement><func>
    <output> ::= <single-output> | <single-output>\n<output>

**Others**

    <var> ::= <letter> | <letter><var> | <digit> | <digit><var> | \_<var> | \_
    <upper_var> ::= <upper_letter> <var>

    <symbols> ::= <symbol> | <symbol><symbols>
    <symbol> ::= [ | ] | \  | \| | \\ | = | + | - | * | / | ( | ) | .

    <cond-symbols> ::= <cond-symbol> | <cond-symbol><cond-symbols>
    <cond-symbol> ::= < | > | =

    <letter> ::= a | b | c | d | e | f | g | h | i | j | k | l | m | n | o | p | q | r | s | t | u | v | w | x | y | z
    <upper_letter> ::= A | B | C | D | E | F | G | H | I | J | Q | L | M | N | O | P | Q | R | S | T | U | V | W | X | Y | Z
    <digit> ::= 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9

### 2. EBNF

**Module**

    DEF-MODULE ::= 'defmodule' MODULE-NAME 'do' BODY 'end'
    MODULE-NAME ::= UPPER_ID
    BODY ::= FUNCTION | FUNCTION BODY

**Function**

    SIMPLE-FUNC ::= DEF-FUNC FUNC-NAME'('PARAMETERS')' 'do' OUTPUT 'end' |
    DEF-FUNC FUNC-NAME'('PARAMETERS')' ', do:' BODY
    DEF-FUNC ::= 'def' | 'defp'
    FUNC-NAME ::= ID
    PARAMETERS ::= PARAMETERS_LIST
    PARAMETERS_LIST ::= PARAMETER | PARAMETER PARAMETERS_LIST
    PARAMETER ::= ID
    OUTPUT ::= STATEMENT | STATEMENT OUTPUT
    STATEMENT ::= ID

**Others**

    ID ::= LETTER | DIGIT | ID ID | ID '\_'
    UPPER_ID ::= UPPER_LETTER ID

    LETTER ::= 'a' | 'b' | 'c' | ... | 'z'
    UPPER_LETTER ::= 'A' | 'B' | 'C' | ... | 'Z'
    DIGIT ::= '0' | '1' | '2' | '3' | ... | '9'
