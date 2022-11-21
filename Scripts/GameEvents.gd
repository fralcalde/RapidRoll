#class_name GameEvents
extends Node

signal spawn_player(position)
signal player_died
signal player_spawning


func spawn_player(position: Vector2):
	emit_signal('spawn_player', position)


func player_died():
	emit_signal('player_died')


func player_spawning():
	emit_signal('player_spawning')
