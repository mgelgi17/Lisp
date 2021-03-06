;_BANNER_
;;;   The Object-Oriented Adventure Game
;_BANNER_
;;;
;;; mgelgi17@ku.edu.tr    23/12/19
;;;                                
;;; Before you start:
;;; * Please read the project handout available on the course
;;;   web site first to get a basic idea about the project and the 
;;;   logic behind it, then to find out the details about what 
;;;   your tasks are for the rest of the project.
;;;
;;; * The following code should be studied and loaded for this
;;;   project.  Please do not modify these files, put all your work in
;;;   this file.
;;;
;;; - objsys.scm: support for an elementary object system
;;; - objtypes.scm: a few nice object classes
;;; - setup.scm: a bizarre world constructed using these classes
;;;
;;; * Plan your work with pencil and paper before starting to code.
;;;
;;; While you are working:
;;; * Type all your work and notes in the appropriate sections of this file.
;;; * Please do not delete any of the existing lines.
;;; * Use the procedure names given in the instructions.
;;; * Remember to frequently save your file.
;;; * Use semicolon (;) to comment out text, tests and unused code.
;;; * Remember to document your code (in this file)
;;; * Remember our collaboration policy: you can discuss with your friends but:
;;;
;;;   *** NOTHING WRITTEN GETS EXCHANGED ***
;;;
;;;
;;; When you are done:
;;; * Perform a final save and submit your work following the instructions.
;;; * Please do not make any modifications after midnight on the due date.
;;; * Please send an email to helpline [comp200-group@ku.edu.tr] if you have any questions.
;;; * Make sure your file loads without errors:
;;; ****************************************************************************
;;; ***  Your code should run without any syntactic errors. Projects  causing error will NOT be graded. ***
;;; ****************************************************************************
;;;
;; Do NOT modify or delete the lines below.
(#%require (only racket/base random))
(load "objsys.scm")     	   	  	
(load "objtypes.scm")     	   	  	
(load "setup.scm")     	   	  	
(define nil '())   
(define your-answer-here #f)
;;;;;;;;;

;_BANNER_
;;; PART II. Programming Assignment
;;;
;;; The answers to the computer exercises in Section 5 go in the
;;; appropriate sections below.
;;;



;_BANNER_
;;;;;;;;;;;;; Setting up ;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;;;;;;;;;;;; CODES: ;;;;;;;;;;;;;
;;

;(ask screen 'deity-mode #f)
;(setup 'metehan)
;(ask me 'say (list 'i 'am 'at (ask (ask me 'location) 'name)))
;(ask me 'say (list 'i 'am (ask me 'name)))
;(ask me 'say '("Hello World"))
;(ask me 'go (ask (car (ask (ask me 'location) 'EXITS)) 'name))
;(ask me 'look-around)

;---------there is 2 different that I could use------------

;1)
;(define computer (create-mobile-thing 'computer (ask me 'location)))
;(ask me 'take (thing-named 'computer))
;(ask me 'toss 'computer)
;(ask me 'die)

;2)     ----this creates interesting outputs because of diploma but we have to make sure we are in registrar office
;(ask me 'take (thing-named 'diploma))
;(ask me 'toss 'diploma)
;(ask me 'die)

;_BANNER_
;;;;;;;;;;;;; TRANSCRIPT: ;;;;;;;;;;;;;
;;

#|
At bursar-office metehan says -- i am at bursar-office 
At bursar-office metehan says -- i am metehan 
At bursar-office metehan says -- Hello World 
metehan moves from bursar-office to registrar-office 
At registrar-office metehan says -- Hi prof-yuret 
prof-yuret moves from registrar-office to bursar-office 
--- the-clock Tick 0 --- 
You are in registrar-office 
You are not holding anything. 
You see stuff in the room: diploma 
There are no other people around you. 
The exits are in directions: west out #t

--------if takes diploma: (has to be in registrar office)
At registrar-office metehan says -- I take diploma from registrar-office 
At registrar-office metehan says --    HURRRAY!!!!!!!!!!!!! 
At registrar-office metehan says -- I drop diploma at registrar-office 
At registrar-office metehan says -- SHREEEEK!  I, uh, suddenly feel very faint... 
An earth-shattering, soul-piercing scream is heard... 
metehan moves from registrar-office to heaven game-over-for-you-dude

--------if takes computer(created by me)
At registrar-office metehan says -- I take computer from registrar-office 
At registrar-office metehan says -- I drop computer at registrar-office 
At registrar-office metehan says -- SHREEEEK!  I, uh, suddenly feel very faint... 
An earth-shattering, soul-piercing scream is heard... 
metehan moves from registrar-office to heaven game-over-for-you-dude
|#

;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; END ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;_BANNER_
     

     
     
     
     
     

;_BANNER_
;;;;;; Understanding installation;;;;;
;_BANNER_
;;
;;;;;;;;;;;;; ANSWER: ;;;;;;;;;;;;;
;;
     
#|
In this question,Alyssa points out that would be a bug.
“If you did that,” she says, “then when you make and install an autonomous person,
and this person moves to a new place, he’ll be in two places at once!”

So, if ask method is used instead of delegate method, we pass the superclass object as a self to the method.
That means in this situation, if you move your autonomous person, its superclass's location will be changed and will have 2 different locations.
Instead, if we use delegate, it will get the method from superclass and call for subclass.
i.e:
(method (get-method message in-object))
(apply method for-object)
and movement will change the location of subclass.
|#   	

;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; END ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;_BANNER_

     
     
     
     
     
     
     
     
     
     

;_BANNER_
;;;;;;;;;;;; Who just died? ;;;;;;;;;;
;_BANNER_
;;
;;;;;;;;;;;;; CODE: ;;;;;;;;;;;;;
;;
     
;(run-clock 10)
;(ask (car (ask heaven 'THINGS)) 'name)
     
;_BANNER_
;;;;;;;;;;;;; EXPLANATION: ;;;;;;;;;;;;;
;;
#|
person's DIE method calls (ask death-exit 'USE self) line.
death-exit is defined as (make-exit nil 'heaven heaven) in setup.scm
so, person will go to the heaven.
heaven is a place which inherits a container and a named-object.
things in a place are stored in container and ADD-THING method adds new object to the head of the <things> list.
we ask for 'THINGS (inherited from container) to heaven and take the car of the things list.
(car (ask heaven 'THINGS)) returns a person.
then we ask this person his/her 'name.
|#

;_BANNER_
;;;;;;;;;;;;; TRANSCRIPT: ;;;;;;;;;;;;;
;;
#|    
--- the-clock Tick 1 --- 
An earth-shattering, soul-piercing scream is heard... 
At heaven ben-bitdiddle says -- Hi metehan 
--- the-clock Tick 2 --- 
An earth-shattering, soul-piercing scream is heard... 
At heaven comp200-student says -- Hi ben-bitdiddle metehan 
--- the-clock Tick 3 --- 
--- the-clock Tick 4 --- 
An earth-shattering, soul-piercing scream is heard... 
At heaven lambda-man says -- Hi comp200-student ben-bitdiddle metehan 
--- the-clock Tick 5 --- 
An earth-shattering, soul-piercing scream is heard... 
At heaven prof-yuret says -- Hi lambda-man comp200-student ben-bitdiddle metehan 
--- the-clock Tick 6 --- 
--- the-clock Tick 7 --- 
--- the-clock Tick 8 --- 
--- the-clock Tick 9 --- 
--- the-clock Tick 10 --- done
metehan
|#

;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; END ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;_BANNER_
     
 
;_BANNER_
;;;;;; Computer exercise: But I'm too young to die!! ;;;;
;_BANNER_
;;
;;;;;;;;;;;;; CODE: ;;;;;;;;;;;;;
;;

(define (make-person name birthplace) ; symbol, location -> person
  (let ((mobile-thing-part (make-mobile-thing name birthplace))
	(container-part    (make-container))
	(health            3)
	(strength          1)
   (lives             3))
    (lambda (message)
      (case message
	((PERSON?) (lambda (self) #T))
	((STRENGTH) (lambda (self) strength))
	((HEALTH) (lambda (self) health))
        ((SAY)
         (lambda (self list-of-stuff)
           (ask screen 'TELL-ROOM (ask self 'location)
                (append (list "At" (ask (ask self 'LOCATION) 'NAME)
                                 (ask self 'NAME) "says --")
                           list-of-stuff))
                  'SAID-AND-HEARD))
	((HAVE-FIT)
	 (lambda (self)
	   (ask self 'SAY '("Yaaaah! I am upset!"))
	   'I-feel-better-now))

	((PEOPLE-AROUND)	; other people in room...
	 (lambda (self)
	   (let* ((in-room (ask (ask self 'LOCATION) 'THINGS))
		  (people (myfilter (lambda (x) (is-a x 'PERSON?)) in-room)))
	     (delq self people))))

	((STUFF-AROUND)		; stuff (non people) in room...
	 (lambda (self)
	   (let* ((in-room (ask (ask self 'LOCATION) 'THINGS))
		  (stuff (myfilter (lambda (x) (not (is-a x 'PERSON?))) in-room)))
	     stuff)))
	 
	((PEEK-AROUND)		; other people's stuff...
	 (lambda (self)
	   (let ((people (ask self 'PEOPLE-AROUND)))
	     (accumulate append '() (map (lambda (p) (ask p 'THINGS)) people)))))

	((TAKE)
	 (lambda (self thing)
	   (cond ((ask self 'HAVE-THING? thing)  ; already have it
		  (ask self 'SAY (list "I am already carrying"
				       (ask thing 'NAME)))
		  #f)
		 ((or (is-a thing 'PERSON?)
		      (not (is-a thing 'MOBILE-THING?)))
		  (ask self 'SAY (list "I try but cannot take"
				       (ask thing 'NAME)))
		  #F)
		 (else
		  (let ((owner (ask thing 'LOCATION)))
		    (ask self 'SAY (list "I take" (ask thing 'NAME) 
					 "from" (ask owner 'NAME)))
		    (if (is-a owner 'PERSON?)
			(ask owner 'LOSE thing self)
			(ask thing 'CHANGE-LOCATION self))
		    thing)))))

	((LOSE)
	 (lambda (self thing lose-to)
	   (ask self 'SAY (list "I lose" (ask thing 'NAME)))
	   (ask self 'HAVE-FIT)
	   (ask thing 'CHANGE-LOCATION lose-to)))

	((DROP)
	 (lambda (self thing)
	   (ask self 'SAY (list "I drop" (ask thing 'NAME)
				"at" (ask (ask self 'LOCATION) 'NAME)))
	   (ask thing 'CHANGE-LOCATION (ask self 'LOCATION))))

        ((GO-EXIT)
         (lambda (self exit)
           (ask exit 'USE self)))

	((GO)
	 (lambda (self direction) ; person, symbol -> boolean
	   (let ((exit (ask (ask self 'LOCATION) 'EXIT-TOWARDS direction)))
	     (if (is-a exit 'EXIT?)
                 (ask self 'GO-EXIT exit)
		 (begin (ask screen 'TELL-ROOM (ask self 'LOCATION)
			     (list "No exit in" direction "direction"))
			#F)))))
	((SUFFER)
	 (lambda (self hits)
	   (ask self 'SAY (list "Ouch!" hits "hits is more than I want!"))
	   (set! health (- health hits))
	   (if (<= health 0) (ask self 'DIE))
	   health))

	((DEATH-SCREAM)
	 (lambda (self)
	   (ask screen 'TELL-WORLD
		'("An earth-shattering, soul-piercing scream is heard..."))))

	((ENTER-ROOM)
	 (lambda (self)
	   (let ((others (ask self 'PEOPLE-AROUND)))
	     (if (not (null? others))
		 (ask self 'SAY (cons "Hi" (names-of others)))))
	   (ask (ask self 'location) 'make-noise self)
	   #T))
	
	;; Here is the original DIE method
   #|
	 ((DIE)
	  (lambda (self)
	    (ask self 'SAY '("SHREEEEK!  I, uh, suddenly feel very faint..."))
	    (for-each (lambda (item) (ask self 'LOSE item (ask self 'LOCATION)))
	 	     (ask self 'THINGS))
	    (ask self 'DEATH-SCREAM)
	    (ask death-exit 'USE self)
	    'GAME-OVER-FOR-YOU-DUDE))
   |#
	;; Your version goes here:
 
          ((DIE)
           (lambda (self)   		      	 
             (ask self 'SAY '("SHREEEEK!  I, uh, suddenly feel very faint..."))
             (for-each (lambda (item) (ask self 'LOSE item (ask self 'LOCATION)))
                       (ask self 'THINGS))
             (set! lives (- lives 1))
             (if (eq? lives 0)
                 (begin (ask self 'DEATH-SCREAM)
                        (ask death-exit 'USE self)
                        'GAME-OVER-FOR-YOU-DUDE)
                 (begin (set! health 3)
                        (delegate mobile-thing-part self 'CHANGE-LOCATION birthplace)
                        (list 'I 'DIDNT 'DIE 'I 'STILL 'HAVE lives 'LIVES)))
             )
           )

	(else (find-method message mobile-thing-part container-part))))))


;(setup 'metehan)
;(ask me 'die)
;(ask me 'say (list 'I 'AM 'AT (ask (ask me 'location) 'name)))
;(ask me 'die)
;(ask me 'say (list 'I 'AM 'AT (ask (ask me 'location) 'name)))
;(ask me 'die)
;(ask me 'say (list 'I 'AM 'AT (ask (ask me 'location) 'name)))



;_BANNER_
;;;;;;;;;;;;; EXPLANATION: ;;;;;;;;;;;;;
;;
;For start to check I need to reinstall world becuase our avatar die         
;First, lives is decremented by 1.
; then we check if lives is equal to 0, original DIE method scenario is applied.
; if lives is not equal to 0, we set health to 3 and call the 'CHANGE-LOCATION method of mobile-thing-part with argument birthplace.
   		      	 
     
     
     
;_BANNER_
;;;;;;;;;;;;; TRANSCRIPT: ;;;;;;;;;;;;;
;;     

#|
At adm-building metehan says -- SHREEEEK!  I, uh, suddenly feel very faint... (i didnt die i still have 2 lives)

At adm-building metehan says -- i am at adm-building said-and-heard

At adm-building metehan says -- SHREEEEK!  I, uh, suddenly feel very faint... (i didnt die i still have 1 lives)

At adm-building metehan says -- i am at adm-building said-and-heard

At adm-building metehan says -- SHREEEEK!  I, uh, suddenly feel very faint... 
An earth-shattering, soul-piercing scream is heard... 
metehan moves from adm-building to heaven game-over-for-you-dude

At heaven metehan says -- i am at heaven said-and-heard
|# 
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; END ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;_BANNER_
     
     
     
     
     
     
     
     
     

;_BANNER_
;;; Computer exercise: Perhaps to arm oneself against a sea of .... ;;;;
;_BANNER_
;;
;;;;;;;;;;;;; CODE: ;;;;;;;;;;;;;
;;
(define (make-weapon name location damage)
  (let ((mobile-thing-part (make-mobile-thing name location)))
    (lambda (message)
      (case message
        ((WEAPON?) (lambda (self) #t))
        ((DAMAGE) (lambda (self) damage))
        ((HIT) (lambda (self hitter target)
                   (ask self 'emit (list (ask hitter 'NAME) " is hitting to " (ask target 'NAME) " with " (ask self 'name))) 
                   (ask target 'SUFFER (random-number damage)))
                 )

        ((EMIT)   		      	 
         (lambda (self text)
           (if (is-a (ask self 'LOCATION) 'PERSON?)
               
               (ask screen 'TELL-ROOM (ask (ask self 'LOCATION) 'LOCATION)
                (append (list "At" (ask (ask (ask self 'LOCATION) 'LOCATION) 'NAME) ", ")
			text))
               
               (ask screen 'TELL-ROOM (ask self 'LOCATION)
                (append (list "At" (ask (ask self 'LOCATION) 'NAME) ", ")
			text))
               )))
        
        (else (get-method message mobile-thing-part))
        ))))

(define (create-weapon name location damage)
  (create make-weapon name location damage))



;_BANNER_
;;;;;;;;;;;;; EXPLANATION: ;;;;;;;;;;;;;
;;

#|
The weapon class has 3 methods,
  1) WEAPON? simply checks whether the object is weapon or not.
  2) DAMAGE method returns max-damage of the weapon.
  3) HIT method takes 2 arguments, hitter person and target player.
HIT firsly emit who is hitting to whom with which weapon, then calls target's suffer method.

Weapon class takes 3 parameters during construction. It has name, location and max damage.
The class extends mobile-thing class.
|#     

;_BANNER_
;;;;;;;;;;;;; TRANSCRIPT: ;;;;;;;;;;;;;
;;
;(setup 'metehan)
;(populate-weapons all-rooms) ;----? gets error
;(define laserGun (create-weapon 'laserGun (ask me 'location) 9))
;(define TA (create-autonomous-player 'Comp200-TA (ask me 'location) 1 2))

;(ask laserGun 'HIT me TA)
;At bursar-office ,  metehan  is hitting to  comp200-ta  with  lasergun 
;At bursar-office comp200-ta says -- Ouch! 9 hits is more than I want! 
;At bursar-office comp200-ta says -- SHREEEEK!  I, uh, suddenly feel very faint... 3

;(ask laserGun 'HIT me TA)
;At bursar-office ,  metehan  is hitting to  comp200-ta  with  lasergun 
;At bursar-office comp200-ta says -- Ouch! 8 hits is more than I want! 
;At bursar-office comp200-ta says -- SHREEEEK!  I, uh, suddenly feel very faint... 3


;(ask laserGun 'HIT me TA)
;At bursar-office ,  metehan  is hitting to  comp200-ta  with  lasergun 
;At bursar-office comp200-ta says -- Ouch! 3 hits is more than I want! 
;At bursar-office comp200-ta says -- SHREEEEK!  I, uh, suddenly feel very faint... 
;An earth-shattering, soul-piercing scream is heard... 
;comp200-ta moves from bursar-office to heaven 0	
      
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; END ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;_BANNER_
      
      
      
      
      
      
     
     
      
      
;_BANNER_
;;;;;;;; Computer exercise: Good thing I'm armed and dangerous ;;;;;;;;;
;_BANNER_
;;
;;;;;;;;;;;;; CODE: ;;;;;;;;;;;;;
;;
(define (make-violent-person name birthplace activity miserly freq)
  (let ((autonomous-player-part (make-autonomous-player name birthplace activity miserly)))
    (lambda (message)
      (case message
        ((VIOLENT-PERSON?) (lambda (self) #t))
        ((INSTALL) (lambda (self)
		     (ask clock 'ADD-CALLBACK
			  (make-clock-callback 'check-engage-in-violent self 'CHECK-ENGAGE-IN-VIOLENT))
		     (delegate autonomous-player-part self 'INSTALL)))

        ((CHECK-ENGAGE-IN-VIOLENT)   		      	 
         (lambda (self)
           (let ((victims (ask self 'PEOPLE-AROUND)))
             (if (not (null? victims))
                 (let ((prob (random-number freq)))
                   (if (eq? prob 1) 
                       (let* ((victim (pick-random victims)) 
                              (weapons (myfilter (lambda (x) (is-a x 'WEAPON?)) (ask self 'THINGS)))) 

                         (if (null? weapons)
                             'I-DONT-HAVE-WEAPON
                             (begin 
                               ;(ask self 'TAKE weapons)
                               (ask (pick-random weapons) 'HIT self victim) 
                               'ENGAGED-IN-A-VIOLENT-ACT)))
                       
                       'NOT-ENGAGED-IN-A-VIOLENT-ACT) 
                       )
                 'NO-PEOPLE-AROUND))
             ))

        ((DIE)    	  	   	 
         (lambda (self)    	  	   	 
           (ask clock 'REMOVE-CALLBACK self 'CHECK-ENGAGE-IN-VIOLENT)
           (delegate autonomous-player-part self 'DIE)))

        (else (get-method message autonomous-player-part))))))

(define (create-violent-person name birthplace activity miserly freq)
  (create make-violent-person name birthplace activity miserly freq))
     

;_BANNER_
;;;;;;;;;;;;; EXPLANATION: ;;;;;;;;;;;;;
;;

#|
The violent player class constructor takes 5 parameters and extends autonomous-player class.
As a difference, violent player has a violence frequency and with some randomness,
a violent player chooses a person in the same room and chooses a weapon from its bag and hits the other player.
this action is added to clock as a callback and every clock tick, CHECK-ENGAGE-IN-VIOLENT method is called.
DIE method removes the callback from clock.
To test CHECK-ENGAGE-IN-VIOLENT method, I created a dungeon place and put myself and violent player into this place.
I added 2 weapons to this place and run the clock 5 times.
violent player first picked the weapons from floor
then, attacked me after 1 clock.
|#     

;_BANNER_
;;;;;;;;;;;;; TRANSCRIPT: ;;;;;;;;;;;;;
;;
;(setup 'metehan)
;(define dungeon (create-place 'dungeon))
;(ask me 'CHANGE-LOCATION dungeon)
;(define wildPerson (create-violent-person 'wild-Person dungeon 1 2 2))
;(define ak47 (create-weapon 'ak47 dungeon 9))
;(define m4a1 (create-weapon 'm4a1 dungeon 7))
;(define shotgun (create-weapon 'shotgun dungeon 5))
;(run-clock 5)
      
#|
At dungeon wild-person says -- I take m4a1 from dungeon 
--- the-clock Tick 0 --- 
At dungeon wild-person says -- I take ak47 from dungeon 
--- the-clock Tick 1 --- 
At dungeon ,  wild-person  is hitting to  metehan  with  ak47 
At dungeon metehan says -- Ouch! 2 hits is more than I want! 
--- the-clock Tick 2 --- 
At dungeon wild-person says -- I take shotgun from dungeon 
At dungeon ,  wild-person  is hitting to  metehan  with  m4a1 
At dungeon metehan says -- Ouch! 4 hits is more than I want! 
At dungeon metehan says -- SHREEEEK!  I, uh, suddenly feel very faint... 
--- the-clock Tick 3 --- 
--- the-clock Tick 4 --- done
|#


;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; END ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;_BANNER_
     
     
     
     
     
     
     
     
;_BANNER_
;;; Computer exercise: A good hacker could defuse this situation ;;;;;;;
;_BANNER_
;;
;;;;;;;;;;;;; CODE: ;;;;;;;;;;;;;
;;
(define (make-bomb name location damage)
  (let* ((mobile-thing-part (make-mobile-thing name location))
         (aware-thing-part (make-aware-thing))
         (armed #f)
         (destroyed #f))
    
    (lambda (message)
      (case message
        ((BOMB?) (lambda (self) #T))
        ((ARM) (lambda (self)
                 (set! armed #t)))
        ((DISARM) (lambda (self)
                    (set! armed #f)))
        ((TRIGGER) (lambda (self)
                     (if armed (ask self 'ACTIVATE) 'BOMB-IS-NOT-ARMED-YET)))
        ((HEARD-NOISE) (lambda (self someone)
                         (ask self 'TRIGGER)))
        ((ACTIVATE)
         (lambda (self)
           (if destroyed
               'BOMB-IS-ALREADY-DESTROYED
               (let* ((victims (ask self 'people-around)))
                 (map (lambda (victim)
                        (ask victim 'SUFFER damage)) victims)
                 (ask self 'EMIT (list "Type of the bomb: " (ask self 'NAME) " -- and these people suffered " damage "damage"
                          (map (lambda (victim) (ask victim 'NAME)) victims))) 
                 (ask self 'DESTROY)))))            
         
        ((DESTROY)
         (lambda (self)
           (set! destroyed #t)
           (delegate mobile-thing-part self 'DESTROY)))

        ((IS-ARMED)
         (lambda (self)
           armed))

         ((PEOPLE-AROUND)
          (lambda (self)   		      	 
            (let* ((in-room (ask (ask self 'LOCATION) 'THINGS))
                   (people (myfilter (lambda (x) (is-a x 'PERSON?)) in-room)))
              (delq self people))))

        (else (find-method message mobile-thing-part aware-thing-part))))))

(define (create-bomb name location damage)
  (create make-bomb name location damage))


;_BANNER_
;;;;;;;;;;;;; EXPLANATION: ;;;;;;;;;;;;;
;; 		      	 

#|
Bomb class constructor takes 3 parameters: name location and damage. It extends both Mobile Thing and Aware classes.
It has BOMB?, ARM, DISARM, TRIGGER, HEARD-NOISE, ACTIVATE, DESTROY and PEOPLE-AROUND methods.
BOMB? return whether the object is bomb or not.
ARM simply sets arm to true.
DISARM simply sets arm to false.
TRIGGER calls ACTIVATE if arm == true
ACTIVATE looks for people around and suffer them with bomb damage and emits people and damage information if the bomb is not destroyed.
DESTROY sets destroyed to true and delegates remaining work to mobile-thing-part
PEOPLE-AROUND returns the list of people in the location.

To test if the bomb class methods work or not, I created a bomb and put it my location.
Then I leave the room and come back.
When I come back to room, I make a noise and trigger method is called, the bomb was activated and I got damage.
|# 		      	 

;_BANNER_
;;;;;;;;;;;;; TRANSCRIPT: ;;;;;;;;;;;;;
;;

;(setup 'metehan)
;(populate-bombs all-rooms)
;(define tnt (create-bomb 'tnt (ask me 'LOCATION) '15))
;(ask tnt 'ARM)
;(ask me 'LOOK-AROUND)


;You are in amphitheater 
;You are not holding anything. 
;You see stuff in the room: tnt umbrella 
;You see other people: lambda-man 
;The exits are in directions: west ok

;(ask me 'GO 'WEST)

;metehan moves from eng-building to parking-lot 
;At parking-lot metehan says -- Hi prof-yuret 
;prof-yuret moves from parking-lot to eng-building 
;At parking-lot prof-yuret says -- I try but cannot take fancy-cars 
;--- the-clock Tick 0 --- 
;You are in parking-lot 
;You are not holding anything. 
;You see stuff in the room: fancy-cars 
;You see other people: prof-yuret 
;The exits are in directions: east #t

;(ask me 'GO 'EAST)

;metehan moves from sos-building to amphitheater 
;At amphitheater metehan says -- Ouch! 15 hits is more than I want! 
;At amphitheater metehan says -- SHREEEEK!  I, uh, suddenly feel very faint... 
;At amphitheater Type of the bomb:  tnt  -- and these people suffered  15 damage (metehan) 
;--- the-clock Tick 1 --- 
;You are in amphitheater 
;You are not holding anything. 
;You see stuff in the room: umbrella 
;There are no other people around you. 
;The exits are in directions: west #t
      
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; END ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;_BANNER_
     
     
     
     
     
;_BANNER_
;# DO NOT FORGET TO SUBMIT YOUR WORK BEFORE THE DEADLINE!         #
;_BANNER_
;# GOOD LUCK!                                                     #
;_BANNER_
     
     




