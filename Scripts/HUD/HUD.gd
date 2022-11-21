extends Control

onready var vidas_counter = $LivesCounter
onready var score_counter = $ScoreCounter


func set_vidas(_vidas):
	vidas_counter.vidas = _vidas


func set_score(_score):
	score_counter.score = _score

