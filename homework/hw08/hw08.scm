(define (reverse lst)
  (cond ((null? lst) '())
        (else 
          (append (reverse (cdr lst)) 
                  (list (car lst)))
          )
        )
)
(define (longest-increasing-subsequence lst)
  (cond ((null? lst) '())
        ((null? (cdr lst)) '(car lst))
        (else 
               (define first 
                 (cons (car lst)
                       (filter (lambda (n) (> n (car lst))) (cdr lst))
                       )
                 )
               (define rest (reverse (cdr lst)))
               (cond ((> (length first) (length rest)) first)
                     (else rest)
                     )
               )
          
        )
)

(define (cadr s) (car (cdr s)))
(define (caddr s) (cadr (cdr s)))


; derive returns the derivative of EXPR with respect to VAR
(define (derive expr var)
  (cond ((number? expr) 0)
        ((variable? expr) (if (same-variable? expr var) 1 0))
        ((sum? expr) (derive-sum expr var))
        ((product? expr) (derive-product expr var))
        ((exp? expr) (derive-exp expr var))
        (else 'Error)))

; Variables are represented as symbols
(define (variable? x) (symbol? x))
(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))

; Numbers are compared with =
(define (=number? expr num)
  (and (number? expr) (= expr num)))

; Sums are represented as lists that start with +.
(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2)) (+ a1 a2))
        (else (list '+ a1 a2))))
(define (sum? x)
  (and (list? x) (eq? (car x) '+)))
(define (addend s) (cadr s))
(define (augend s) (caddr s))

; Products are represented as lists that start with *.
(define (make-product m1 m2)
  (cond ((or (=number? m1 0) (=number? m2 0)) 0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        ((and (number? m1) (number? m2)) (* m1 m2))
        (else (list '* m1 m2))))
(define (product? x)
  (and (list? x) (eq? (car x) '*)))
(define (multiplier p) (cadr p))
(define (multiplicand p) (caddr p))

(define (derive-sum expr var)
  (define addend (cadr expr))
  (define augend (caddr expr))
  (make-sum
        (derive addend var) 
        (derive augend var))
)

(define (derive-product expr var)
  (make-sum
      (make-product (derive (multiplier expr) var) (multiplicand expr))
      (make-product (multiplier expr) (derive (multiplicand expr) var))
      )
)

; Exponentiations are represented as lists that start with ^.
(define (make-exp base exponent)
  (cond ((=number? exponent 0) 1)
        ((=number? exponent 1) base)
        ((and (number? base) (number? exponent)) (expt base exponent))
        (else (list '^ base exponent)))
)

(define (base exp)
  (cadr exp)
)

(define (exponent exp)
  (caddr exp)
)

(define (exp? exp)
  (and (list? exp) (eq? (car exp) '^))
)


(define x^2 (make-exp 'x 2))
(define x^3 (make-exp 'x 3))

(define (derive-exp exp var)
  (make-product
    (exponent exp)
    (make-exp (base exp) (- (exponent exp) 1))
    )
)
