#| 
Activity 2: 

Sebastián Moncada
Samuel Acevedo
|#

#lang racket

(require racket/trace)

(provide enlist list-of-symbols? swapper dot-product)

;Exercise 9:

(define (enlist lst)
    (trace-let loop
    ([lst lst]
     [res '()])
    (if (empty? lst)
    (reverse res)
    (loop (cdr lst) (cons (list (car lst))res)))))


; Exercises 13, 14, 15 and 16


; Exercise 13: 

(define (list-of-symbols? lst)
  (cond ((null? lst) #t) ; base, if the list is empty
        ((symbol? (car lst)) ; verifies if the first element of the list is a symbol
         (list-of-symbols? (cdr lst))) ; call recursively the function for the res of the list
        (else #f))) ; if the first element of the list is not a symbol, it shows false

; Exercise 14:

(define (swapper a b lst)
  (cond ((null? lst) '()) ; Base, if the list is empty
        ((equal? (car lst) a) (cons b (swapper a b (cdr lst)))) ; If the first element of the list is equal to the element 'a', it replaces the element 'a' with the element 'b' and calls the fucntion with the rest of the list
        ((equal? (car lst) b) (cons a (swapper a b (cdr lst)))) ; If the first element of the list is equal to the element 'b', it replaces the element 'b' with the element 'a' and calls the function with the rest of the list
        (else (cons (car lst) (swapper a b (cdr lst))))) ; If the first element is neither equal to the element 'a' or 'b', it add it to the list and calls the function with the rest.
) 

; Exercise 15:

(define (dot-product lst1 lst2)
    (if (or (null? lst1) (null? lst2)) ; Checks if both lists are empty
    0 ;If that's the case it returns 0
    (+ (* (car lst1)(car lst2)) ; It multiplies the first elements of both lists and add them
    (dot-product (cdr lst1) (cdr lst2)))) ; It calls the function recursively with the rest of the lists.
)
