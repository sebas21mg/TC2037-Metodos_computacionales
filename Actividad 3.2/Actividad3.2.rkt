; Sebastian Moncada - A01027028
; Samuel Acevedo - A01026893

#lang racket

(provide (all-defined-out)) ; Provee todas las funciones
(require racket/trace) ; Es necesario para poder usar el 'trace'

; Declare the structure that describes a DFA
(struct dfa (func initial accept))

(define (char-operator? char)
    (member char '(#\+ #\- #\* #\/ #\= #\^)))

(define (evaluate-dfa dfa-to-evaluate string-to-evaluate)
    (trace-let loop

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

; DFA reconocedor de tokens en un lenguaje de programación 
(define (delta-arithmetic initial-state accept-states)
    " Transition function to validate the argument is a number
      Initial state: start
      Accept states: int float exp var space par_close"
    (cond 
        ; All the possible states of the DFA
        [(eq? initial-state 'start) (cond
            [(or (eq? accept-states #\+) (eq? accept-states #\-)) (values 'sign #f)]
            [(char-numeric? accept-states) (values 'int #f)]
            [(or (char-alphabetic? accept-states) (eq? accept-states #\_)) (values 'var #f)]
            [(eq? accept-states #\() (values 'par_open #f)]
            [else (values 'inv #f)])]

        [(eq? initial-state 'sign) (cond
            [(char-numeric? accept-states) (values 'int #f)]
            [(eq? accept-states #\() (values 'par_open #f)]
            [else (values 'inv #f)])]

        [(eq? initial-state 'int) (cond
            [(char-numeric? accept-states) (values 'int #f)]
            [(eq? accept-states #\.) (values 'dot #f)]
            [(or (eq? accept-states #\e) (eq? accept-states #\E)) (values 'e #f)]
            [(char-operator? accept-states) (values 'op 'int)]
            [(char=? accept-states #\space) (values 'space 'int)]
            [(eq? accept-states #\)) (values 'par_close 'int)]
            [else (values 'inv #f)])]

        [(eq? initial-state 'dot) (cond
            [(char-numeric? accept-states) (values 'float #f)]
            [else (values 'inv #f)])]

        [(eq? initial-state 'float) (cond
            [(char-numeric? accept-states) (values 'float #f)]
            [(or (eq? accept-states #\e) (eq? accept-states #\E)) (values 'e #f)]
            [(char=? accept-states #\space) (values 'space 'float)]
            [(char-operator? accept-states) (values 'op 'float)]
            [(eq? accept-states #\)) (values 'par_close 'float)]
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
            [(eq? accept-states #\)) (values 'par_close 'exp)]
            [else (values 'inv #f)])]

        [(eq? initial-state 'var) (cond
            [(char-alphabetic? accept-states) (values 'var #f)]
            [(char-numeric? accept-states) (values 'var #f)]
            [(eq? accept-states #\_) (values 'var #f)]
            [(char-operator? accept-states) (values 'op 'var)]
            [(char=? accept-states #\space) (values 'space 'var)]
            [(eq? accept-states #\)) (values 'par_close 'var)]
            [else (values 'inv #f)])]

        [(eq? initial-state 'op) (cond
            [(char-numeric? accept-states) (values 'int 'op)]
            [(or (eq? accept-states #\+) (eq? accept-states #\-)) (values 'sign 'op)]
            [(char-alphabetic? accept-states) (values 'var 'op)]
            [(eq? accept-states #\_) (values 'var 'op)]
            [(char=? accept-states #\space) (values 'space_op 'op)]
            [(eq? accept-states #\() (values 'par_open 'op)]
            [else (values 'inv #f)])]

        [(eq? initial-state 'space) (cond
            [(char-operator? accept-states) (values 'op #f)]
            [(char=? accept-states #\space) (values 'space #f)]
            [(eq? accept-states #\() (values 'par_open #f)]
            [(eq? accept-states #\)) (values 'par_close #f)]
            [else (values 'inv #f)])]
            
        [(eq? initial-state 'space_op) (cond
            [(char-numeric? accept-states) (values 'int #f)]
            [(or (eq? accept-states #\+) (eq? accept-states #\-)) (values 'sign #f)]
            [(char-alphabetic? accept-states) (values 'var #f)]
            [(eq? accept-states #\_) (values 'var #f)]
            [(eq? accept-states #\space) (values 'space_op #f)]
            [(eq? accept-states #\() (values 'par_open #f)]
            [else (values 'inv #f)])]

        [(eq? initial-state 'par_open) (cond
            [(eq? accept-states #\() (values 'par_open 'par_open)]
            [(or (eq? accept-states #\+) (eq? accept-states #\-)) (values 'sign 'par_open)]
            [(char-numeric? accept-states) (values 'int 'par_open)]
            [(char-alphabetic? accept-states) (values 'var 'par_open)]
            [(eq? accept-states #\_) (values 'var 'par_open)]
            [(char=? accept-states #\space) (values 'space 'par_open)]
            [(eq? accept-states #\)) (values 'par_close 'par_open)]
            [else (values 'inv #f)])]

        [(eq? initial-state 'par_close) (cond
            [(eq? accept-states #\)) (values 'par_close 'par_close)]
            [(char-numeric? accept-states) (values 'int 'par_close)]
            [(char-alphabetic? accept-states) (values 'var 'par_close)]
            [(eq? accept-states #\_) (values 'var 'par_close)]
            [(char-operator? accept-states) (values 'op 'par_close)]
            [(char=? accept-states #\space) (values 'space 'par_close)]
            [else (values 'inv #f)])]

        [else (values 'inv #f)]))

(define (arithmetic-lexer string-to-evaluate)
    (evaluate-dfa (dfa delta-arithmetic 'start '(int float exp var space par_close)) string-to-evaluate))