#lang racket

(provide (all-defined-out)) ; Provee todas las funciones

; Saber si un año es bisiesto
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
