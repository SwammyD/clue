;;(load "C:\\Users\\ramen\\Documents\\Github\\clue\\testFunc.LISP")

;;(defun test-ask (fact)
;;  (fire::ask-it fact
;;                :context 'EverythingPSC :response :bindings))

;; initialize the deck
(setq allSuspects '("white" "green" "peacock" "plum" "scarlet" "mustard"))
(setq allWeapons '("pipe" "rope" "candlestick" "wrench" "knife" "revolver"))
(setq allLocations '("kitchen" "diningRoom" "lounge" "hall" "study" "conservatory" "billiardRoom" "ballroom" "library"))
(setq allCards (append (append allSuspects allWeapons) allLocations))
(setq solution '())

;; player hands
(setq p1hand '())
(setq p2hand '())
(setq p3hand '())

;; Cards players have seen
(setq p1seen '())
(setq p2seen '())
(setq p3seen '())

;; Cards players have NOT seen
(setq p1notSeen allCards)
(setq p2notSeen allCards)
(setq p3notSeen allCards)

(defun start-game ()
    ;; initialize solution first
    (let ((posSus (random 6))
          (posWeap (random 6))
          (posLoc (random 9))
          )
      (setq solution (cons (nth posLoc allLocations) solution))
      (setq allLocations (remove (nth posloc allLocations) allLocations))
      (setq solution (cons (nth posWeap allWeapons) solution))
      (setq allWeapons (remove (nth posWeap allWeapons) allWeapons))
      (setq solution (cons (nth posSus allSuspects) solution))
      (setq allSuspects (remove (nth posSus allSuspects) allSuspects))
      (setq allCards (remove (car solution) allCards))
      (setq allCards (remove (cadr solution) allCards))
      (setq allCards (remove (caddr solution) allCards))
      ;; Distribute the remaining cards
      ;; there is definitely a better way to do this, but for now this will do
      (setq p1hand (cons (nth (random 18) allCards) p1hand))
      (setq allCards (remove (car p1hand) allCards))
      (setq p1notSeen (remove (car p1hand) p1notSeen))
      
      (setq p2hand (cons (nth (random 17) allCards) p2hand))
      (setq allCards (remove (car p2hand) allCards))
      (setq p2notSeen (remove (car p2hand) p2notSeen))
      
      (setq p3hand (cons (nth (random 16) allCards) p3hand))
      (setq allCards (remove (car p3hand) allCards))
      (setq p3notSeen (remove (car p3hand) p3notSeen))
      
      (setq p1hand (cons (nth (random 15) allCards) p1hand))
      (setq allCards (remove (car p1hand) allCards))
      (setq p1notSeen (remove (car p1hand) p1notSeen))

      (setq p2hand (cons (nth (random 14) allCards) p2hand))
      (setq allCards (remove (car p2hand) allCards))
      (setq p2notSeen (remove (car p2hand) p2notSeen))
 
      (setq p3hand (cons (nth (random 13) allCards) p3hand))
      (setq allCards (remove (car p3hand) allCards))
      (setq p3notSeen (remove (car p3hand) p3notSeen))

      (setq p1hand (cons (nth (random 12) allCards) p1hand))
      (setq allCards (remove (car p1hand) allCards))
      (setq p1notSeen (remove (car p1hand) p1notSeen))

      (setq p2hand (cons (nth (random 11) allCards) p2hand))
      (setq allCards (remove (car p2hand) allCards))
      (setq p2notSeen (remove (car p2hand) p2notSeen))
      
      (setq p3hand (cons (nth (random 10) allCards) p3hand))
      (setq allCards (remove (car p3hand) allCards))
      (setq p3notSeen (remove (car p3hand) p3notSeen))

      (setq p1hand (cons (nth (random 9) allCards) p1hand))
      (setq allCards (remove (car p1hand) allCards))
      (setq p1notSeen (remove (car p1hand) p1notSeen))

      (setq p2hand (cons (nth (random 8) allCards) p2hand))
      (setq allCards (remove (car p2hand) allCards))
      (setq p2notSeen (remove (car p2hand) p2notSeen))
      
      (setq p3hand (cons (nth (random 7) allCards) p3hand))
      (setq allCards (remove (car p3hand) allCards))
      (setq p3notSeen (remove (car p3hand) p3notSeen))

      (setq p1hand (cons (nth (random 6) allCards) p1hand))
      (setq allCards (remove (car p1hand) allCards))
      (setq p1notSeen (remove (car p1hand) p1notSeen))

      (setq p2hand (cons (nth (random 5) allCards) p2hand))
      (setq allCards (remove (car p2hand) allCards))
      (setq p2notSeen (remove (car p2hand) p2notSeen))
      
      (setq p3hand (cons (nth (random 4) allCards) p3hand))
      (setq allCards (remove (car p3hand) allCards))
      (setq p3notSeen (remove (car p3hand) p3notSeen))

      (setq p1hand (cons (nth (random 3) allCards) p1hand))
      (setq allCards (remove (car p1hand) allCards))
      (setq p1notSeen (remove (car p1hand) p1notSeen))

      (setq p2hand (cons (nth (random 2) allCards) p2hand))
      (setq allCards (remove (car p2hand) allCards))
      (setq p2notSeen (remove (car p2hand) p2notSeen))
      
      (setq p3hand (cons (nth 0 allCards) p3hand))
      (setq allCards (remove (car p3hand) allCards))
      (setq p3notSeen (remove (car p3hand) p3notSeen))

      ;; set cards seen for all players
      (setq p1seen p2hand)
      (setq p2seen p2hand)
      (setq p3seen p3hand)
      (print solution)
      (print p1hand)
      (print p2hand)
      (print p3hand)
      (print p1notSeen)
      (print p2notSeen)
      (print p3notSeen)
      ;; call turn
      ;; (turn 0)
      )
  )

(defun end-game ()
  (setq allSuspects '("white" "green" "peacock" "plum" "scarlet" "mustard"))
  (setq allWeapons '("pipe" "rope" "candlestick" "wrench" "knife" "revolver"))
  (setq allLocations '("kitchen" "diningRoom" "lounge" "hall" "study" "conservatory" "billiardRoom" "ballroom" "library"))
  (setq solution '())
  (setq p1hand '())
  (setq p2hand '())
  (setq p3hand '()))

(defun turn (playerNum)
(cond ((= playerNum 0) 
       (playerTurn)
       (turn 1));;do stuff for player
      ((= playerNum 1) 
       (AITurn playerNum)
       (turn 2)) ;;do stuff for AI 1
      ((= playerNum 2) 
       (AITurn playerNum)
       (turn 0)))) ;; do stuff for AI 2

(defun playerTurn ()
  ;;print out cards in hand
  (format t "Your cards: ~A ~A"
    p1hand #\linefeed)
  ;;print out cards seen
  (format t "Cards you have seen: ~A ~A"
    p1seen #\linefeed)
  ;;print out cards not seen
  (format t "These are the potential murder cards: ~A ~A"
    p1notSeen #\linefeed)
  ;;ask for interrogation
  (format t "Make a guess. ~A"
    #\linefeed)
  (setq x (read-from-string (format nil "(~A ~A ~A) ~A"
                              (read) (read) (read) #\linefeed)))
  ;; the variable x can be now be read.
  ;; use nth
  ;;update the cards seen and the cards not seen
  ;;make final y/n
  ;;if yes, make guess
  )

(defun make-guess (x notSeen)
  (setq y '())
  (setq y (cons (nth (caddr x) notSeen) y))
  (setq y (cons (nth (cadr x) notSeen) y))
  (setq y (cons (nth (car x) notSeen) y)))

(defun AITurn (num)
;;scan their cards and cards seen
;;formulate a guess with cards not in hand/seen
;;interrogate players
;;update cards seen
;;make final if no disproving evidencce
)

(defun interrogate-AI-1
 ()
)

(defun interrogate-AI-2
 ()
)

(defun interrogate-player
 ()
)