extends Node2D


var score = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	var _err = GameEvents.connect('player_scoring', self, '_on_player_scoring')


func _on_player_scoring(score):
	self.score += score
	print(self.score)
