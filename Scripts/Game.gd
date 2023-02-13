class_name Game
extends Node2D

const INITIAL_VIDAS = 3
export var vidas = 3 setget set_vidas
var alive_players = 0

var player_scene = preload("res://Scenes/RPlayer.tscn") #se carga en memoria 
var main_menu_scene = preload("res://Scenes/MainMenu.tscn")
var end_game_scene = preload("res://Scenes/EndGameScreen.tscn")

onready var spawn_position = $Spawn_Position
onready var timer_spawn = $Timer_Spawn
onready var HUD = $HUDLayer/HUD
onready var platform_spawner = $PlatformsSpawner


# Godot llama _init() y _enter_tree() desde la raiz del arbol hacia abajo!!
func _init():
	var _err = GameEvents.connect('spawn_player', self, '_spawn_player_at_pos')
	_err = GameEvents.connect('player_spawning', self, '_on_player_spawning')
	_err = GameEvents.connect("life_picked_up", self, 'player_picked_life')
	_err = GameEvents.connect("clon_picked_up", self, 'player_picked_clon')
	_err = GameEvents.connect("start_game", self, 'start_game')
	_err = GameEvents.connect("player_died", self, "_on_player_died")
	_err = GameEvents.connect("spawn_main_menu", self, "spawn_main_menu")
	_err = MobileAds.connect("interstitial_loaded", self, "_on_interstitial_loaded")
	_err = MobileAds.connect("interstitial_failed_to_load", self, "_on_interstitial_load_failed")
	MobileAds.load_interstitial("standard")


# Godot llama _ready() desde las hojas del arbol hacia arriba!!
func _ready():
	randomize()
	HUD.set_vidas(vidas)
	vidas = INITIAL_VIDAS
	platform_spawner.set_plat_weight('PLAT_PLAYER_SPAWNER', 0.0)
	platform_spawner.start_timer()


func start_game():
	vidas = INITIAL_VIDAS
	HUD.set_vidas(vidas)
	platform_spawner.set_plat_weight('PLAT_PLAYER_SPAWNER', 0.1)
	platform_spawner.start_timer()
	_create_player_spawner_platform()
	MobileAds.load_interstitial("standard")


func _spawn_player_at_pos(_pos: Vector2):
	var player = player_scene.instance()
	player.position = _pos
	add_child(player)


func _create_player_spawner_platform():
	platform_spawner.next_platforms.push_front('PLAT_PLAYER_SPAWNER')


func _on_player_died():
	alive_players = alive_players - 1
	if alive_players <= 0:
		self.vidas = vidas - 1


func _on_player_spawning():
	alive_players = alive_players + 1


func _on_Timer_Spawn_timeout():
	_create_player_spawner_platform()


func player_picked_life():
	# self.vidas porque si no, no se usa la funcion de setget
	self.vidas += 1


func player_picked_clon():
	_create_player_spawner_platform()


func set_vidas(new_vidas):
	if new_vidas <= 0:
		game_over()
	elif new_vidas < vidas:
		timer_spawn.start()
	
	vidas = new_vidas
	HUD.set_vidas(vidas)


func game_over():
	print("Game Over")
	platform_spawner.set_plat_weight('PLAT_PLAYER_SPAWNER', 0.0)
	platform_spawner.stop_timer()
	var new_end_screen = end_game_scene.instance()
	get_parent().add_child(new_end_screen)


func spawn_main_menu():
	var new_main_menu = main_menu_scene.instance()
	get_parent().add_child(new_main_menu)


func _on_interstitial_loaded() -> void:
	print("Ready to show interstitial")

func _on_insterstitial_load_failed() -> void:
	print("FAIL!!!!!!!!!!!!11 muthafuckin mobile ads are so shiiiiiiiiiiiiit!") 
