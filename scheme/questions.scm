(define (caar x) (car (car x)))
(define (cadr x) (car (cdr x)))
(define (cdar x) (cdr (car x)))
(define (cddr x) (cdr (cdr x)))

;; Problem 15
;; Returns a list of two-element lists
(define (enumerate s)
  ; BEGIN PROBLEM 15
  ; 'replace-this-line
  (define (helper s num)
    (if (null? s)
      nil
      (cons (list num (car s)) (helper (cdr s) (+ num 1)))
    )
  )
  (helper s 0)
)
  ; END PROBLEM 15

;; Problem 16

;; Merge two lists LIST1 and LIST2 according to ORDERED? and return
;; the merged lists.
(define (merge ordered? list1 list2)
  ; BEGIN PROBLEM 16
  ; 'replace-this-line

  (define (helper ordered? l1 l2 curr)
    (cond
      ((null? l1) (begin (append curr l2) (print (append curr l2))))
      ((null? l2) (begin (append curr l1) (print (append curr l1))))
      ((ordered? (car l1) (car l2))
              ; (begin
                (helper ordered? (cdr l1) l2 (append curr (list (car l1))))
                ; (print curr)
              ; )
      )
      (else
        ; (begin
          (helper ordered? l1 (cdr l2) (append curr (list (car l2))))
        ;   (print curr)
        ; )

      )
    )
  )
  (helper ordered? list1 list2 nil)
)
  ; END PROBLEM 16










