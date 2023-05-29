#lang racket

(provide (all-defined-out)) ; Provee todas las funciones
(require racket/trace) ; Es necesario para poder usar el 'trace' que sirve para poder ver el proceso que ha hecho una función


; - Funciones anónimas
; Se usa para crear variables locales (muy útil para manipular valores de otras variables sin modificarlas directamente)
(let 
  ; Declaración de variables
  ([b 7] 
   [c 3]) 
  
  ; Cuerpo de la función
  (+ b c))

; Se usa para crear funciones anónimas
((lambda (b c) ; Argumentos
  (+ b c)) ; Cuerpo
7 3) ; Números a usar

; - Funciones con nombre
; Sólo es un ejemplo de cómo se podría hacer, pero realmente no tiene sentido ponerle nombre a una 
; función que es para hacer funciones anónimas
(define nombreFuncion (lambda (b c) (+ b c)))

; Esta forma de hacer funciones es muy útil para hacer funciones recursivas
(let test 
  ([b 7]
   [c 3])
   
  (+ b c))

; - Ejemplos
; Factorial de un número usando tail y let
(define (! n)
  (trace-let loop ; Para hacer el trace

    ([n n]
     [res 1])

    (if (zero? n)
      res
      (loop (sub1 n) (* n res)))))

; sumDigits con let y tail
(define (sumDigits n)
  (let loop ; Sin el trace

    ([n n]
     [res 0])

    (if (zero? n)
      res
      (loop (quotient n 10) (+ res (remainder n 10))))))