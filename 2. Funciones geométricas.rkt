#lang racket

(provide (all-defined-out))

(define (areaCirculo r)
  (* pi r r)
)

(define (perimetroCirculo r)
  (* pi r 2)
)

(define (areaTriangulo b h)
  (/ (* b h) 2.0)
)