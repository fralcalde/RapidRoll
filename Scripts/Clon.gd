extends Node2D


func picked_up():
	GameEvents.clon_picked_up()
	queue_free()

