extends Node2D

export var vidas = 3

var player_scene = preload("res://Scenes/Player.tscn") #se carga en memoria 


onready var spawn_position = $Spawn_Position
onready var score = 0
onready var timer_spawn = $Timer_Spawn
onready var HUD = $HUDLayer/HUD
onready var platform_spawner = $PlatformsSpawner


func _ready():
	HUD.set_score(score)
	HUD.set_vidas(vidas)
	
	GameEvents.connect('spawn_player', self, '_spawn_player_at_pos')


func _spawn_player_at_pos(_pos: Vector2):
	print('Spawning')
	var player = player_scene.instance()
	player.position = _pos
	add_child(player)
	player.connect("player_died", self, "_on_player_died")
	player.connect("player_scoring", self, "_on_player_scoring")


func _instance_player_spawner_platform():
	platform_spawner.next_platforms.push_front('PLAT_PLAYER_SPAWNER')


func _on_player_died():
	vidas = vidas -1
	if vidas > 0:
		timer_spawn.start()
	elif vidas <= 0:
		print("Game Over")
	
	HUD.set_vidas(vidas)


func _on_player_scoring():
	score += 1
	HUD.set_score(score)


func _on_Timer_Spawn_timeout():
	_instance_player_spawner_platform()
