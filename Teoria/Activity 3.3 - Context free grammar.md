# Activity 3.3 - Practicando los lenguajes libres de contexto

## Names

- Sebastian Moncada
- Samuel Acevedo

## 1. BNF

### Module

    <def-module> ::= defmodule <module-name> do\n<body>end
    <module-name> ::= <upper_var>
    <body> ::= <function>\n | <function>\n<body>

### Function

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

### Others

    <var> ::= <letter> | <letter><var> | <digit> | <digit><var> | \_<var> | \_
    <upper_var> ::= <upper_letter><var>

    <symbols> ::= <symbol> | <symbol><symbols>
    <symbol> ::= [ | ] | \  | \| | \\ | = | + | - | * | / | ( | ) | . | < | >

    <cond-symbols> ::= <cond-symbol> | <cond-symbol><cond-symbols>
    <cond-symbol> ::= < | > | =

    <letter> ::= a | b | c | d | e | f | g | h | i | j | k | l | m | n | o | p | q | r | s | t | u | v | w | x | y | z
    <upper_letter> ::= A | B | C | D | E | F | G | H | I | J | Q | L | M | N | O | P | Q | R | S | T | U | V | W | X | Y | Z
    <digit> ::= 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9

## 2. EBNF

### Module

    DEF-MODULE ::= 'defmodule' MODULE-NAME 'do\n' BODY 'end'
    MODULE-NAME ::= UPPER-VAR
    BODY ::= {FUNCTION '\n'}

### Function

    FUNCTION ::= SIMPLE-FUNC | SIMPLE-COND-FUNC | LARGE-FUNC

    SIMPLE-FUNC ::= DEF-DEFP FUNC ', do:' SINGLE-OUTPUT
    SIMPLE-COND-FUNC ::= DEF-DEFP FUNC ' when ' COND ', do:' SINGLE-OUTPUT
    LARGE-FUNC ::= DEF-DEFP FUNC ' do\n' OUTPUT 'end'

    DEF-DEFP ::= 'def' | 'defp'
    FUNC ::= FUNC-NAME ' (' PARAMETERS ')'
    FUNC-NAME ::= VAR

    STATEMENT ::= { VAR | SYMBOLS }
    PARAMETERS ::= STATEMENT | { STATEMENT ', ' } | { FUNC ', ' }
    COND ::= STATEMENT COND-SYMBOLS STATEMENT

    SINGLE-OUTPUT ::= STATEMENT | FUNC | STATEMENT FUNC
    OUTPUT ::= { SINGLE-OUTPUT '\n' }

### Others

    VAR ::= { LETTER | DIGIT | '_' }
    UPPER-VAR ::= UPPER-LETTER VAR

    SYMBOLS ::= { '[' | ']' | '\\' | '|' | '\\\\' | '=' | '+' | '-' | '*' | '/' | '(' | ')' | '.' | '<' | '>' }
    COND-SYMBOLS ::= { '<' | '>' | '=' }

    LETTER ::= 'a' | 'b' | 'c' | 'd' | 'e' | 'f' | 'g' | 'h' | 'i' | 'j' | 'k' | 'l' | 'm' | 'n' | 'o' | 'p' | 'q' | 'r' | 's' | 't' | 'u' | 'v' | 'w' | 'x' | 'y' | 'z'
    UPPER-LETTER ::= 'A' | 'B' | 'C' | 'D' | 'E' | 'F' | 'G' | 'H' | 'I' | 'J' | 'K' | 'L' | 'M' | 'N' | 'O' | 'P' | 'Q' | 'R' | 'S' | 'T' | 'U' | 'V' | 'W' | 'X' | 'Y' | 'Z'
    DIGIT ::= '0' | '1' | '2' | '3' | '4' | '5' | '6' | '7' | '8' | '9'
