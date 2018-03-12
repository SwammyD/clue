;;(load "C:\\Users\\ramen\\Documents\\Github\\clue\\testFunc.LISP")

;;(defun test-ask (fact)
;;  (fire::ask-it fact
;;                :context 'EverythingPSC :response :bindings))

;; initialize the deck
(setq allSuspects '(|MrsWhite| |MrGreen| |MrsPeacock| |ProfessorPlum| |MissScarlet| |ColonelMustard|))
(setq allWeapons '(|pipe| |rope| |candlestick| |wrench| |knife| |revolver|))
(setq allLocations '(|Kitchen| |DiningRoom| |Lounge| |Hall| |Study| |Conservatory| |BilliardRoom| |Ballroom| |Library|))
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

;;Flag for end of game
(setq gameOver 0)


(defun deal-cards ()
    (dotimes (n (list-length allCards))
      (let* ((card (nth n allCards))
             (pRan (choose-random-player)))
        (cond ((= pRan 0)
               (setq p1hand (cons card p1hand))
               (setq p1seen (cons card p1seen))
               (setq p1notSeen (remove card p1notSeen)))
              ((= pRan 1)
               (setq p2hand (cons card p2hand))
               (setq p2seen (cons card p2seen))
               (setq p2notSeen (remove card p2notSeen)))
              ((= pRan 2)
               (setq p3hand (cons card p3hand))
               (setq p3seen (cons card p3seen))
               (setq p3notSeen (remove card p3notSeen)))))))

(defun choose-random-player ()
  (let* ((p1_size (list-length p1hand))
         (p2_size (list-length p2hand))
         (p3_size (list-length p3hand))
         (max_size (max p1_size p2_size p3_size))
         (nums '()))
    (if (< p1_size max_size) (setq nums (cons 0 nums)))
    (if (< p2_size max_size) (setq nums (cons 1 nums)))
    (if (< p3_size max_size) (setq nums (cons 2 nums)))
    (if nums (nth (random (list-length nums)) nums) (random 3))))

(defun start-game ()
    ;; initialize solution first
    (let ((posSus (random 6))
          (posWeap (random 6))
          (posLoc (random 9)))
      (setq solution (cons (nth posLoc allLocations) solution))
      ;;(setq allLocations (remove (nth posLoc allLocations) allLocations))
      (setq solution (cons (nth posWeap allWeapons) solution))
      ;;(setq allWeapons (remove (nth posWeap allWeapons) allWeapons))
      (setq solution (cons (nth posSus allSuspects) solution))
      ;;(setq allSuspects (remove (nth posSus allSuspects) allSuspects))
      (setq allCards (remove (car solution) allCards))
      (setq allCards (remove (cadr solution) allCards))
      (setq allCards (remove (caddr solution) allCards))

      ;; Distribute the remaining cards
      (deal-cards)

      ;; set cards seen for all players
      (setq p1seen p1hand)
      (setq p2seen p2hand)
      (setq p3seen p3hand)

      (setq gameOver 0)

      ;;Initialize the knowledge base
      (initialize-kb)

      (print solution)
      ;; call turn
      (turn 0)))

;;This function stores the solution in the kb
;;It also clears and reloads the ClueMt
(defun initialize-kb ()
  ;;Forget ClueMt
  ;;Reload clue.meld and clue-rules.meld
  (fire::kb-store `(isa ,(car solution) solutionSuspect) :mt 'ClueMt)
  (fire::kb-store `(isa ,(cadr solution) solutionWeapon) :mt 'ClueMt)
  (fire::kb-store `(isa ,(caddr solution) solutionRoom) :mt 'ClueMt))

(defun end-game ()
  (setq gameOver 1)
  (setq allSuspects '(|MrsWhite| |MrGreen| |MrsPeacock| |ProfessorPlum| |MissScarlet| |ColonelMustard|))
  (setq allWeapons '(|pipe| |rope| |candlestick| |wrench| |knife| |revolver|))
  (setq allLocations '(|Kitchen| |DiningRoom| |Lounge| |Hall| |Study| |Conservatory| |BilliardRoom| |Ballroom| |Library|))
  (setq allCards (append (append allSuspects allWeapons) allLocations))
  (setq solution '())
  (setq p1hand '())
  (setq p2hand '())
  (setq p3hand '())
  
  (setq p1seen '())
  (setq p2seen '())
  (setq p3seen '())
  
  (setq p1notSeen allCards)
  (setq p2notSeen allCards)
  (setq p3notSeen allCards)
  (format t "~%Game Over. Type (start-game) to play again!"))

(defun turn (playerNum)
  (cond ((= gameOver 0)
         (cond ((= playerNum 0) 
                (playerTurn)
                (turn 1));;do stuff for player
               ((= playerNum 1) 
                (AITurn playerNum)
                (turn 2)) ;;do stuff for AI 1
               ((= playerNum 2) 
                (AITurn playerNum)
                (turn 0))));; do stuff for AI 2
        (t (end-game))))


;;Takes optional list of choices
;;Formats the choices with indices in list
;;Asks user to choose the card
;;Returns the chosen card from the list
(defun choose-card (&optional (choices '()))
  (if (null choices) (setq choices p1notSeen))
  (setq x 0)
  (dolist (card choices)
    (format t "~% ~d: ~A" x card)
    (setq x (+ x 1)))
  (format t "~%Choose a card by inputting the number: ")
  (setq x (read))
  (nth x choices))

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
  ;;(setq x (read-from-string (format nil "(~A ~A ~A) ~A"
    ;;                          (read) (read) (read) #\linefeed)))
  ;; the variable x can be now be read.
  ;; use nth
  (setq guess '())
  (dotimes (n 3)
    (setq guess (cons (choose-card) guess)))
  (setq guess (format-guess guess))
  (print guess)

  ;;interrogate AIs
  (let ((AIres (interrogate-AI-1 guess)))
      (cond (AIres (update-cards 0 AIres)
                   (format t "~%You were shown: ~A" AIres))
          (t (setq AIres (interrogate-AI-2 guess))
             (cond (AIres (update-cards 0 AIres)
                          (format t "~%You were shown: ~A" AIres))
                  (t (format t "~%It seems nobody can refute you guess."))))))

  (format t "~%Do you wish to make this your final accusation? (Y/N) ")
  (setq r (read-char))
  (if (or (char= r #\Y) (char= r #\y))
      (query-kb guess)))

;;Formats player guess for consistency
(defun format-guess (guess)
  (let ((g '()))
    (setq g (cons (cadr guess) (caddr guess)))
    (setq g (cons (car guess) g))
    g))

;;Creates guess logic for the AIs in format and passes to make-guess
(defun formulate-guess (num)
  (let* ((choices (cond((= num 1) p2seen)
                       ((= num 2) p3seen)))
         (locs (set-difference allLocations choices))
         (weaps (set-difference allWeapons choices))
         (sus (set-difference allSuspects choices))
         (guess '()))
    (if (> (list-length locs) 1) (setq locs (nth (random (list-length locs)) locs)) (setq locs (car locs)))
    (if (> (list-length weaps) 1) (setq weaps (nth (random (list-length weaps)) weaps)) (setq weaps (car weaps)))
    (if (> (list-length sus) 1) (setq sus (nth (random (list-length sus)) sus)) (setq sus (car sus)))
    (setq guess (cons weaps locs))
    (setq guess (cons sus guess))))

(defun make-guess-player (posList)
  (let* ((guess '()))
    (setq guess (cons (nth (caddr posList) p1notSeen) guess))
    (setq guess (cons (nth (cadr posList) p1notSeen) guess))
    (setq guess (cons (nth (car posList) p1notSeen) guess))
    guess))

;;This function queries the knowledge base
;;given a guess in the form of (suspect weapon room)
(defun query-kb (guess)
  (setq q (fire::ask-it `(makeFinalGuess ,(car guess) ,(cadr guess) ,(cddr guess)) :context 'ClueMt))
  (if q (format t "~%You are correct.)") (format t "~%That wasn't correct. You lose."))
  (format t "~%The solution was ~A " solution)
  (end-game))

;;Function updates the cards seen 
;;It accepts the player number and the card data to add
(defun update-cards (num shown)
  (cond ((= num 0) (setq p1seen (cons shown p1seen)) (setq p1notSeen (remove shown p1notSeen)))
        ((= num 1) (setq p2seen (cons shown p2seen)) (setq p2notSeen (remove shown p2notSeen)))
        ((= num 2) (setq p3seen (cons shown p3seen)) (setq p3notSeen (remove shown p3notSeen)))))

;;Formulates a guess based on the turn num
;;interrogates player and AI
;;makes the final guess if no evidence, otherwise updates cards
(defun AITurn (num)
  (let ((guess (formulate-guess num))
        (shown nil))
    (format t "~%Player ~d is guessing: ~A" (+ num 1) guess)
    (cond((= num 1)
          (setq shown (interrogate-AI-2 guess))
          (if (null shown) (setq shown (interrogate-player guess))))
         (t 
          (setq shown (interrogate-player guess))
          (if (null shown) (setq shown (interrogate-AI-1 guess)))))
    (if (null shown) (query-kb guess) (update-cards num shown))));;If shown is nil, then make a final guess. If not, update cards

;;Scans AI 1's cards and returns the first match to the guess
(defun interrogate-AI-1 (guess)
  (let* ((sus (find (car guess) p2hand))
         (weap (find (cadr guess) p2hand))
         (loc (find (cddr guess) p2hand))
         (opts '()))
    (if sus (setq opts (cons sus opts)))
    (if weap (setq opts (cons weap opts)))
    (if loc (setq opts (cons loc opts)))
    (if opts (nth (random (list-length opts)) opts) nil))) ;;no evidence found

;;Scans AI 2's cards and returns the first match to the guess
(defun interrogate-AI-2 (guess)
  (let* ((sus (find (car guess) p3hand))
         (weap (find (cadr guess) p3hand))
         (loc (find (cddr guess) p3hand))
         (opts '()))
    (if sus (setq opts (cons sus opts)))
    (if weap (setq opts (cons weap opts)))
    (if loc (setq opts (cons loc opts)))
    (if opts (nth (random (list-length opts)) opts) nil)))

;;Scans player's cards for items that match
;;If match, calls choose-card with matches
;;returns nil if no match, or chosen card otherwise
(defun interrogate-player (guess)
  (let* ((sus (find (car guess) p1hand))
         (weap (find (cadr guess) p1hand))
         (loc (find (cddr guess) p1hand))
         (opts '())
         (card))
    (if sus (setq opts (cons sus opts)))
    (if weap (setq opts (cons weap opts)))
    (if loc (setq opts (cons loc opts)))
    (cond (opts 
           (format t "~%You have cards that match the guess. Choose a card to show: ")
           (setq card (choose-card opts)))
          (t (format t "~%You have no cards that match the guess!")))
    card))


