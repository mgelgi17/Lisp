(load "error.scm")
(load "space-wars-utils.scm")

(define (make-ship position velocity num-torps)
  (define (move) 
    (set! position (add-vect position velocity))
    'done)
  (define (fire-torp)
    (cond ((> num-torps 0) ...)
	  (else 'out-of-torpedoes!)))
  (lambda (msg)
    (cond ((eq? msg 'position) position)
	  ((eq? msg 'velocity) velocity)
	  ((eq? msg 'move) (move))
	  ((eq? msg 'attack) (fire-torp))
	  (else (error "ship can't" msg)))))


(define (make-station position)
  (lambda (msg)
    (cond ((eq? msg 'station?) #T)
          ((eq? msg 'position) position)
	  ((eq? msg 'display)
	   (newline)
	   (display "station at ")
	   (display position))
	  (else (error "station can't " msg)))))

;; universe
(define *universe* nil)

(define (add-to-universe thing)
  (set! *universe* (cons thing *universe*)))

(define (remove-from-universe thing)
  (set! *universe* (delq thing *universe*)))

(define (clock)
  (for-each (lambda (x) (x 'clock-tick)) *universe*)
  (for-each (lambda (x) (x 'display)) *universe*)
  (let ((collisions (find-collisions *universe*)))
    (for-each (lambda (x) (x 'explode x))
	      collisions)))

(define (run-clock n)
  (cond ((= n 0) 'done)
	(else (clock)
	      (run-clock (- n 1)))))

(define (find-collisions lst)
  (display "find all the collisions in the universe lst")
  ;;
  )

(define (make-torpedo position velocity)
  (display "maker for torpedos")
  ;;
  )

(define (make-planet position)
  (lambda (msg)
    (cond ((eq? msg 'PLANET?) #t)
          ((eq? msg 'POSITION) position)
          ((eq? msg 'DISPLAY) (draw ...))
          (else (error "planet can't" msg)))))

;; Run a simulation
(define earth (make-planet (make-vect 0 0)))
(define enterprise
  (make-ship (make-vect 10 10) (make-vect 5 0) 3))
(define war-bird
  (make-ship (make-vect -10 10) (make-vect 10 0) 10))
;; Build some things


;; Add to universe


;; Start simulation
(run-clock 100)