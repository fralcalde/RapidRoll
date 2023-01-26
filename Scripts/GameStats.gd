extends Node


const INITIAL_LEVEL = 0
const INITIAL_SCORE = 0
const INITIAL_NEXT_LEVEL = 1000
const LEVEL_PROG_FACTOR = 100

var level
var next_level
var score setget set_score


# Called when the node enters the scene tree for the first time.
func _ready():
	var _err = GameEvents.connect('player_scoring', self, '_on_player_scoring')
	#_err = GameEvents.connect('coin_picked_up', self, '_on_coin_picked_up')
	initialize()


func initialize():
	next_level = INITIAL_NEXT_LEVEL
	level = 0
	self.score = INITIAL_SCORE


func set_score(new_score):
	score = new_score
	update_current_level()


func _on_player_scoring(_score: int):
	# self.score porque si no, no se usa la funcion de setget
	self.score += _score


func _on_coin_picked_up(score_value):
	self.score += score_value


func update_current_level():
	if next_level - 1 < score:
		level_up()


func level_up():
	level += 1
	next_level = INITIAL_NEXT_LEVEL + next_level + level * LEVEL_PROG_FACTOR
	GameEvents.level_up()
