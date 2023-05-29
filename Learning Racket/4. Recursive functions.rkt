#lang racket

(provide (all-defined-out)) ; Provee todas las funciones
(require racket/trace) ; Es necesario para poder usar el 'trace' que sirve para poder ver el proceso que ha hecho una función

; Suma todos los digitos de un número
(define (sumDigits n)
  (if (zero? n)
    0
    (+ 
      (remainder n 10) 
      (sumDigits (quotient n 10))
    )
  )
)
(trace sumDigits) ; Poder ver el proceso que hace la función

; Hacer misma función recursiva pero ahora con "cola"
; Esto es para que la función vaya guardando en una variable el resultado y así no tengo que
; "entrar" y "salir" de la función, sino que sólo entra, lo que acorta el tiempo de procesado
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

; Factorial de un número
(define (! n)
  (if (zero? n)
    1
    (* n (! (sub1 n)))
  )
)
(trace !)

; Using tail recursion
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

