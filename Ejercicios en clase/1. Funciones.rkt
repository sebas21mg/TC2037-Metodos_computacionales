#| 
Functions to convert between temperatures units
(Celsius and Farenheit)
|#

#lang racket

(require racket/trace) ; Es necesario para poder usar el 'trace'

(provide (all-defined-out)) ; Provee todas las funciones

; Give a name to a value. A "variable"
(define data 46.7)

(define (C->F celsius)
  (+ (* celsius (/ 9 5.0)) 32)
)

(define (F->C farenheit)
  (* (- farenheit 32) (/ 5 9.0))
)
(define (areaCirculo r)
  (* pi r r)
)

(define (perimetroCirculo r)
  (* pi r 2)
)

(define (areaTriangulo b h)
  (/ (* b h) 2.0)
)

; Año bisiesto
(define (leap year)
  (and 
    (= 0 (remainder year 4)) ; 'remainder' es el residuo, ya viene en Racket
    (or 
      (not (= 0 (remainder year 100)))
      (= 0 (remainder year 400))
    )
  )
)

; Días de los meses con año bisiesto
(define (monthDays month year)
  (case month
    [(4 6 9 11) 30]
    [(2) (if (leap year) 29 28)]
    [else 31]
  )
)

(define (nextDay day month year)
  (if (= day (monthDays month year))
    (if (= 12 month)
      (list 1 1 (add1 year)) ; último mes del año
      (list 1 (add1 month) year) ; último día del mes
    )
    (list (add1 day) month year)
  )
)

(define (sumDigits n)
  (if (zero? n)
    0
    (+ 
      (remainder n 10) 
      (sumDigits (quotient n 10))
    )
  )
)
(trace sumDigits)

(define (tailSumDigits num)

  (define (loop num res)
  
    (if (zero? num)
      res
      (loop (quotient num 10) (+ res (remainder num 10)))
    )

  )
  (trace loop)
  (loop num 0)

)

(define (! n)
  (if (zero? n)
    1
    (* n (! (sub1 n)))
  )
)
(trace !)

; Using Tail Recursion
(define (tail! n)
  ; Define an internal function
  (define (doTail! n a)
    (if (zero? n)
      a
      (doTail! (sub1 n) (* n a))
    )
  )
  ; The accumulator is initialized with the value for the base case
  (trace doTail!)
  (doTail! n 1)
)
; Para que aparezcon los pasos que está siguiendo la función recursiva
(trace tail!)

; (let ([b 7] [c 3]) (+ b c)) Una función anónima que define variables pero sólo para la función
; ((lambda (b c) (+ b c)) 7 3) Hace lo mismo que let
; (define nombreFuncion (lambda (b c) (+ b c))) Ahora ya no es una función anónima porque ahora tiene nombre
; (let test ([b 7] [c 3]) (+ b c)) Ahora ya no es anónima porque tiene nombre. Aunque no se pueda usar de nuevo, sirve para poder hacer recursión


; Otro factorial pero ahora es tail y con la sintaxis de let
(define (!! n)
  (trace-let loop ; Para hacer el trace
  ; (let loop
    ([n n]
    [a 1])

    (if (zero? n)
      a
      (loop (sub1 n) (* n a))
    )
  )
)

; sumDigits con let y tail
(define (sumDigitsL n)
  (trace-let loop

    ([n n]
    [res 0])


    (if (zero? n)
      res
      (loop (quotient n 10) (+ res (remainder n 10)))
    )

  )
)

