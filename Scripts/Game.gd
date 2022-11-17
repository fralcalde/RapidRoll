extends Node2D

export var vidas = 3

var player_scene = preload("res://Scenes/Player.tscn") #se carga en memoria 


onready var spawn_position = $Spawn_Position
onready var score = 0
onready var timer_score = $Timer_Score
onready var timer_spawn = $Timer_Spawn
onready var HUD = $HUDLayer/HUD


func _ready():
	HUD.set_score(score)
	HUD.set_vidas(vidas)
	spawn_position.position.x = get_viewport().size.x / 2
	spawn_position.position.y = 130
	_spawn_player()


func _spawn_player():
	var player = player_scene.instance()
	player.position = spawn_position.position
	add_child(player)
	player.connect("player_died", self, "_on_player_died")


func _on_player_died():
	vidas = vidas -1
	if vidas > 0:
		timer_spawn.start()
		timer_score.stop()
	elif vidas <= 0:
		timer_score.stop()
		print("Game Over")
	
	HUD.set_vidas(vidas)


func _on_Timer_timeout():
	score += 1
	HUD.set_score(score)


func _on_Timer_Spawn_timeout():
	_spawn_player()
	timer_score.start()

