;;(load "C:\\Users\\ramen\\Documents\\Github\\clue\\testFunc.LISP")

;;(defun test-ask (fact)
;;  (fire::ask-it fact
;;                :context 'EverythingPSC :response :bindings))

;; initialize the deck
(setq allSuspects '("white" "green" "peacock" "plum" "scarlet" "mustard"))
(setq allWeapons '("pipe" "rope" "candlestick" "wrench" "knife" "revolver"))
(setq allLocations '("kitchen" "diningRoom" "lounge" "hall" "study" "conservatory" "billiardRoom" "ballroom" "library"))
(setq solution '())

;; player hands
(setq p1hand '())
(setq p2hand '())
(setq p3hand '())

;; Cards players have seen
(setq p1seen '())
(setq p2seen '())
(setq p3seen '())

(defun start-game ()
    ;; initialize solution first
    (let ((posSus (random 6))
          (posWeap (random 6))
          (posLoc (random 9)))
      (setq solution (cons (nth posLoc allLocations) solution))
      (setq allLocations (remove (nth posLoc allLocations) allLocations))
      (setq solution (cons (nth posWeap allWeapons) solution))
      (setq allWeapons (remove (nth posWeap allWeapons) allWeapons))
      (setq solution (cons (nth posSus allSuspects) solution))
      (setq allSuspects (remove (nth posSus allSuspects) allSuspects))
      ;; Distribute the remaining cards
      ;; suspect cards
      ;; there is definitely a better way to do this, but for now this will do
      (setq p1hand (cons (nth (random 5) allSuspects) p1hand))
      (setq allSuspects (remove (car p1hand) allSuspects))
      (setq p2hand (cons (nth (random 4) allSuspects) p2hand))
      (setq allSuspects (remove (car p2hand) allSuspects))
      (setq p3hand (cons (nth (random 3) allSuspects) p3hand))
      (setq allSuspects (remove (car p3hand) allSuspects))
      (setq p1hand (cons (nth (random 2) allSuspects) p1hand))
      (setq allSuspects (remove (car p1hand) allSuspects))
      (setq p2hand (cons (nth 0 allSuspects) p2hand))
      (setq allSuspects (remove (car p2hand) allSuspects))
      ;; weapon cards
      (setq p3hand (cons (nth (random 5) allWeapons) p3hand))
      (setq allWeapons (remove (car p3hand) allWeapons))
      (setq p1hand (cons (nth (random 4) allWeapons) p1hand))
      (setq allWeapons (remove (car p1hand) allWeapons))
      (setq p2hand (cons (nth (random 3) allWeapons) p2hand))
      (setq allWeapons (remove (car p2hand) allWeapons))
      (setq p3hand (cons (nth (random 2) allWeapons) p3hand))
      (setq allWeapons (remove (car p3hand) allWeapons))
      (setq p1hand (cons (nth 0 allWeapons) p1hand))
      (setq allWeapons (remove (car p1hand) allWeapons))
      ;; location cards
      (setq p2hand (cons (nth (random 8) allLocations) p2hand))
      (setq allLocations (remove (car p2hand) allLocations))
      (setq p3hand (cons (nth (random 7) allLocations) p3hand))
      (setq allLocations (remove (car p3hand) allLocations))
      (setq p1hand (cons (nth (random 6) allLocations) p1hand))
      (setq allLocations (remove (car p1hand) allLocations))
      (setq p2hand (cons (nth (random 5) allLocations) p2hand))
      (setq allLocations (remove (car p2hand) allLocations))
      (setq p3hand (cons (nth (random 4) allLocations) p3hand))
      (setq allLocations (remove (car p3hand) allLocations))
      (setq p1hand (cons (nth (random 3) allLocations) p1hand))
      (setq allLocations (remove (car p1hand) allLocations))
      (setq p2hand (cons (nth (random 2) allLocations) p2hand))
      (setq allLocations (remove (car p2hand) allLocations))
      (setq p3hand (cons (nth 0 allLocations) p3hand))
      (setq allLocations (remove (car p3hand) allLocations))
      (initialize-kb)
      (print solution)
      (print p1hand)
      (print p2hand)
      (print p3hand)
      ;; call turn
      ;; (turn (random 3))
      )
  )

(defun initialize-kb ()
  ;;(fire::forget-mt ClueMt)
  ;;(fire::meld-file->kb "C:\\Users\\Anne\\EECS\\EECS 371\\clue\\clue.meld")
  ;;(fire::meld-file->kb "C:\\Users\\Anne\\EECS\\EECS 371\\clue\\clue-rules.meld")
  (fire::kb-store `(isa ,(car solution) solutionSuspect) :mt 'ClueMt)
  (fire::kb-store `(isa ,(cadr solution) solutionWeapon) :mt 'ClueMt)
  (fire::kb-store `(isa ,(caddr solution) solutionRoom) :mt 'ClueMt))

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
;;print out cards seen
;;ask for interrogation
;;update the cards seen
;;make final y/n
;;if yes, make guess
)

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