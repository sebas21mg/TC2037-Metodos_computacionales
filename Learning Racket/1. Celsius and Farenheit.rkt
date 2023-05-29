#| 
Functions to convert between temperatures units
(Celsius and Farenheit)
|#

#lang racket

(provide (all-defined-out)) ; Provee todas las funciones. Sin esto no se pueden usar las funciones

(define (C->F celsius)
  (+ (* celsius (/ 9 5.0)) 32))

(define (F->C farenheit)
  (* (- farenheit 32) (/ 5 9.0)))

; Ejemplo de cómo usar una función
(C->F 32)