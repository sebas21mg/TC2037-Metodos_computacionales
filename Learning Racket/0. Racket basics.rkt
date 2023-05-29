; Clase 20 - 02 - 23

; To be able to use the language
#lang racket

; Display something
(display "Hello world!\n")

; Make operation or functions
(+ 3 5)

; Nested operations
(- 1 (* 8 4))

; Lists
(range 1 9)

; Sum of the list elements
(apply + (range 1 9))

; Syntax for arithmetic operations
(println (- (* 3 6) (/ 4 3.0)))

; Define a variable
(define data 46.7)

; Condicional
(if (> 5 1)
  #t
  #f)

; - Listas

'(3,6) ;la comilla es para que no llame a ninguna función, para definir algo literalmente

(cons 3 6) ;Permite crear una estructura con dos partes ;Cons es una constuccion

(define par (cons 3 6)) ; par define un par

par

(car par) ; devuelve el primer elemento content of address register

(cdr par) ; devuelve el segundo element content of the reference register

(cons 3 (cons 4 (cons 5 null)))

`(3 4 5)

(list 3 4 5)

'((sqrt 3)(sqrt 4) (sqrt 5))

(list (sqrt 3) (sqrt 4) (sqrt 5))

(define lst `(1 2 3 4 5 6))
lst

(car lst)

(cdr lst)

(cons 0 lst) ; no modifica la lista hace una copia y le anade el 0

(length lst)

lst

(append lst '(7)) ; append une 2 listas

;(append lst (7))

lst ; inmutabilidad. Nunca va a modificar la lista original. Al menos que la declares

lst

(list-ref lst 0)

(cons 9 lst)

(cons '(9) lst)

(cons "Testing" lst)

(first lst)

(rest lst)

(cadddr lst)

(car (cdr (cdr (cdr lst))))

(cadddr lst)

(first lst)

(second lst)

(third lst)

(rest lst)

lst ; el indice de la lista incia en 0

(append lst lst)

(append lst 4)

(append )