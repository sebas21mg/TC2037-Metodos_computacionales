# Recursive definitions

## Template

**I. Basis:** $0 \in \N$

**II. Recursive step:** if $n \in \N$ then $s(n) \in \N$, where $s(n) = n + 1$

**III. Closure:** $n \in \N$ only if it can be obtained from $0$ by a finite number of applications of the operation $s$

## Example 1: Recursive definition of Factorial

I. **Basis**: $ f(0) = 1 $

II. **Recursive Step**: If $ f(n) = x $ then $ f(n + 1) = f(n) \times (n + 1) $

III. **Closure**: $ f(n) = x $ only if it can be obtained from the base case using a finite number of applications of the recursive step

<br>

## Expamle 2: Set $ X = \{3, 6, 12, 24, ...\} $

I. **Basis**: $ 3 \in X $

II. **Recursive Step**: If $ n \in X $ then $ 2n \in X $

III. **Closure**: $ n \in X $ only if it can be obtained from the **basis** using a finite number of applications of the **recursive step**

# Inductive demonstrations

## Example 1:

I. **Basis**: $[0, 1] \ 0 < 1$

II. **Inductive Hypothesis**: Assume that $ x < y $ for all elements $ [x, y] \in LT_n $

III. **Inductive Step**: for value $ [i, y] \in LT\_{n + 1} $

$ [i, j] = [x, s(y)] $

$ [i, j] = [s(x), s(y)] $

$ \square $ <!-- to indicate the end of the demonstration -->

## Example 2:

Demonstrate: $\sum_{i=0}^{n}i = \frac{n(n+1)}{2}$

I. **Basis**: If $n = 0$ then $\frac{0(0+1)}{2} = \frac{0}{2}=0$

II. **Inductive Hypothesis**: If $n = k$ then it holds that

$$\sum_{i=0}^{k}i = \frac{k(k+1)}{2}$$

III. **Inductive Step**: For $n = (k+1)$

$$\sum_{i=0}^{(k+1)}i = \frac{(k+1)((k+1)+1)}{2}$$

$$\sum_{i=0}^{k}i + (k + 1) = \frac{(k+1)((k+1)+1)}{2}$$

$$\frac{k(k+1)}{2} + (k+1) = \frac{(k+1)((k+1)+1)}{2}$$

$$\frac{k(k+1)}{2} + \frac{2(k+1)}{2} = \frac{(k+1)((k+1)+1)}{2}$$

$$\frac{k(k+1) + 2(k+1)} {2} = \frac{(k+1)((k+1)+1)}{2}$$

$$\frac{(k+1) + (k+2)} {2} = \frac{(k+1)((k+1)+1)}{2}$$

$$\frac{(k+1) + (k+1+1)} {2} = \frac{(k+1)((k+1)+1)}{2}$$

$$\frac{(k+1) + ((k+1)+1)} {2} = \frac{(k+1)((k+1)+1)}{2}$$

$$\square$$
