extends Control

onready var score = 1 setget set_score, get_score


func set_score(new_val):
	score = new_val
	$Score.text = str(new_val)


func get_score():
	return score
