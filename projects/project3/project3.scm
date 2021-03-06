;;; YOUR NAME: Metehan Gelgi 64178
;;;
;;; Comp200 Project 3
;;;
;;; Before you start:
;;;
;;; * Please read the detailed instructions for this project from the
;;; file project3.pdf available in the Projects section of the
;;; course website.
;;;
;;; * Please read the project submission instructions carefully and make
;;; sure you understand everything before you start working on your
;;; project in order to avoid problems.
;;;
;;; While you are working:
;;; * Type all your work and notes in the appropriate sections of this file.
;;; * Please do not delete any of the existing lines.
;;; * Use the procedure names given in the instructions.
;;; * Remember to frequently save your file.
;;; * Use semicolon (;) to comment out text, tests and unused code.
;;; * Remember to document your code.
;;; * Remember our collaboration policy: you can discuss with your friends but:
;;;
;;;   *** NOTHING WRITTEN GETS EXCHANGED ***
;;;
;;; When you are done:

;;; * Perform a final save and copy the file to the following location
;;;   DriveF@VOL\UGRADS\COMP200\HOMEWORK\username\project3.zip
;;;   where the username is your login name.
;;; * Please do not make any modifications after midnight on the due date.
;;; * Please send an email comp200-group@ku.edu.tr if you have any questions.
;;; * Make sure your file loads without errors:
;;;
;;;
;;; Before the definition of each procedure, please write a description
;;; about what the procedure does and what its input and output should
;;; be, making sure the lines are commented out with semi-colons.
(define your-answer-here -1)
(load "databases.scm")
;_BANNER_
;;; problem 1 ;;;

;; your code should have the following general form

