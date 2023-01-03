extends Node2D

var score_value = 0
const INITIAL_SCORE = 100
const SCORE_INCREASE_FACTOR = 25


func _ready():
	calculate_score()


func picked_up():
	GameEvents.coin_picked_up(score_value)
	queue_free()


func calculate_score():
	score_value = INITIAL_SCORE + SCORE_INCREASE_FACTOR * GameStats.level
