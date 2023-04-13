#lang racket

(provide (all-defined-out)) ; Provee todas las funciones
(require racket/trace) ; Es necesario para poder usar el 'trace'

; Declare the structure that describes a DFA
(struct dfa (func initial accept))

; (define (evaluate-dfa dfa-to-evaluate string-to-evaluate)
;     (let loop
;         ; Convert the string into a list of characters
;         ([chars (string->list string-to-evaluate)]
;         ; Get the initial state of the dfa
;          [state (dfa-initial dfa-to-evaluate)])

;         (cond 
;             ; When the list of chars is over, check if the final state is acceptable
;             [(empty? chars) (member state (dfa-accept dfa-to-evaluate))]
;             ; Apply the transition function to get the next state
;             [else (loop 
;                 (cdr chars)
;                 ((dfa-func dfa-to-evaluate) state (car chars)))])))



(define (transition-event-a-b initial-state accept-states)
    " Transition function
      Initial state: q0
      Accept states: q1 "
    (cond 
        [(eq? initial-state 'q0) (cond
            [(eq? accept-states #\a) 'q2]
            [(eq? accept-states #\b) 'q1]
            [else 'inv])]
        [(eq? initial-state 'q1) (cond
            [(eq? accept-states #\a) 'q1]
            [(eq? accept-states #\b) 'q1]
            [else 'inv])]
        [(eq? initial-state 'q2) (cond
            [(eq? accept-states #\a) 'q3]
            [(eq? accept-states #\b) 'inv]
            [else 'inv])]
        [(eq? initial-state 'q3) (cond
            [(eq? accept-states #\a) 'q2]
            [(eq? accept-states #\b) 'q1]
            [else 'inv])]
        [else 'inv]))

; El autómata de este ejercicio es el de la imagen deltaAutomata
(define (delta-event-a-b initial-state accept-states)
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

; El autómata de este ejercicio es el de la imagen deltaAutomata
(define (validate-number-event initial-state accept-states)
    " Transition function to validate the argument is a number
      Initial state: start
      Accept states: int float exp "
    (cond
        ['start (cond
            [(or (eq? accept-states #\+) (eq? accept-states #\-)) 'sign]
            [(char-numeric? accept-states) 'int]
            [else 'inv])]
        ['sign (cond
            [(char-numeric? accept-states) 'int]
            [else 'inv])]
        ['int (cond
            [(eq? accept-states #\.) 'dot]
            [(char-numeric? accept-states) 'int]
            [(or (eq? accept-states #\e) (eq? accept-states #\E)) 'e]
            [else 'inv])]
        ['dot (cond
            [(char-numeric? accept-states) 'float]
            [else 'inv])]
        ['float (cond
            [(char-numeric? accept-states) 'float]
            [(or (eq? accept-states #\e) (eq? accept-states #\E)) 'e]
            [else 'inv])]
        ['e (cond
            [(char-numeric? accept-states) 'exp]
            [(or (eq? accept-states #\+) (eq? accept-states #\-)) 'e_sign]
            [else 'inv])]
        ['exp (cond
            [(char-numeric? accept-states) 'exp]
            [else 'inv])]
        ['e_sign (cond
            [(char-numeric? accept-states) 'exp]
            [else 'inv])]
        [else 'inv]))

(define (validate-number string-to-evaluate)
    (evaluate-dfa (dfa validate-number-event 'start '(int float exp)) string-to-evaluate))


#| No me acuerdo para qué era esto
(struct dfa (func initial accept))
(define data (dfa transition-event-a-b 'q0 '(q1)))
data

(dfa-initial data)
|#
 
; Para probar todo esto
; (evaluate-dfa (dfa transition-event-a-b 'q0 '(q1)) "aabababbba") 

(define (char-operator? char)
    (member char '(#\+ #\- #\* #\/ #\= #\^)))

(define (evaluate-dfa dfa-to-evaluate string-to-evaluate)
    (let loop

        ([chars (string->list string-to-evaluate)] ; Convert the string into a list of characters
         [state (dfa-initial dfa-to-evaluate)] ; Get the initial state of the dfa
         [tokens '()]) ; The return list with all the tokens found

        (cond 
            ; When the list of chars is over, check if the final state is acceptable
            [(empty? chars)
                (if (member state (dfa-accept dfa-to-evaluate))
                    (reverse (cons state tokens))
                    'invalid)]
            [else 
                (let-values 
                    ([(new-state found) ((dfa-func dfa-to-evaluate) state (car chars))]) ; Call the transition function and fet the new state and whether or not a token was found
                    (loop 
                        (cdr chars)
                        new-state
                        (if found (cons found tokens) tokens)))]))) ; The new list of tokens

; delta-arithmetic 
(define (delta-arithmetic initial-state accept-states)
    " Transition function to validate the argument is a number
      Initial state: start
      Accept states: int float exp var space"
    (cond 
        [(eq? initial-state 'start) (cond
            [(or (eq? accept-states #\+) (eq? accept-states #\-)) (values 'sign #f)]
            [(char-numeric? accept-states) (values 'int #f)]
            [(or (char-alphabetic? accept-states) (eq? accept-states #\_)) (values 'var #f)]
            [else (values 'inv #f)])]
        [(eq? initial-state 'sign) (cond
            [(char-numeric? accept-states) (values 'int #f)]
            [else (values 'inv #f)])]
        [(eq? initial-state 'int) (cond
            [(char-numeric? accept-states) (values 'int #f)]
            [(eq? accept-states #\.) (values 'dot #f)]
            [(or (eq? accept-states #\e) (eq? accept-states #\E)) (values 'e #f)]
            [(char-operator? accept-states) (values 'op 'int)]
            [(char=? accept-states #\space) (values 'space 'int)]
            [else (values 'inv #f)])]
        [(eq? initial-state 'dot) (cond
            [(char-numeric? accept-states) (values 'float #f)]
            [else (values 'inv #f)])]
        [(eq? initial-state 'float) (cond
            [(char-numeric? accept-states) (values 'float #f)]
            [(or (eq? accept-states #\e) (eq? accept-states #\E)) (values 'e #f)]
            [(char=? accept-states #\space) (values 'space 'float)]
            [(char-operator? accept-states) (values 'op 'float)]
            [else (values 'inv #f)])]
        [(eq? initial-state 'e) (cond
            [(char-numeric? accept-states) (values 'exp #f)]
            [(or (eq? accept-states #\+) (eq? accept-states #\-)) (values 'e_sign #f)]
            [else (values 'inv #f)])]
        [(eq? initial-state 'e_sign) (cond
            [(char-numeric? accept-states) (values 'exp #f)]
            [else (values 'inv #f)])]
        [(eq? initial-state 'exp) (cond
            [(char-numeric? accept-states) (values 'exp #f)]
            [(char-operator? accept-states) (values 'op 'exp)]
            [(char=? accept-states #\space) (values 'space 'exp)]
            [else (values 'inv #f)])]
        [(eq? initial-state 'var) (cond
            [(char-alphabetic? accept-states) (values 'var #f)]
            [(char-numeric? accept-states) (values 'var #f)]
            [(eq? accept-states #\_) (values 'var #f)]
            [(char-operator? accept-states) (values 'op 'var)]
            [(char=? accept-states #\space) (values 'space 'var)]
            [else (values 'inv #f)])]
        [(eq? initial-state 'op) (cond
            [(char-numeric? accept-states) (values 'int 'op)]
            [(or (eq? accept-states #\+) (eq? accept-states #\-)) (values 'sign 'op)]
            [(char-alphabetic? accept-states) (values 'var 'op)]
            [(eq? accept-states #\_) (values 'var 'op)]
            [(char=? accept-states #\space) (values 'op_space 'op)]
            [else (values 'inv #f)])]
        [(eq? initial-state 'space) (cond
            [(char-operator? accept-states) (values 'op #f)]
            [(char=? accept-states #\space) (values 'space #f)]
            [else (values 'inv #f)])]
        [(eq? initial-state 'op_space) (cond
            [(char-numeric? accept-states) (values 'int #f)]
            [(or (eq? accept-states #\+) (eq? accept-states #\-)) (values 'sign #f)]
            [(char-alphabetic? accept-states) (values 'var #f)]
            [(eq? accept-states #\_) (values 'var #f)]
            [(eq? accept-states #\space) (values 'op_space #f)]
            [else (values 'inv #f)])]
        [else (values 'inv #f)]))

; (define (validate-tokens string-to-evaluate)
;     (evaluate-dfa (dfa validate-tokens-event 'start '(int float exp var space)) string-to-evaluate))

(define (arithmetic-lexer string-to-evaluate)
    (evaluate-dfa (dfa delta-arithmetic 'start '(int float exp var space)) string-to-evaluate))