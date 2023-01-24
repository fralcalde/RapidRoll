extends Label


var random_hints = [
	"Getting stuck between the wall and a platform is not a bug, it's a feature.",
	"Yes, clones score points.",
	"Ultri was a ball we used to play with when we were kids.",
	"Pablo.",
	"Huh, it's hard to come up with these small sentences...",
	"Yes, a spawning clone will save you from losing that last heart!",
	"Life sometimes is unfair, this game is no different.",
	"Did you know? You could THEORETICALLY play a run forever...",
	"¯\\_(*_*)_/¯",
	"It's easier on a keyboard...",
	"This game was made with a single objective in mind. Learning to make games, AND FINISHING A GODDAMN PROJECT FOR ONCE",
	
]


func _ready():
	randomize()
	text = get_random_hint()


func get_random_hint():
	var random_index = randi() % random_hints.size()
	return random_hints[random_index]
