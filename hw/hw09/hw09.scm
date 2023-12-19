(define (ascending? asc-lst) (if (or (null? asc-lst) (null? (cdr asc-lst))) 
    #t
    (if (> (car asc-lst) (car (cdr asc-lst))) 
        #f
        (ascending? (cdr asc-lst)))))

(define (my-filter pred s) (if (null? s)
    ()
    (if (pred (car s))
        (append (list (car s)) (my-filter pred (cdr s)))
        (append (my-filter pred (cdr s))))))

(define (interleave lst1 lst2) (cond
    ((null? lst1) lst2)
    ((null? lst2) lst1)
    (else (append (list(car lst1)) (interleave lst2 (cdr lst1))))))

(define (no-repeats lst) 
    (define (no_repeats_help lst exist_lst) 
        (if (null? lst)
            exist_lst
            (if (not (null? (my-filter (lambda (s) (= s (car lst))) exist_lst)))
                (no_repeats_help (cdr lst) exist_lst)
                (no_repeats_help (cdr lst) (append exist_lst (list (car lst))))
            )
        )
    )
    (no_repeats_help lst '())
)
