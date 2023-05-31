#lang racket

(provide (all-defined-out))

(define (*** lst)
  (let loop

    ([lst lst]
     [res '()])

    (if (empty? lst)
      (reverse res)
      (loop
        (cdr lst)
        (cons (* (car lst) (car lst) (car lst)) res)))))

(*** '(8 2 5 3 1))

(define (multiplos3 lst)
  (let loop
    
    ([lst lst]
     [res '()])
     
    (if (empty? lst)
      (reverse res)
      (loop 
        (cdr lst)
        (if (eq? (remainder (car lst) 3) 0)
          (cons (car lst) res)
          res
        )))))

(multiplos3 '(28 37 23 12 9 482 44 29 24))