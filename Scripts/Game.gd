class_name Game
extends Node2D

export var vidas = 3

var player_scene = preload("res://Scenes/RPlayer.tscn") #se carga en memoria 

onready var spawn_position = $Spawn_Position
onready var score = 0
onready var timer_spawn = $Timer_Spawn
onready var HUD = $HUDLayer/HUD
onready var platform_spawner = $PlatformsSpawner
var alive_players = 0

# Godot llama _init() y _enter_tree() desde la raiz del arbol hacia abajo!!
func _init():
	var _err_spawn_player = GameEvents.connect('spawn_player', self, '_spawn_player_at_pos')
	var _err_player_spawning = GameEvents.connect('player_spawning', self, '_on_player_spawning')
	
	if _err_spawn_player != OK:
		printerr("Connecting signal: ", _err_spawn_player)
	if _err_player_spawning != OK:
		printerr("Connecting signal: ", _err_player_spawning)


# Godot llama _ready() desde las hojas del arbol hacia arriba!!
func _ready():
	HUD.set_score(score)
	HUD.set_vidas(vidas)


func _spawn_player_at_pos(_pos: Vector2):
	var player = player_scene.instance()
	player.position = _pos
	add_child(player)
	player.connect("player_died", self, "_on_player_died")
	player.connect("player_scoring", self, "_on_player_scoring")


func _instance_player_spawner_platform():
	platform_spawner.next_platforms.push_front('PLAT_PLAYER_SPAWNER')


func _on_player_died():
	alive_players = alive_players - 1
	if alive_players <= 0:
		vidas = vidas - 1
		if vidas > 0:
			timer_spawn.start()
		elif vidas <= 0:
			print("Game Over")
	
	print('dying, alive: ', alive_players)
	HUD.set_vidas(vidas)


func _on_player_scoring():
	score += 1
	HUD.set_score(score)


func _on_player_spawning():
	alive_players = alive_players + 1
	print('spawning, alive: ', alive_players)


func _on_Timer_Spawn_timeout():
	_instance_player_spawner_platform()
