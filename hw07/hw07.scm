(define (cadr lst) (car (cdr lst)))

(define (make-kwlist1 keys values)
  ;'YOUR-CODE-HERE
  (cons keys (list values))
)

(define (get-keys-kwlist1 kwlist)
  ;'YOUR-CODE-HERE
  (car kwlist)
)

(define (get-values-kwlist1 kwlist)
  ;'YOUR-CODE-HERE
  (cadr kwlist)
)

(define (make-kwlist2 keys values)
  ;'YOUR-CODE-HERE
  (if (null? keys) nil
    (cons (cons (car keys) (list (car values)))(make-kwlist2 (cdr keys) (cdr values)))
  )
)

(define (get-keys-kwlist2 kwlist)
  ;'YOUR-CODE-HERE
  (if (null? kwlist) nil
    (cons (car (car kwlist))(get-keys-kwlist2 (cdr kwlist)))
  )
)

(define (get-values-kwlist2 kwlist)
  ;'YOUR-CODE-HERE
  (if (null? kwlist) nil
    (cons (car (cdr (car kwlist)))(get-values-kwlist2 (cdr kwlist)))
  )
)

(define (add-to-kwlist kwlist key value)
  ;'YOUR-CODE-HERE
  (define keys (append (get-keys-kwlist kwlist) (list key)))
  (define values (append (get-values-kwlist kwlist) (list value)))
  (make-kwlist keys values)
)

(define (get-first-from-kwlist kwlist key)
  ;'YOUR-CODE-HERE
  (cond
    ((null? (car kwlist)) nil)
    ((eq? (car (car kwlist)) key)
      ; (begin
        ; (print (car (cadr kwlist)))
        (car (cadr kwlist))
      ; )
    )
    (else
      ; (begin
        (get-first-from-kwlist (make-kwlist (cdr (get-keys-kwlist kwlist)) (cdr (get-values-kwlist kwlist))) key)
        ; (print (make-kwlist (cdr (get-keys-kwlist kwlist)) (cdr (get-values-kwlist kwlist))))
      ; )
    )
  )
)
