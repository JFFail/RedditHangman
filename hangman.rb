#Hangman game for Reddit's Daily Programmer.
#http://www.reddit.com/r/dailyprogrammer/comments/2mlfxp/20141117_challenge_189_easy_hangman/

#Function to pick the word.
def pick_word(diff, words)
	need_word = true
	
	while need_word
		word = words[rand(words.length - 1)]
		
		#Check if it matches the difficulty.
		if diff == 3
			if word.length <= 5
				need_word = false
			end
		elsif diff == 2
			if word.length > 5 && word.length <=7
				need_word = false
			end
		else
			if word.length > 7
				need_word = false
			end
		end
	end
	
	#Return the word.
	return word
end

#Function to print the word and the blank spaces.
def print_word(word_list, known)
	known.inspect
	#Print the known letters.
	word_list.each do |x|
		if known.index(x) != nil
			print "#{x} "
		else
			print "  "
		end
	end
	
	print "\n"
	
	print "_ " * (word_list.length)
	print "\n"
end

#Function to check if the guessed letter is in the word.
def check_letter(word_list, guess)
	if word_list.index(guess) != nil
		return true
	else
		return false
	end
end

#Function to check if you've guessed the complete word.
def check_success(word_list, known_list)
	complete = true
	
	word_list.each do |x|
		if known_list.index(x) == nil
			complete = false
		end
	end
	
	return complete
end

#Parse the command line paramter for the difficulty or default to Normal.
if ARGV.length > 0
	difficulty = ARGV[0].downcase
else
	difficulty = "normal"
end

#Get that to a number.
if difficulty == "easy"
	diff_num = 1
elsif difficulty == "hard"
	diff_num = 3
else
	diff_num = 2
end

#Get the contents of the file into an array.
word_list = Array.new
File.open("words.txt") do |f|
	f.each_line do |line|
		word_list.push(line.chomp)
	end
end

#Call a function to get the word of glory.
the_word = pick_word(diff_num, word_list)

#After 6 wrong guesses, the player loses.
bad_guesses = 0
known_letters = Array.new
guessed_letters = Array.new
word_array = the_word.split(//)

#Print the word an initial time.
print_word(word_array, known_letters)

#While loop that the main guessing code runs in.
while bad_guesses < 6
	#Get a guess from the user.
	puts "Enter a letter to guess!"
	print "> "
	user_guess = $stdin.gets.chomp
	
	#Make sure it was only one letter or dock them!
	if user_guess.length > 1
		puts "Your guess of #{user_guess} is more than one letter..."
		bad_guesses = bad_guesses + 1
	else
		#Check if the letter has already been guessed.
		if guessed_letters.index(user_guess) != nil
			puts "You already guessed #{user_guess}..."
			bad_guesses = bad_guesses + 1
		else
			#Check to see if the letter actually exists.
			letter_correct = check_letter(word_array, user_guess)
			
			#Report accordingly to the user.
			if letter_correct
				puts "Success! #{user_guess} is in the word!"
				known_letters.push(user_guess)
			else
				puts "Sorry! #{user_guess} isn't in the word..."
				bad_guesses = bad_guesses + 1
			end
		end
	end
	
	#Add the guess to the guessed letter array.
	guessed_letters.push(user_guess)
	puts "You've guessed: #{guessed_letters.inspect}"
	
	#Reprint the word.
	print_word(word_array, known_letters)
	
	#Check if the user won.
	won = check_success(word_array, known_letters)
	break if won
	
	#Print the remaining number of guesses after the break so it doesn't show when you win.
	puts "You have #{6 - bad_guesses} remaining!"
end

#Print a message if the user won or lost.
if won
	puts "Congratulations that you won!"
else
	puts "Sorry that you lost..."
	puts "The word was: #{the_word}"
end
