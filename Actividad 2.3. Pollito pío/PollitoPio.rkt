#| 
Actividad 2.3 Programación funcional, parte 3

Sebastian Moncada
|#

#lang racket

(require racket/trace) ; Es necesario para poder usar el 'trace'
(provide (all-defined-out)) ; Provee todas las funciones

(define (sounds-lyrics animals index)

    (define sounds (list "Pio" "Coo" "Corocó" "Glú Glú Glú" "Ruu" "Miao" "Guau Guau" "Mee" "Bee" "Moo" "Muu"))

    (let loop

        ([animals animals]
        [sounds sounds]
        [index index])

        (if (> index 0)

            (begin 
                (display (string-append "  Y " (if (string=? (car (string-split (list-ref animals (sub1 index)) " ")) "un") "el" "la") " " (car (cdr (string-split (list-ref animals (sub1 index)) " "))) " " (list-ref sounds (sub1 index)) "\n"))
                (loop animals sounds (sub1 index))
            )
            "")))

(define (pollito-lyrics)

    (define animals (list "un Pollito" "una Gallina" "un Gallo" "un Pavo" "una Paloma" "un Gato" "un Perro" "una Cabra" "un Cordero" "una Vaca" "un Toro"))

    (if (empty? animals)

        (display "En la radio hay un tractor\n")

        (let loop

            ([originalAnimals animals]
            [animals animals]
            [index 1])

            (if (empty? animals)
                (display "\nEn la radio hay un tractor\n  Y el Tractor: Bruum\n  Y el Pollito: oh oh!\n\n")
                (begin
                    (display (string-append "\nEn la radio hay " (if (string? (car animals)) (car animals) "") "\n"))
                    (sounds-lyrics originalAnimals index)
                    (loop originalAnimals (cdr animals) (add1 index))
                )))))