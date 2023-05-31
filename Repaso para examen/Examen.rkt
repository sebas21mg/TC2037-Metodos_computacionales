#lang racket

(provide (all-defined-out))
(require racket/trace) ; Es necesario para poder usar el 'trace' que sirve para poder ver el proceso que ha hecho una función

(define (doble lst)
  (trace-let loop
    
    ([lst lst]
     [res '()])
     
      (if (empty? lst)
        (reverse res)
        (loop
          (cdr lst)
          (cons (* (car lst) -1) (cons (car lst) res))))))

(doble '(7 2 4 9 2))