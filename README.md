# clue
it's clue.

Upon initialization with a startGame function:
initialize all cards
randomly select a card from each deck (suspect, weapon, location), and put those in the "sleeve"
(really, we are just removing them from the main deck and putting them in a separate "solution" deck)

Then, randomly deal out the remaining card. Maybe we can store each as a key value pair, then randomly select to deal out to a player.

Now we enter the game loop:
Starting with player one (user):
  Make a guess based on the cards we have (cards we have / we know other players have are printed to console at the start of each turn)
  Player 2 (AI 1) will then show a card to disprove the guess, if he holds one
  If player 2 cannot disprove, then we go to player 3, who is also asked
  If player 3 cannot disprove, that becomes your final accusation and you win!
  If another player is able to disprove your guess, your turn ends and the card you were shown is added to the list of cards you have / know others have
  Then we move on to player 2, and restart the loop. Player 2 also makes guesses based on what it knows...
  The game ends when a final accusation is made, or a guess cannot be disproven.
