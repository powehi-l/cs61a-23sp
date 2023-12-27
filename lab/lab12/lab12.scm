(define (substitute s old new) 
  (if (null? s)
      nil
      (if (pair? (car s))
          (append (list (substitute (car s) old new)) (substitute (cdr s) old new))
          (if (equal? (car s) old)
              (append (list new) (substitute (cdr s) old new))
              (append (list (car s)) (substitute (cdr s) old new))))))

; Feel free to use these helper procedures in your solution
(define (map fn s)
  (if (null? s)
      nil
      (cons (fn (car s)) (map fn (cdr s)))))

(define (filter fn s)
  (cond 
    ((null? s)    nil)
    ((fn (car s)) (cons (car s) (filter fn (cdr s))))
    (else         (filter fn (cdr s)))))

(define (count x s) 
  (if (null? s)
    0
    (if (equal? x (car s))
      (+ 1 (count x (cdr s)))
      (count x (cdr s)))))

(define (unique s) 
  (if (null? s)
    ()
    (append (list (car s)) (unique (filter (lambda (x)  (not (equal? x (car s)))) (cdr s))))))

(define (tally names)
  (if (null? names)
    ()
    (let ((finame (car names)))
     (append (list (list finame (count finame names))) (tally (filter (lambda (x) (not (equal? x finame))) names))))))