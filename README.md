I have used below ruby version.
ruby 2.5.8

# Install gems(library)
Run below command from root directory of the project.
bundle install

# How to execute - run below commands from root directory of the project.
Option1: ruby lib/battleship_game.rb

Option2: 
game = BattleshipGame.new
you have to give input file path
game.initialize_game(file_path)
game.play

I have added input and output file in root directory of the project. Once you execute the code you can check output file for the final output. You can change input to input file to test different test cases.

Note: I don't have linux machine so i have completed the assignment in Mac.