# Clue

Instructions for Running Game
In order for the game to run properly, there are a few steps to be followed. First, open clue-game.LISP. At the top of the file is a function called initialize-kb. In it, there are two Fire functions that load the meld files into the knowledge base. These MUST be set to the correct paths for the game to work as it should. To actually run the game, first open Companion and start a session with the InteractionManager. When the session manager window is ready, load the file clue-game.LISP. When the file is loaded, call (start-game). This will launch you into the turn-based murder mystery!

