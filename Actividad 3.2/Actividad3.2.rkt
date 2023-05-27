; Sebastian Moncada - A01027028
; Samuel Acevedo - A01026893
; Programando un DFA reconocedor de tokens en un lenguaje de programación 
; 23 04 2023

#lang racket

(provide (all-defined-out)) ; Provee todas las funciones
(require racket/trace) ; Es necesario para poder usar el 'trace'

; Declare the structure that describes a DFA
(struct dfa (func initial accept))

(define (char-operator? char)
  (member char '(#\+ #\- #\* #\/ #\= #\^)))

(define (evaluate-dfa dfa-to-evaluate string-to-evaluate)
  (let loop

    ([chars (string->list string-to-evaluate)] ; Convert the string into a list of characters
    [state (dfa-initial dfa-to-evaluate)] ; Get the initial state of the dfa
    [tokens '()] ; The return list with all the tokens found
    [temp-values '()] ; The return list wiht all the values of the tokens found
    )

    (cond 
      ; When the list of chars is over, check if the final state is acceptable
      [(empty? chars)
        (if (member state (dfa-accept dfa-to-evaluate))
          (if (empty? temp-values)
            (reverse tokens)
            (reverse (cons (list (list->string (reverse temp-values)) state) tokens))
          )
          #f)]
      [else 
        (let-values 
          ([ (new-state token-found save-value) ((dfa-func dfa-to-evaluate) state (car chars)) ]) ; Call the transition function and fet the new state and whether or not a token was found
          (loop 
            (cdr chars)
            new-state
            (if token-found ; The new list of tokens
              (cons (list (list->string (reverse temp-values)) token-found) tokens)
              tokens)
            (if save-value
              (if token-found
                (list (car chars))
                (cons (car chars) temp-values)
              )
              '()
            )
            ))])))

; DFA
(define (delta-arithmetic initial-state accept-states)
    " Transition function to validate the argument is a number
      Initial state: start
      Accept states: int float exp var space par_close"
    (cond 
        ; All the possible states of the DFA
        [(eq? initial-state 'start) (cond
            [(or (eq? accept-states #\+) (eq? accept-states #\-)) (values 'sign #f #t)]
            [(char-numeric? accept-states) (values 'int #f #t)]
            [(or (char-alphabetic? accept-states) (eq? accept-states #\_)) (values 'var #f #t)]
            [(eq? accept-states #\() (values 'par_open #f #t)]
            [(char=? accept-states #\space) (values 'space #f #f)]
            [else (values 'inv #f #f)])]

        [(eq? initial-state 'sign) (cond
            [(char-numeric? accept-states) (values 'int #f #t)]
            [(eq? accept-states #\() (values 'par_open #f #t)]
            [else (values 'inv #f #f)])]

        [(eq? initial-state 'int) (cond
            [(char-numeric? accept-states) (values 'int #f #t)]
            [(eq? accept-states #\.) (values 'dot #f #t)]
            [(or (eq? accept-states #\e) (eq? accept-states #\E)) (values 'e #f #t)]
            [(char-operator? accept-states) (values 'op 'int #t)]
            [(eq? accept-states #\)) (values 'par_close 'int #t)]
            [(char=? accept-states #\space) (values 'space 'int #f)]
            [else (values 'inv #f #f)])]

        [(eq? initial-state 'dot) (cond
            [(char-numeric? accept-states) (values 'float #f #t)]
            [else (values 'inv #f #f)])]

        [(eq? initial-state 'float) (cond
            [(char-numeric? accept-states) (values 'float #f #t)]
            [(or (eq? accept-states #\e) (eq? accept-states #\E)) (values 'e #f #t)]
            [(char-operator? accept-states) (values 'op 'float #t)]
            [(eq? accept-states #\)) (values 'par_close 'float #t)]
            [(char=? accept-states #\space) (values 'space 'float #f)]
            [else (values 'inv #f #f)])]

        [(eq? initial-state 'e) (cond
            [(char-numeric? accept-states) (values 'exp #f #t)]
            [(or (eq? accept-states #\+) (eq? accept-states #\-)) (values 'e_sign #f #t)]
            [else (values 'inv #f #f)])]

        [(eq? initial-state 'e_sign) (cond
            [(char-numeric? accept-states) (values 'exp #f #t)]
            [else (values 'inv #f #f)])]

        [(eq? initial-state 'exp) (cond
            [(char-numeric? accept-states) (values 'exp #f #t)]
            [(char-operator? accept-states) (values 'op 'exp #t)]
            [(eq? accept-states #\)) (values 'par_close 'exp #t)]
            [(char=? accept-states #\space) (values 'space 'exp #f)]
            [else (values 'inv #f #f)])]

        [(eq? initial-state 'var) (cond
            [(char-alphabetic? accept-states) (values 'var #f #t)]
            [(char-numeric? accept-states) (values 'var #f #t)]
            [(eq? accept-states #\_) (values 'var #f #t)]
            [(char-operator? accept-states) (values 'op 'var #t)]
            [(eq? accept-states #\)) (values 'par_close 'var #t)]
            [(char=? accept-states #\space) (values 'space 'var #f)]
            [else (values 'inv #f #f)])]

        [(eq? initial-state 'op) (cond
            [(char-numeric? accept-states) (values 'int 'op #t)]
            [(or (eq? accept-states #\+) (eq? accept-states #\-)) (values 'sign 'op #t)]
            [(char-alphabetic? accept-states) (values 'var 'op #t)]
            [(eq? accept-states #\_) (values 'var 'op #t)]
            [(eq? accept-states #\() (values 'par_open 'op #t)]
            [(char=? accept-states #\space) (values 'space_op 'op #f)]
            [else (values 'inv #f #f)])]

        [(eq? initial-state 'space) (cond
            [(char-numeric? accept-states) (values 'int #f #t)]
            [(char-alphabetic? accept-states) (values 'var #f #t)]
            [(char-operator? accept-states) (values 'op #f #t)]
            [(eq? accept-states #\() (values 'par_open #f #t)]
            [(eq? accept-states #\)) (values 'par_close #f #t)]
            [(char=? accept-states #\space) (values 'space #f #f)]
            [else (values 'inv #f #f)])]
            
        [(eq? initial-state 'space_op) (cond
            [(char-numeric? accept-states) (values 'int #f #t)]
            [(or (eq? accept-states #\+) (eq? accept-states #\-)) (values 'sign #f #t)]
            [(char-alphabetic? accept-states) (values 'var #f #t)]
            [(eq? accept-states #\_) (values 'var #f #t)]
            [(eq? accept-states #\() (values 'par_open #f #t)]
            [(eq? accept-states #\space) (values 'space_op #f #f)]
            [else (values 'inv #f #f)])]

        [(eq? initial-state 'par_open) (cond
            [(eq? accept-states #\() (values 'par_open 'par_open #t)]
            [(or (eq? accept-states #\+) (eq? accept-states #\-)) (values 'sign 'par_open #t)]
            [(char-numeric? accept-states) (values 'int 'par_open #t)]
            [(char-alphabetic? accept-states) (values 'var 'par_open #t)]
            [(eq? accept-states #\_) (values 'var 'par_open #t)]
            [(eq? accept-states #\)) (values 'par_close 'par_open #t)]
            [(char=? accept-states #\space) (values 'space 'par_open #f)]
            [else (values 'inv #f #f)])]

        [(eq? initial-state 'par_close) (cond
            [(eq? accept-states #\)) (values 'par_close 'par_close #t)]
            [(char-numeric? accept-states) (values 'int 'par_close #t)]
            [(char-alphabetic? accept-states) (values 'var 'par_close #t)]
            [(eq? accept-states #\_) (values 'var 'par_close #t)]
            [(char-operator? accept-states) (values 'op 'par_close #t)]
            [(char=? accept-states #\space) (values 'space 'par_close #f)]
            [else (values 'inv #f #f)])]

        [else (values 'inv #f #f)]))

(define (arithmetic-lexer string-to-evaluate)
    (evaluate-dfa (dfa delta-arithmetic 'start '(int float exp var space par_close)) string-to-evaluate))



#|
    Programming a DFA
    Using recursion and Finite State Automata

    Gilberto Echeverria
    2021-03-24
|#

; Import library for unit testing
(require rackunit)
; Import necesary to view the test results
(require rackunit/text-ui)

(define test-arithmetic-lexer
    (test-suite
        " Test function: arithmetic-lexer"
        ; Numerical types
        (check-equal? (arithmetic-lexer "2") '(("2" int)) "Single digit")
        (check-equal? (arithmetic-lexer "261") '(("261" int)) "Multi digit int")
        (check-equal? (arithmetic-lexer "-63") '(("-63" int)) "Negative int")
        (check-equal? (arithmetic-lexer "5.23") '(("5.23" float)) "Single float")
        (check-equal? (arithmetic-lexer "-5.23") '(("-5.23" float)) "Negative float")
        (check-equal? (arithmetic-lexer ".23") #f "Incorrect float")
        (check-equal? (arithmetic-lexer "2.2.3") #f "Incorrect float")
        (check-equal? (arithmetic-lexer "4e8") '(("4e8" exp)) "Exponent int")
        (check-equal? (arithmetic-lexer "4.51e8") '(("4.51e8" exp)) "Exponent float")
        (check-equal? (arithmetic-lexer "-4.51e8") '(("-4.51e8" exp)) "Negative exponent float")

        ; Variables
        (check-equal? (arithmetic-lexer "data") '(("data" var)) "Single variable")
        (check-equal? (arithmetic-lexer "data34") '(("data34" var)) "Single variable")
        (check-equal? (arithmetic-lexer "34data") #f "Incorrect variable")

        (check-equal? (arithmetic-lexer "2+1") '(("2" int) ("+" op) ("1" int)) "Binary operation ints")
        (check-equal? (arithmetic-lexer "/1") #f "Invalid expression")
        (check-equal? (arithmetic-lexer "6 + 4 *+ 1") #f "Invalid expression")
        (check-equal? (arithmetic-lexer "5.2+3") '(("5.2" float) ("+" op) ("3" int)) "Float and int")
        (check-equal? (arithmetic-lexer "5.2+3.7") '(("5.2" float) ("+" op) ("3.7" float)) "Binary operation floats")

        ; Operations with variables
        (check-equal? (arithmetic-lexer "one+two") '(("one" var) ("+" op) ("two" var)) "Binary operation variables")
        (check-equal? (arithmetic-lexer "one+two/45.2") '(("one" var) ("+" op) ("two" var) ("/" op) ("45.2" float)) "Mixed variables numbers")

        ; Spaces between operators
        (check-equal? (arithmetic-lexer "2 + 1") '(("2" int) ("+" op) ("1" int)) "Binary operation with spaces")
        (check-equal? (arithmetic-lexer "6 = 2 + 1") '(("6" int) ("=" op) ("2" int) ("+" op) ("1" int)) "Multiple operators with spaces")
        (check-equal? (arithmetic-lexer "one + two / 45.2") '(("one" var) ("+" op) ("two" var) ("/" op) ("45.2" float)) "Mixed variables numbers spaces")
        (check-equal? (arithmetic-lexer "97 /6 = 2 + 1") '(("97" int) ("/" op) ("6" int) ("=" op) ("2" int) ("+" op) ("1" int)) "Multiple operators")
        (check-equal? (arithmetic-lexer "7.4 ^3 = 2.0 * 1") '(("7.4" float) ("^" op) ("3" int) ("=" op) ("2.0" float) ("*" op) ("1" int)) "Multiple float operators with spaces")

        ; Parentheses
        (check-equal? (arithmetic-lexer "()") '(("(" par_open) (")" par_close)) "Open and close")
        (check-equal? (arithmetic-lexer "( )") '(("(" par_open) (")" par_close)) "Open space close")
        (check-equal? (arithmetic-lexer "(45)") '(("(" par_open) ("45" int) (")" par_close)) "Open int close")
        (check-equal? (arithmetic-lexer "( 45 )") '(("(" par_open) ("45" int) (")" par_close)) "Open space int space close")
        (check-equal? (arithmetic-lexer "(4 + 5)") '(("(" par_open) ("4" int) ("+" op) ("5" int) (")" par_close)) "Open expression close")
        (check-equal? (arithmetic-lexer "(4 + 5) * (6 - 3)") '(("(" par_open) ("4" int) ("+" op) ("5" int) (")" par_close) ("*" op) ("(" par_open) ("6" int) ("-" op) ("3" int) (")" par_close)) "Open expression close")

        ; Comments
        ; (check-equal? (arithmetic-lexer "3// this is all") '(("3" int) ("// this is all" comment)) "Variable and comment")
        ; (check-equal? (arithmetic-lexer "3+5 // this is all") '(("3" int) ("+" op) ("5" int) ("// this is all" comment)) "Expression and comment")
        ; (check-equal? (arithmetic-lexer "area = 3.1415 * raduis ^2 // area of a circle") '(("area" var) ("=" op) ("3.1415" float) ("*" op) ("raduis" var) ("^" op) ("2" int) ("// area of a circle" comment)) "Complete expression 1")
        ; (check-equal? (arithmetic-lexer "result = -34.6e10 * previous / 2.0 // made up formula") '(("result" var) ("=" op) ("-34.6e10" exp) ("*" op) ("previous" var) ("/" op) ("2.0" float) ("// made up formula" comment)) "Complete expression 2")
        ; (check-equal? (arithmetic-lexer "cel = (far - 32) * 5 / 9.0 // temperature conversion") '(("cel" var) ("=" op) ("(" par_open) ("far" var) ("-" op) ("32" int) (")" par_close) ("*" op) ("5" int) ("/" op) ("9.0" float) ("// temperature conversion" comment)) "Complete expression 3")

        ; Extreme cases of spaces before or after the expression
        (check-equal? (arithmetic-lexer "  2 + 1") '(("2" int) ("+" op) ("1" int)) "Spaces before")
        (check-equal? (arithmetic-lexer "  2 + 1 ") '(("2" int) ("+" op) ("1" int)) "Spaces before and after")
    ))

; Start the execution of the test suite
(displayln "Testing: arithmetic-lexer")
(run-tests test-arithmetic-lexer)
