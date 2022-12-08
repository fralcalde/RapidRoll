class_name Game
extends Node2D

export var vidas = 3 setget set_vidas
var alive_players = 0
var score = 0 setget set_score
var level = 0

var player_scene = preload("res://Scenes/RPlayer.tscn") #se carga en memoria 

onready var spawn_position = $Spawn_Position
onready var timer_spawn = $Timer_Spawn
onready var HUD = $HUDLayer/HUD
onready var platform_spawner = $PlatformsSpawner


# Godot llama _init() y _enter_tree() desde la raiz del arbol hacia abajo!!
func _init():
	var _err_spawn_player = GameEvents.connect('spawn_player', self, '_spawn_player_at_pos')
	var _err_player_spawning = GameEvents.connect('player_spawning', self, '_on_player_spawning')
	var _err_vida = GameEvents.connect("life_picked_up", self, 'player_picked_life')
	var _err_clon = GameEvents.connect("clon_picked_up", self, 'player_picked_clon')
	
	if _err_spawn_player != OK:
		printerr("Connecting signal: ", _err_spawn_player)
	if _err_player_spawning != OK:
		printerr("Connecting signal: ", _err_player_spawning)
	if _err_vida != OK:
		printerr("Connecting signal: ", _err_vida)


# Godot llama _ready() desde las hojas del arbol hacia arriba!!
func _ready():
	randomize()
	HUD.set_score(score)
	HUD.set_vidas(vidas)


func _spawn_player_at_pos(_pos: Vector2):
	var player = player_scene.instance()
	player.position = _pos
	player.level = level
	add_child(player)
	player.connect("player_died", self, "_on_player_died")
	player.connect("player_scoring", self, "_on_player_scoring")


func _create_player_spawner_platform():
	platform_spawner.next_platforms.push_front('PLAT_PLAYER_SPAWNER')


func _on_player_died():
	alive_players = alive_players - 1
	if alive_players <= 0:
		self.vidas = vidas - 1


func _on_player_scoring():
	# self.score porque si no, no se usa la funcion de setget
	self.score += 1


func _on_player_spawning():
	alive_players = alive_players + 1


func _on_Timer_Spawn_timeout():
	_create_player_spawner_platform()


func player_picked_life():
	# self.vidas porque si no, no se usa la funcion de setget
	self.vidas += 1


func player_picked_clon():
	_create_player_spawner_platform()


func set_score(new_score):
	score = new_score
	calculate_current_level()
	HUD.set_score(new_score)


func calculate_current_level():
	var current_level = level
	level = score / 250
	
	if current_level != level:
		GameEvents.level_up(level)


func set_vidas(new_vidas):
	vidas = new_vidas
	HUD.set_vidas(vidas)
	
	if vidas > 0:
		timer_spawn.start()
	elif vidas <= 0:
		print("Game Over")
