; Owner and Vehicle Abstraction
(define (make-owner name age)
  (cons name (cons age nil)))

(define (get-name owner) (car owner))

(define (get-age owner) (car (cdr owner)))

(define (make-vehicle model year previous-owners)
  (cons model (cons year previous-owners)))

(define (get-model vehicle)
  ; 'YOUR-CODE-HERE
  (car vehicle)
)

(define (get-year vehicle)
  ; 'YOUR-CODE-HERE
  (car (cdr vehicle))
)

(define (get-owners vehicle)
  ; 'YOUR-CODE-HERE
  (cdr (cdr vehicle))
)

(define (older-vehicle vehicle1 vehicle2)
  ;'YOUR-CODE-HERE
  (if (< (get-year vehicle1) (get-year vehicle2))
    (get-model vehicle1)
    (get-model vehicle2)
  )
)

(define (new-owner vehicle owner)
  ;'YOUR-CODE-HERE
  (define model (get-model vehicle))
  (define year  (get-year vehicle))
  (define owners (cons owner (get-owners vehicle)))
  (make-vehicle model year owners)
)

(define (owners-names vehicle)
  ;'YOUR-CODE-HERE
  (define owners (get-owners vehicle))
  (map (lambda (x) (get-name x)) owners)
)






(define (split-at lst n)
  ;'YOUR-CODE-HERE
  ; (define (helper n rslt)
  ;   (if (= n 1) (rslt)
  ;     ; (begin
  ;       ; (print (cons (append (car rslt) (list (car (cdr rslt)))) (cdr (cdr rslt))))
  ;       (helper (- n 1) (cons (append (car rslt) (list (car (cdr rslt)))) (cdr (cdr rslt))))
  ;     ; )
  ;   )
  ; )
  ; (helper n (cons (list (car lst)) (cdr lst)))
  (cond
    ((null? lst) (cons lst nil))
    ((= n 0) (cons nil lst))
    (else
      ; (let ((bf (split-at (cdr lst) (- n 1)))))
      (cons (cons (car lst) (car (split-at (cdr lst) (- n 1)))) (cdr (split-at (cdr lst) (- n 1))))
    )
  )
)

; Tree Abstraction
; Constructs tree given label and list of branches
(define (tree label branches)
  (cons label branches))

; Returns the label of the tree
(define (label t) (car t))

; Returns the list of branches of the given tree
(define (branches t) (cdr t))

; Returns #t if t is a leaf, #f otherwise
(define (is-leaf t) (null? (branches t)))

(define (filter-odd t)
  ;'YOUR-CODE-HERE
  (cond
    ((is-leaf t) (if (even? (label t)) nil (label t)))
    ((even? (label t)) (tree nil (branches t)))
    (else
      (tree (label t)(map filter-odd (branches t)))
    )
  )
)
