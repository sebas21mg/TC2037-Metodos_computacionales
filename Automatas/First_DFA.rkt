; La representación física del autómata es el de la imagen 'Automata simple'

#lang racket

(provide (all-defined-out)) ; Provee todas las funciones
(require racket/trace) ; Es necesario para poder usar el 'trace'

; Declare the structure that describes a DFA
(struct dfa (func initial accept))

(define (evaluate-dfa dfa-to-evaluate string-to-evaluate)
    (let loop
        
        ([chars (string->list string-to-evaluate)] ; Convert the string into a list of characters
         [state (dfa-initial dfa-to-evaluate)]) ; Get the initial state of the dfa

        (cond 
            ; When the list of chars is over, check if the final state is acceptable
            [(empty? chars) (member state (dfa-accept dfa-to-evaluate))]
            ; Apply the transition function to get the next state
            [else (loop 
                (cdr chars)
                ((dfa-func dfa-to-evaluate) state (car chars)))])))


(define (transition-event-a-b initial-state accept-states)
    " Transition function to validate (a* (bb+))*
      Initial state: q0
      Accept states: q0 q2 "
    (cond 
        [(eq? initial-state 'q0) (cond
            [(eq? accept-states #\a) 'q3]
            [(eq? accept-states #\b) 'q1]
            [else 'inv])]
        [(eq? initial-state 'q1) (cond
            [(eq? accept-states #\a) 'inv]
            [(eq? accept-states #\b) 'q2]
            [else 'inv])]
        [(eq? initial-state 'q2) (cond
            [(eq? accept-states #\a) 'q3]
            [(eq? accept-states #\b) 'q1]
            [else 'inv])]
        [(eq? initial-state 'q3) (cond
            [(eq? accept-states #\a) 'q3]
            [(eq? accept-states #\b) 'q1]
            [else 'inv])]
        [else 'inv]))

; Ejecutar el DFA
(define (test-dfa string-to-evaluate)
  (evaluate-dfa (dfa transition-event-a-b 'q0 '(q0 q2)) string-to-evaluate))

(test-dfa "")
(test-dfa "aabbabbabbbb")
(test-dfa "aabababbba")