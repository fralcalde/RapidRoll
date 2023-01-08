extends Node


const INITIAL_LEVEL = 0
const INITIAL_SCORE = 0
const INITIAL_LEVEL_THRESHOLD = 1000

var level
var score setget set_score
var level_threshold

# Called when the node enters the scene tree for the first time.
func _ready():
	var _err = GameEvents.connect('player_scoring', self, '_on_player_scoring')
	_err = GameEvents.connect('coin_picked_up', self, '_on_coin_picked_up')
	initialize()


func initialize():
	level_threshold = INITIAL_LEVEL_THRESHOLD
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
	var current_level = level
	level = score / level_threshold
	
	if current_level != level:
		GameEvents.level_up()
