#class_name GameEvents
extends Node


signal start_game
signal spawn_player(position)
signal player_died
signal player_spawning
signal player_scoring(score)
signal life_picked_up
signal clon_picked_up
signal level_up
signal coin_picked_up


func start_game():
	emit_signal('start_game')


func spawn_player(position: Vector2):
	emit_signal('spawn_player', position)


func player_died():
	emit_signal('player_died')


func player_spawning():
	emit_signal('player_spawning')


func player_scoring(score: int):
	emit_signal('player_scoring', score)


func life_picked_up():
	emit_signal("life_picked_up")

func clon_picked_up():
	emit_signal("clon_picked_up")


func level_up():
	print('Level Up! ', GameStats.level, ' Next level: ', GameStats.next_level)
	emit_signal('level_up')


func coin_picked_up2(score_value: int):
	emit_signal('coin_picked_up')
	emit_signal('player_scoring', score_value)
