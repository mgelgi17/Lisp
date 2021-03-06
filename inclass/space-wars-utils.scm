(define nil '())

(define (delq item lst)
  (cond ((null? lst)
         '())
        ((eq? item (car lst))
         (cdr lst))
        (else
         (cons (car lst) 
               (delq item (cdr lst))))))

(define (make-vect x y) (list x y))

(define (vect-x vec) (car vec))

(define (vect-y vec) (cadr vec))

(define (add-vect u v)
  (make-vect (+ (vect-x u) (vect-x v))
             (+ (vect-y u) (vect-y v))))

(define (square x) (* x x))

(define (find-distance a b)
  (sqrt (+ (square (- (vect-x a) (vect-x b)))
	   (square (- (vect-y a) (vect-y b))))))


