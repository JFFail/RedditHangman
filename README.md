RedditHangman
=============

Hangman game for the Reddit Daily Programmer challenge. The challenge is [here](http://www.reddit.com/r/dailyprogrammer/comments/2mlfxp/20141117_challenge_189_easy_hangman/). The code can be run by specifying "easy", "normal", or "hard" as a parameter to the script. If you pass nothing or you pass something *other* than those values, the game will default to the "normal" difficulty.

The included word list isn't nearly as robust as what is provided on Reddit; I didn't want to bother uploading a 6 MB text file. The legit word list for the challenge is available [here](http://www.joereynoldsaudio.com/wordlist.txt).

As is typical for hangman, you lose the game after guessing incorrectly 6 times. Entering multiple letters, a letter you already guessed, or nothing will count as an incorrect guess. Likewise, entering characters that would not be in a word (numbers, symbols, etc.) will also count as an incorrect guess.
