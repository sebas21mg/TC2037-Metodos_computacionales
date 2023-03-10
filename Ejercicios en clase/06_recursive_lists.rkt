#|
Funciton to work with lsits recursively

David Vieyra
2023-03-06
|#

#lang racket

(require racket/trace)

(provide lst len sum-tail sqrt-list sqrt-list-alt)

(define lst '(1 2 3 4 5 6 7 8))

; Recreate the functionality og 'length'
; Return the number of elements in a list
(define (len lst)
  (if (empty? lst); el signo de interrogacion es de predicado, es decir (true or false); En este caso verifica si esta vacia la lista
      0
      (+ 1 (len (cdr lst)))))

(trace len)

; Reimplement length using tail recursion
(define (len-tail lst)
  (trace-let loop
    ([lst lst]
     [res 0])
    (if (empty? lst)
        res
        (loop (cdr lst) (+ 1 res)))))

; Funcion que sume todos los elementos de la lista
(define (sum-tail lst)
  (trace-let loop
    ([lst lst]
     [res 0])
    (if (empty? lst)
        res
        (loop (cdr lst) (+ (car lst) res)))))

; Function that receives a list and gives back every value of the list but sqrt
(define (sqrt-list lst)
  (let loop
    ([lst lst]
     [res '()])
  (if (empty? lst)
      res
      (loop (cdr lst)
            (append res(list (sqrt (car lst))))))))

; Alternative with cons

(define (sqrt-list-alt lst)
  (let loop
    ([lst lst]
     [res '()])
  (if (empty? lst)
      ; Invert the list so that it has the order of the original
      (reverse res)
      (loop (cdr lst)
            (cons(sqrt {car lst}) res)))))

;(time ((lambda () (sqrt-list (range 1000)) 'Done)) ;para checar el tiempo 
      