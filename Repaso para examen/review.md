# General review of the course

## Exam topics
- Recursive definitions
- Inductive tests
- Regular languages
    - DFA
    - Regular expressions
- Grammars
    - Production rules / Derivations
    - BNF / EBNF
- Racket
- Elixir

## Recursive definitions

1. Recursive definition of the strings in $\Sigma = \{a, b\}$ that contain twice as many $b$'s as $a$'s

    **I. Basis:** 

2. Recursive definition of palindromes on $\Sigma$

3. Recursive definition of multiplication, using addition and the succesor operator




## Inductive Hypothesis

1. Demonstrate that $P = W$ where $P$ is the set of palindromes, and $W = \{w \in \Sigma^* | w = w^R\}$

2. Prove that $1 + 2 + 2^2 + ... + 2^n = 2^{n+1} - 1$ for all $n > 0$


## Languages

1. Define a langage in $\Sigma = \{a, b\}$ that begins and ends with $a$ and always alternates between $a$ and $b$

2. Define a langage in $\Sigma = \{a, b\}$ that begins with $a$ or ends with $b$ and alternates between $a$ and $b$

3. Give a Regular Set definition in $\Sigma = \{a, b, c\}$ of the language with strings that contain two or more $b$'s

4. Give a Regular Set definition of the language with strings that contain an even number of $b$'s

5. Create a DFA for a language that consists of strings in $\Sigma = \{a, b, c\}$ where every $c$ is followed by an $a$

## Programming

1. Write a function in a funcional language that receives a list of integers, and returns a list, with each of its elements multiplied by its position.
Positions begin at 1.

2. Write a function in a functional language that receives a list of integers, and returns a new list with only the elements in the input that end in 4

3. Write a function to sort a list using selection sort
