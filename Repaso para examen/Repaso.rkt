#lang racket

(provide (all-defined-out))
(require racket/trace) ; Es necesario para poder usar el 'trace' que sirve para poder ver el proceso que ha hecho una función

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

#|
Write a function to sort a list using selection sort.
|#

(define (selection-sort lst)
  (trace-let loop
  
    ([big-lst lst]
     [lst lst]
     [min (car lst)]
     [res '()])
  
    (if (empty? big-lst)
      (reverse res)
      (if (empty? lst) 
          (loop 
            (cdr big-lst)
            (cdr big-lst)
            (car (cdr big-lst)) 
            (cons min res)
          )
          (loop 
            big-lst 
            (cdr lst) 
            (if (< (car lst) min) 
              (car lst) 
              min) 
            res
          )
      )
    )
  )

)
(selection-sort '(6 8 3 5 9 10 7 2 4 1))