(define example-table
  (let ((my-table (make-empty-table
 	       (list (make-column 'name 'symbol)
 		     (make-column 'major 'number)))))
    (table-insert! (list 'ben 6) my-table)
    (table-insert! (list 'jen 3) my-table)
    (table-insert! (list 'amy 12) my-table)
    (table-insert! (list 'kim 13) my-table)
    (table-insert! (list 'alex 6) my-table)))    

(table-display example-table)

;; test cases
;; (table-display example-table)

;_BANNER_
;;; problem 2 ;;;
(define (table-insert-all! lst table)
  (for-each (lambda (new-row) (table-insert! new-row table)) lst))
;; test cases
 (display "\nTesting Problem 2\n")
 (define books (make-empty-table
 	       (list (make-column 'title 'symbol)
 		     (make-column 'author 'symbol)
 		     (make-column 'rating 'number))))


 (table-insert-all! '((sicp abelson-sussman 8)
 		     (return-of-the-king jrr-tolkien 9)
 		     (treatment-of-subordinates darth-vader 4)
 		     (project-grading tom 2)
 		     (all-things-stata frank-gehry 5)
 		     (biting-the-hand-that-feeds-me my-cat 1))
 		   books)
 (table-display books)


;_BANNER_
;;; problem 3 ;;;
;; Hint: Writing (filter predicate lst) might be helpful

(define (row-data-all lst)
  (map row-data lst))

(define (table-select selector table)
  (if (empty-table? table)
      table
      (let ((new-table (make-table (get-table-columns table) '())))
        (table-insert-all! (row-data-all (filter selector (get-table-data table))) new-table)
        new-table
        )))

;; test cases

 (display "\nTesting Problem 3\n")
 (table-display
  (table-select
   (lambda (row)
     (> (get 'rating row) 4))
   books))

(display "---\n")

 (table-display
  (table-select
   (lambda (row)
     (equal?  (get 'title row) 'sicp))
   books))


;_BANNER_
;;; problem 4 ;;;

;; Hint: Be careful about the comparator operator of the corresponding
;; row.  Writing a (get-column-type row column-name) might be helpful.



;(define (get-column-type row column-name)
;  (cond ((null? row) (error "wrong row"))
;        ((eq? (caaar row) column-name) (cadr (caar row)))
;        (else (get-column-type (cdr row) column-name))))

(define (table-order-by column table)
  (let ((new-table (make-table (get-table-columns table) '()))
        (predicate (make-row-comparator column table)))
    (table-insert-all! (row-data-all (sort predicate (get-table-data table))) new-table)
    new-table))
 
;; test cases
 (display "\nTesting Problem 4\n")

 (table-display
  (table-order-by 'rating books)
 )

(display "---\n")

 (table-display
  (table-order-by 'title books)
 )


;_BANNER_
;;; problem 5 ;;;


(define (table-delete! pred table)
  (let ((remain-rows (filter (lambda (test-row) (not (pred test-row))) (get-table-data table))))
    (change-table-data! table remain-rows)
  ))



;; test cases
 (display "\nTesting Problem 5\n")

 (table-delete!
  (lambda (row)
   (eq? (get 'author row) 'tom))
 books)

 (table-display books)



;_BANNER_
;;; problem 6 ;;;

(define (update-new-row row colname proc)
  (let ((new-row (row-col-replace row colname (proc row))))
  (if (row-type-check row) new-row
      (error "mis-type column with:" (get colname new-row)))
  ))

(define (table-update! pred column proc table)
  (let* ((rows-to-change (filter pred (get-table-data table)))
        (updated-table (table-delete! pred table))
        (changed-rows (map (lambda (row) (update-new-row row column proc)) rows-to-change)))
    (table-insert-all! (row-data-all changed-rows) updated-table))
  )

;; test cases

 (display "\nTesting Problem 6\n")
 (table-update! (lambda (row) (or (eq? (get 'name row) 'amy) (eq? (get 'name row) 'alex))) 
               'major 
               (lambda (row) '9) 
               example-table) 
 (table-display example-table)


;_BANNER_
;;; problem 7 ;;;

(define *type-table*
 (list 
        (list 'number number? <)
        (list 'symbol symbol? symbol<?)
        (list 'string string? string<?))
)


(define example-table2
(make-empty-table
 	       (list (make-column 'name 'string)
 		     (make-column 'major 'number)))
  )
   
;; test cases
 (display "\nTesting Problem 7\n")
 (table-insert! '("jen" 3) example-table2)
 (table-insert! '("ben" 6) example-table2)
 (table-insert! '("alex" 6) example-table2)
 (table-insert! '("amy" 12) example-table2)
 (table-insert! '("kim" 13) example-table2)


 (table-display example-table2)
 (display "\nordered example-table2\n")
 (table-display
  (table-order-by 'name example-table2)
 )

;_BANNER_
;;; problem 8 ;;;

;; Hint: Writing these two procedures might be helpful (contains? lst
;; x) returns true if x in the lst and (get-pos lst x) returns the
;; position of x if it is in the list.  
;; Ex: (get-pos '(1 2 3 4) 2) => 2
;;     (get-pos '(1 2 3 4) 5) => 0

(define (contains? lst x)
  (cond ((null? lst) #f)
        ((equal? x (car lst)) #t)
        (else (contains? (cdr lst) x))))

(define (get-pos lst x)
  (define (helper lst x pos)
    (cond ((null? lst) 0)
           ((equal? x (car lst)) pos)
           (else (helper (cdr lst) x (+ 1 pos)))))
  (helper lst x 1))

;test for helper functions
 (contains? '(1 2 3 4) 2)
 (contains? '(1 2 3 4) 5)
 (get-pos '(1 2 3 4) 2)
 (get-pos '(1 2 3 4) 5)


(define (make-enum-checker lst)
  (lambda (elt-to-check)
    (contains? lst elt-to-check)
    )
  )

(define (make-enum-comparator lst)
  (lambda (elt1 elt2)
    (let ((checker (make-enum-checker lst)))
      (if (and (checker elt1) (checker elt2))
          (< (get-pos lst elt1) (get-pos lst elt2))
          (error "types are not same to compare:" elt1 elt2)
          ))
    ))

(define *days* '(sunday monday tuesday wednesday thursday friday saturday)) 
(define day-checker (make-enum-checker *days*)) 
(define day-comparator (make-enum-comparator *days*)) 



;; test cases
 (display "\nTesting Problem 8\n")
 (day-checker 'monday)   ;=> #t 
 (day-checker 7)         ;=> #f
 (day-comparator 'monday 'tuesday)   ;=> #t (monday is "less than" tuesday) 
 (day-comparator 'friday 'sunday)    ;=> #f (sunday is before friday) 



(define *type-table*
 (list 
        (list 'number number? <)
        (list 'symbol symbol? symbol<?)
        (list 'string string? string<?)
        (list 'day (make-enum-checker *days*) (make-enum-comparator *days*)))
)


 (define example-table3
   (make-empty-table 
    (list (make-column 'name 'string)
          (make-column 'date 'day) 
          (make-column 'major 'number)))
    )
                   
 (table-insert! '("jen" monday 3) example-table3)
 (table-insert! '("ben" sunday 6) example-table3)
 (table-insert! '("alex" friday 6) example-table3)
 (table-insert! '("amy" tuesday 1) example-table3)
 (table-insert! '("kim" saturday 2) example-table3)
 
 (table-display example-table3)
 (display "\nordered example-table3\n")
 (table-display
  (table-order-by 'date example-table3)
 )


;_BANNER_
;;; Problem 9
;; Hint: Similar with Problem 8
(define *gender* '(male female all))

(define gender-checker 
(make-enum-checker *gender*)
  ) 
(define gender-comparator 
(make-enum-comparator *gender*)
  ) 
(define *race* '(white black all hispanic))

(define race-checker 
(make-enum-checker *race*)
  ) 
(define race-comparator
(make-enum-comparator *race*)
  )


(define *type-table*
 (list 
        (list 'number number? <)
        (list 'symbol symbol? symbol<?)
        (list 'string string? string<?)
        (list 'day (make-enum-checker *days*) (make-enum-comparator *days*))
        (list 'gender (make-enum-checker *gender*) (make-enum-comparator *gender*))
        (list 'race (make-enum-checker *race*) (make-enum-comparator *race*)))
)

;_BANNER_
;;; Problem 10
(define person-table
  (make-empty-table
   (list (make-column 'name 'string)
         (make-column 'race 'race)
         (make-column 'gender 'gender)
         (make-column 'birthyear 'number)))
)
;;; tests
 (display "\nTesting Problem 10\n")
 (table-insert! '("jen" white female 1983) person-table)
 (table-insert! '("axe" black male 1982) person-table)
 (table-display person-table)


;_BANNER_
;;; Problem 11
(display "\nPre-Testing Problem 11\n")
 (table-delete! (lambda (x) #t) person-table)
 (display "Deleted Person Table\n")
 (table-display person-table)


(define (make-person name race gender birthyear)
  (table-insert! (list name race gender birthyear) person-table)
  name)

;; test cases

 (display "\nTesting Problem 11\n")

 (define p1 (make-person "Alex" 'white 'male 1983))
 (define p2 (make-person "Clark" 'black 'male 1982))
 (table-display person-table)

;_BANNER_
;;; Problem 12
(define (person-name person) person) ;do not delete(note myself)

(define (lookup-person-row person)
  (let ((rows (get-table-data person-table)))
    (define (helper person rows)
      (cond ((null? rows) (error "bogus name error:" person))
            ((equal? (cdr (cadr (car rows))) person) (car rows))
            (else (helper person (cdr rows))))
      )
    (helper person rows)
  ))

(define (person-race person)
  (let ((row (lookup-person-row person)))
  (if (row? row) (get 'race row)
      (error "person couln't find:" person)))
  )

(define (person-gender person) 
  (let ((row (lookup-person-row person)))
  (if (row? row) (get 'gender row)
      (error "person couln't find:" person)))) 

(define (person-birthyear person) 
  (let ((row (lookup-person-row person)))
  (if (row? row) (get 'birthyear row)
      (error "person couln't find:" person)))) 

(define (person-age person) 
; returns an approximation to the person's age in years 
  (let ((*current-year* 2019.0)) 
    (- *current-year* (person-birthyear person)))) 

;; test cases
 (display "\nTesting Problem 12\n")
 (lookup-person-row p1)
 (person-race p1)
 (person-gender p1)
 (person-birthyear p1)
 (person-age p1)
 (lookup-person-row "Muslera")

;_BANNER_
;;; Problem 13

(define (update-person-row! person colname newvalue)
  (let* ((pred (lambda (row) (eq? (get 'name row) person)))
        (proc (lambda (row) newvalue)))
    (table-update! pred colname proc person-table)
    
  ))




(define (set-person-name! person newname) 
  (update-person-row! person 'name newname))

(define (set-person-race! person newrace) 
  (update-person-row! person 'race newrace)) 

(define (set-person-gender! person newgender) 
  (update-person-row! person 'gender newgender)) 

(define (set-person-birthyear! person newbirthyear) 
  (update-person-row! person 'birthyear newbirthyear))



;; QUESTION What happens? Why? Comments?
;I couldn't use set-name! because when i set on table I cannot change alyssa object.I could send data of alyssa not alyssa object.
;That's why whenever I call back alyssa the name of alyssa stays same. I think this property cannot let us doing mutators completely freely. We should find another easy mehods to implement

;;; test cases

 (display "\nTesting Problem 13\n")
 (table-display person-table)
 (define alyssa (make-person "alyssa-p-hacker" 'black 'female 1978))
 (table-display person-table)
 (set-person-name! alyssa "alyssa-p-hacker-bitdiddle")  ; got married! 
 (table-display person-table)
 (person-name alyssa)
 (lookup-person-row alyssa) ;--returns error that's why no row goes to the (person-race alyssa)
 (person-race alyssa)


;_BANNER_
;;; Problem 14
(define life-table
  (make-empty-table
   (list  (make-column 'year 'number)
          (make-column 'All-Both 'number)
          (make-column 'All-Male 'number)
          (make-column 'All-Female 'number)
          (make-column 'White-Both 'number)
          (make-column 'White-Male 'number)
          (make-column 'White-Female 'number)
          (make-column 'Black-Both 'number)
          (make-column 'Black-Male 'number)
          (make-column 'Black-Female 'number)))
   )

(table-insert-all! life-expect-data life-table)
 (display "\nTesting Problem 14\n")
 (display "Selecting 1950\n")
 (table-display
  (table-select
  (lambda (row)
    (= (get 'year row) 1950))
  life-table))

;_BANNER_
;;; Problem 15

;;;helper procedures
(define (helper year data place)
  (cond ((= place 0) (list year 'all 'all data))
        ((= place 1) (list year 'all 'male data))
        ((= place 2) (list year 'all 'female data))
        ((= place 3) (list year 'white 'all data))
        ((= place 4) (list year 'white 'male data))
        ((= place 5) (list year 'white 'female data))
        ((= place 6) (list year 'black 'all data))
        ((= place 7) (list year 'black 'male data))
        ((= place 8) (list year 'black 'female data))
  ))

  (define (change-row-to-rows datas year place)
    (if (null? datas) '()
        (cons (helper year (car datas) place) (change-row-to-rows (cdr datas) year (+ 1 place)))
    ))

  (define (broken-list lst)
    (if (null? lst) '()
       (cons (change-row-to-rows (cdar lst) (caar lst) 0) (broken-list (cdr lst))))
    )
  (define (design-list lst)
    (if (null? lst) '()
        (append (car lst) (design-list (cdr lst))))
    )

;;;Main procedure   
(define (convert-lifetable lst)
;; Converts the data to the (year race gender expected) format
   (design-list (broken-list lst))
)

;; test cases
;;my test case
(display "\nPre-Testing Problem 15\n")
(define mini-data
'(
(2016 78.7 76.2 81.1 78.9 76.4 81.3 75.3 72.0 78.3)
(2015 78.7 76.3 81.1 78.9 76.6 81.3 75.5 72.2 78.5)))
(define data-new (convert-lifetable mini-data))
data-new

(display "\nTesting Problem 15\n")
(define life-expect-data-new (convert-lifetable life-expect-data))

(define life-table-new
   (make-empty-table 
   (list (make-column 'year 'number)
         (make-column 'race 'race)
         (make-column 'gender 'gender)
         (make-column 'expected 'number)
   )))
(table-insert-all! life-expect-data-new life-table-new)
(display "Selecting 1950 from new data\n")
(table-display
(table-select
 (lambda (row)
  (= (get 'year row) 1950))
  life-table-new))


;_BANNER_
;;; Problem 16
(display "\nTesting Problem 16\n")


(define new-life-table
  (make-empty-table
   (list  (make-column 'year 'number)
          (make-column 'race 'race)
          (make-column 'gender 'gender)
          (make-column 'expected 'number)))
   )

(define problem16-table
  (let ((new-table new-life-table))
    (table-insert-all! life-expect-data-new new-table)
    (table-select (lambda (row) (and (equal? (get 'race row) 'white)
                                     (equal? (get 'gender row) 'female)
                                     (and (< (get 'year row) 1960) (> (get 'year row) 1949))))
                  new-table)
        
  ))

;;; QUESTION Was life expectancy for white women steadily increasing
;;; in this decade?
;yes it is increasing by years, but it is not steadily becuase at some points data shows that expected life span stays same and for years 1956-1957 opposite case occurs. 

(table-display
  (table-order-by 'expected problem16-table)
)

;; Paste the output of Problem 16 for black female
;; between 1950 and 1959
;we are selecting for white but this question wants for black-female, I was not sure about which one to choose that's why I used both of them. 
;year	race	gender	expected	
;1959	black	female	66.5	
;1956	black	female	66.1	
;1955	black	female	66.1	
;1954	black	female	65.9	
;1958	black	female	65.8	
;1957	black	female	65.5	
;1953	black	female	64.5	
;1952	black	female	63.8	
;1951	black	female	63.4	
;1950	black	female	62.9
;
;year	race	gender	expected	
;1959	white	female	74.2	
;1958	white	female	73.9	
;1956	white	female	73.9	
;1957	white	female	73.7	
;1955	white	female	73.7	
;1954	white	female	73.7	
;1953	white	female	73.0	
;1952	white	female	72.6	
;1951	white	female	72.4	
;1950	white	female	72.2	

;_BANNER_
;;; Problem 17
 


(define p3 (make-person "GeorgeBest" 'white 'female 1987))
(define p4 (make-person "Lizarazu" 'white 'male 1940))

(table-insert-all! life-expect-data-new new-life-table)

(define (expected-years person)
  (let ((p-race (person-race person))
        (p-gender (person-gender person))
        (p-birthyear (person-birthyear person)))

   ( - (get 'expected (car (get-table-data (table-select (lambda (row) (and (equal? (get 'race row) p-race)
                                     (equal? (get 'gender row) p-gender)
                                     (= (get 'year row) p-birthyear)))
                 new-life-table)))) (person-age person))
  ))



;; test cases
(display "\nTesting problem 17\n")
(expected-years p3)
(expected-years p4)
