extends Node2D


func picked_up():
	GameEvents.life_picked_up()
	queue_free()

