extends Label


var random_hints = [
	"Getting stuck between the wall and a platform is not a bug, it's a feature.",
	"Yes, clones score you more points.",
	"Ultri was a football we used to play with when we were kids.",
	"Pablo.",
	"Huh, it's hard to come up with these small sentences...",
]


func _ready():
	randomize()
	text = get_random_hint()


func get_random_hint():
	var random_index = randi() % random_hints.size()
	return random_hints[random_index]
