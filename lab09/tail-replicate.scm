(define (tail-replicate x n)
  ; BEGIN
  ; 'replace-this-line
  (define (helper x n result)
    (if (= n 0) result
      (helper x (- n 1) (cons x result))
    )
  )
  (helper x n nil)
  ; END
)