#lang racket

(provide (all-defined-out))

(define (multiplied-by-index lst)
  (let loop 

    ([lst lst]
     [index 1]
     [res '()])

    (if (empty? lst)
      (reverse res)
      (loop 
        (cdr lst)
        (add1 index)
        (cons (* (car lst) index) res)))))

(multiplied-by-index '(5 2 9 4 2))

(define (ends-with-4 lst)
  (let loop
  
    ([lst lst]
     [res '()])

    (if (empty? lst)
      (reverse res)
      (loop
        (cdr lst)
        (if (eq? (remainder (car lst) 10) 4)
          (cons (car lst) res)
          res)))))

(ends-with-4 '(104 8 29 4 58 93754 93 24))