#lang racket

(require racket/trace) ; Es necesario para poder usar el 'trace'

(provide (all-defined-out)) ; Provee todas las funciones

(define (mult-by-index lst)

  (let loop
  
    ([lst lst]
    [index 1]
    [res '()])

    (if (empty? lst)
      (reverse res)
      (loop 
        (cdr lst)
        (add1 index)
        (cons (* index (car lst)) res)))))

(define (ends-with-4 lst)
  ( let loop
    ([lst lst]
    [res '()])

    (if (empty? lst)
      (reverse res)
      (loop 
        (cdr lst)
        (if (equal? 4 (remainder (car lst) 10))
          (cons (car lst) res)
          res
        )
      )
    )

))

; (define (ends-with-4 lst)
;   (let loop
;     ([lst lst]
;     [res '()])
;     (if (empty? lst)
;       (reverse res)
;       (loop (cdr lst)
;         (if (= 4 (remainder (car lst) 10))
;           (cons (car lst) res)
;           res)))))