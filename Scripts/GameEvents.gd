class_name GameEvents
extends Object

signal spawn_player(position)
signal player_died


func spawn_player(position: Vector2):
	emit_signal('spawn_player', position)


func player_died():
	emit_signal('player_died')
