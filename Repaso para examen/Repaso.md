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

   **I. Basis:** $\lambda \in \Sigma$

   **II. Recursive step:** if $u \in \Sigma$, then $uaububu \in \Sigma$, $ubuaubu \in \Sigma$ and $ububuau \in \Sigma$

   **III. Closure:** $u \in \Sigma$ only if it can be obtained from the base case using a finite number of applications of the recursive step

2. Recursive definition of palindromes on $\Sigma$

   **I. Basis:** $\lambda \in \Sigma$, $i \in P$ and $i \in \Sigma$

   **II. Recursive step:** if $i \in P$ and $u \in \Sigma$ then $iui \in \Sigma$

   **III. Closure:** $u \in \Sigma$ only if it can be obtained from the base case using a finite number of applications of the recursive step

3. Recursive definition of multiplication, using addition and the succesor operator

   **I. Basis:** $res = 0$, $n \in \R$ and $m \in \R$

   **II. Recursive step:** if $a(m) = m - 1 \in \R^+$ then $res(n) = res + n$

   **III. Closure:** $res(n) = res + n$ only if it can be obtained from the base case using a finite number of applications of the recursive step

4. Iniciar con 5 e irle sumando 6

   **I Basis:** $r = 5$

   $a_0 = 5$

   **II. Recursive step:** if $n \in \N$ then $r(n) = $

   $a_n = a_{(n-1)} + 6$, where $n > 0$

   $a_1 = a_{1-1} + 6 = (5 + 6) = 11$

   $a_2 = a_{2-1} + 6 = (11 + 6) = 17$

## Inductive Hypothesis

1. Demonstrate that $P = W$ where $P$ is the set of palindromes, and $W = \{w \in \Sigma^* | w = w^R\}$

2. Prove that $1 + 2 + 2^2 + ... + 2^n = 2^{n+1} - 1$ for all $n > 0$

   **I. Basis:** res = 1

   **II. Inductive hypothesis:** Assume that for any value of $n \in \N$, _res_ would be $k-1\ |\ k = 2^{n+1}$

   **III. Inductive step:** Demonstrate that the same works for $n = 4$

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
