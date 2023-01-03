extends Control

onready var vidas_counter = $LivesCounter
onready var score_counter = $ScoreCounter


func _ready():
	var _err = GameEvents.connect("player_scoring", self, 'update_score')
	_err = GameEvents.connect("coin_picked_up", self, 'update_score')

func set_vidas(_vidas):
	vidas_counter.vidas = _vidas


func set_score(_score):
	score_counter.score = _score


func update_score(_score):
	set_score(GameStats.score)
