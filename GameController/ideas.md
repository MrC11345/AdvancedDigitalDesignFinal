need a state for:
	level 1 game
	level 2 game
	level 3 game
	game over
	game about to start

level 1 2 3 game
	these will all function similarly with added dificulty
	level 2 will add spikes
	level 3 will add more spikes

game over
	will display score 

game about to start
	will wait for input to decide what level to play

level 1 game
	get output from rng to display where the mole will be
	once mole position determined start the timer and display it
	if player presses the correct button before timer is over add point
	otherwise go onto new mole

going to control the level in a seperate module
going to keep track of score in a seperate module as well


displayDecoder
	First 3 bits are which display
	Next 2 bits are number, mole, spike, or nothing
	final 3 bits are the number if there is one otherwise just 0
