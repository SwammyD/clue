;;(load "C:\\Users\\Anne\\Documents\\EECS\\EECS 371\\testFunc.LISP")

(defun test-ask (fact)
  (fire::ask-it fact
                :context 'EverythingPSC :response :bindings))

(defun start-game
;;Initialize solution first
;;Distribute the remaining cards
;;call turn
)

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

(defun playerTurn
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

)

(defun interrogate-AI-2

)

(defun interrogate-player

)