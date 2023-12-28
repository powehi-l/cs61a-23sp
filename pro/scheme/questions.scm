(define (caar x) (car (car x)))
(define (cadr x) (car (cdr x)))
(define (cdar x) (cdr (car x)))
(define (cddr x) (cdr (cdr x)))

;; Problem 15
;; Returns a list of two-element lists
(define (enumerate s)
  ; BEGIN PROBLEM 15
  (define enumerate_index (lambda (s x) 
    (if (null? s)
      ()
      (append (list (list x (car s))) (enumerate_index (cdr s) (+ 1 x))))))
  (enumerate_index s 0)
  )
  ; END PROBLEM 15

;; Problem 16

;; Merge two lists S1 and S2 according to ORDERED? and return
;; the merged lists.
(define (merge ordered? s1 s2)
  ; BEGIN PROBLEM 16
  (cond ((null? s1) s2)
    ((null? s2) s1)
    ((ordered? (car s1) (car s2)) (cons (car s1) (merge ordered? (cdr s1) s2)))
    (else (cons (car s2) (merge ordered? s1 (cdr s2)))))
  )
  ; END PROBLEM 16

;; Optional Problem

;; Returns a function that checks if an expression is the special form FORM
(define (check-special form)
  (lambda (expr) (equal? form (car expr))))

(define lambda? (check-special 'lambda))
(define define? (check-special 'define))
(define quoted? (check-special 'quote))
(define let?    (check-special 'let))

;; Converts all let special forms in EXPR into equivalent forms using lambda
(define (let-to-lambda expr)
  (cond ((atom? expr)
         ; BEGIN OPTIONAL PROBLEM
        ;  (print 'debug: expr)
         expr
         ; END OPTIONAL PROBLEM
         )
        ((quoted? expr)
         ; BEGIN OPTIONAL PROBLEM
         expr
         ; END OPTIONAL PROBLEM
         )
        ((or (lambda? expr)
             (define? expr))
         (let ((form   (car expr))
               (params (cadr expr))
               (body   (cddr expr)))
           ; BEGIN OPTIONAL PROBLEM
           (cons form (cons params (let-to-lambda body)))
           ; END OPTIONAL PROBLEM
           ))
        ((let? expr)
         (let ((values (cadr expr))
               (body   (cddr expr)))
           ; BEGIN OPTIONAL PROBLEM
           (cons (cons 'lambda (cons (map let-to-lambda (car (zip values))) (let-to-lambda body))) (map let-to-lambda (cadr (zip values))))
          ;  (cons (cons 'lambda (cons (car (zip values)) (let-to-lambda body))) (cadr (zip values)))
            ; (cons (list 'lambda (map car values) (let-to-lambda body)) (map cadr values))
           ; END OPTIONAL PROBLEM
           ))
        (else
         ; BEGIN OPTIONAL PROBLEM
         (print 'DEBUG: expr)
         (print 'debug: (pair? (car expr)))
        ;  expr
        ;  (if (and (not (null? (cdr expr))) (pair? (cadr expr)))
        ;   (list (let-to-lambda (car expr)) (let-to-lambda (cadr expr)))
        ;   expr)
          (map let-to-lambda expr)
          ; (if (or (pair? (car expr)) (and (not (null? (cdr expr))) (pair? (cadr expr))))
          ; (cons (let-to-lambda (car expr)) (let-to-lambda (cdr expr)))
          ; (cons (car expr) (let-to-lambda (cdr expr))))
          ; (if (pair? (car expr))
          ; (cons (let-to-lambda (car expr)) (let-to-lambda (cdr expr)))
          ; (cons (car expr) (let-to-lambda (cdr expr))))
          
         ; END OPTIONAL PROBLEM
         )))

; Some utility functions that you may find useful to implement for let-to-lambda

(define (zip pairs)
  (if (null? pairs)
    (cons nil (cons nil nil))
    (list (append (list (caar pairs)) (car (zip (cdr pairs)))) (append (cdar pairs) (cadr (zip (cdr pairs)))))))
    ; (cons (map car pairs) (map cdr pairs))))

; (define x (zip '((1 2) (3 4) (5 6))))
; (car x)
; (car (cdr x))
