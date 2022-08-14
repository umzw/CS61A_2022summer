(define (cddr s) (cdr (cdr s)))

(define (cadr s)
    ; 'YOUR-CODE-HERE return 2nd element
    (car (cdr s))
)

(define (caddr s)
    ; 'YOUR-CODE-HERE return 3rd element
    (car (cdr (cdr s)))
)

(define (interleave lst1 lst2)
    ; 'YOUR-CODE-HERE
    (cond
        ((null? lst1) lst2)
        ((null? lst2) lst1)
        (else
            (cons (car lst1) (cons (car lst2) (interleave (cdr lst1) (cdr lst2)))))
    )
)

(define (my-filter pred lst)
    ; 'YOUR-CODE-HERE
    (cond
        ((null? lst) nil)
        ((pred (car lst)) (cons (car lst) (my-filter pred (cdr lst))))
        (else (my-filter pred (cdr lst)))
    )
)

(define (concatenate s)
    ; 'YOUR-CODE-HERE
    (define (helper lst1 lst2)
        (if (null? lst2)
            lst1
            (helper (append lst1 (car lst2)) (cdr lst2))
        )
    )
    (helper (car s) (cdr s))
)
