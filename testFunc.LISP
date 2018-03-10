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
               (setq p1notSeen (remove card p1notSeen)))
              ((= pRan 1)
               (setq p2hand (cons card p2hand))
               (setq p2notSeen (remove card p2notSeen)))
              ((= pRan 2)
               (setq p3hand (cons card p3hand))
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
      (setq allLocations (remove (nth posLoc allLocations) allLocations))
      (setq solution (cons (nth posWeap allWeapons) solution))
      (setq allWeapons (remove (nth posWeap allWeapons) allWeapons))
      (setq solution (cons (nth posSus allSuspects) solution))
      (setq allSuspects (remove (nth posSus allSuspects) allSuspects))
      (setq allCards (remove (car solution) allCards))
      (setq allCards (remove (cadr solution) allCards))
      (setq allCards (remove (caddr solution) allCards))

      ;; Distribute the remaining cards
      (deal-cards)

      ;; set cards seen for all players
      (setq p1seen p1hand)
      (setq p2seen p2hand)
      (setq p3seen p3hand)

      ;;Initialize the knowledge base
      (initialize-kb)

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
  (setq p3notSeen allCards))

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
  (setq guess (make-guess-player x))

  ;;interrogate AIs
  (let* (AIres (interrogate-AI-1 guess))
    (cond (AIres (update-cards 0 AIres))
          (t (setq AIres (interrogate-AI-2 guess))
             (if AIres (update-cards 0 AIres)))))

  ;;make final y/n
  ;;if yes, make guess
  )

;;Creates guess logic for the AIs in format and passes to make-guess
(defun formulate-guess (num)
)

(defun make-guess-player (posList)
  (let* (guess '())
    (setq guess (cons (nth (caddr posList) p1notSeen) guess))
    (setq guess (cons (nth (cadr posList) p1notSeen) guess))
    (setq guess (cons (nth (car posList) p1notSeen) guess))
    guess))

;;This function queries the knowledge base
;;given a guess in the form of (suspect weapon room)
(defun query-kb (guess)
  (fire::query `(makeFinalGuess ,(car guess) ,(cadr guess) ,(caddr guess)) :context 'ClueMt))

;;Function updates the cards seen 
;;It accepts the player number and the card data to add
(defun update-cards (num shown)
  (cond ((= num 0) (setq p1seen (cons shown p1seen)) (setq p1notSeen (remove shown p1notSeen)))
        ((= num 1) (setq p2seen (cons shown p2seen)) (setq p2notSeen (remove shown p2notSeen)))
        ((= num 2) (setq p3seen (cons shown p3seen)) (setq p3notSeen (remove shown p3notSeen)))))

(defun AITurn (num)
  (let ((guess (formulate-guess num))
        (shown nil))
    (cond((= num 1)
          (setq shown (interrogate-AI-2 guess))
          (if (null shown) (setq shown (interrogate-player guess))))
         (t 
          (setq shown (interrogate-player guess))
          (if (null shown) (setq shown (interrogate-AI-1 guess)))))
    (if shown (query-kb guess) (update-cards num shown))));;If shown is nil, then make a final guess. If not, update cards

;;Scans AI 1's cards and returns the first match to the guess
(defun interrogate-AI-1 (guess)
  (let* ((sus (find (car guess) p2hand))
         (weap (find (cadr guess) p2hand))
         (loc (find (caddr guess) p2hand))
         (opts '()))
    (if sus (setq opts (cons sus opts)))
    (if weap (setq opts (cons weap opts)))
    (if loc (setq opts (cons loc opts)))
    (if opts (nth (random (list-length opts)) opts) nil))) ;;no evidence found

;;Scans AI 2's cards and returns the first match to the guess
(defun interrogate-AI-2 (guess)
  (let* ((sus (find (car guess) p3hand))
         (weap (find (cadr guess) p3hand))
         (loc (find (caddr guess) p3hand))
         (opts '()))
    (if sus (setq opts (cons sus opts)))
    (if weap (setq opts (cons weap opts)))
    (if loc (setq opts (cons loc opts)))
    (if opts (nth (random (list-length opts)) opts) nil)))

(defun interrogate-player (guess)
;;Scan player's cards, searching for match to guess

;;If matches, allow player to choose what to show
;;Return choice or nil
)

