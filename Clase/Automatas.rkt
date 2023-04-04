#lang racket

(provide (all-defined-out)) ; Provee todas las funciones
(require racket/trace) ; Es necesario para poder usar el 'trace'

; Declare the structure that describes a DFA
(struct dfa (func initial accept))

(define (evaluate-dfa dfa-to-evaluate string)
    (let loop
        ; Convert the string into a list of characters
        ([chars (string->list string)]
        ; Get the initial state of the dfa
         [state (dfa-initial dfa-to-evaluate)])

        (cond 
            ; When the listo of chars is over, check if the final state is acceptable
            [(empty? chars) (member state (dfa-accept dfa-to-evaluate))]
            [else (loop 
                ; Apply the transition function to get the next state
                (cdr chars)
                ((dfa-func dfa-to-evaluate) state (car chars))
        )])))


(define (transition-event-a-b state char)
    " Transition function
      Initial state: q0
      Accept states: q1 "
    (cond 
        [(eq? state 'q0) (cond
            [(eq? char #\a) 'q2]
            [(eq? char #\b) 'q1]
            [else 'inv])]
        [(eq? state 'q1) (cond
            [(eq? char #\a) 'q1]
            [(eq? char #\b) 'q1]
            [else 'inv])]
        [(eq? state 'q2) (cond
            [(eq? char #\a) 'q3]
            [(eq? char #\b) 'inv]
            [else 'inv])]
        [(eq? state 'q3) (cond
            [(eq? char #\a) 'q2]
            [(eq? char #\b) 'q1]
            [else 'inv])]
        [else 'inv]))

#| 
(struct dfa (func initial accept))
(define data (dfa transition-event-a-b 'q0 '(q1)))
data

(dfa-initial data)
|#
 
; Para probar todo esto
; (evaluate-dfa (dfa transition-event-a-b 'q0 '(q1)) "aabababbba") 