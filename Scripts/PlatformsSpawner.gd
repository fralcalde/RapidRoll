extends Node

export var platforms = {
	'PLAT': {'scene': preload("res://Scenes/Platforms/Platform.tscn"), 'weight': 8.5},
	'PLAT_PINCHOS': {'scene': preload("res://Scenes/Platforms/PlatformPinchos.tscn"), 'weight': 1.5},
	'PLAT_PLAYER_SPAWNER': {'scene': preload("res://Scenes/Platforms/PlataformPlayerSpawner.tscn"), 'weight': 0.1},
	'PLAT_VIDA': {'scene': preload("res://Scenes/Platforms/PlatformVida.tscn"), 'weight': 0.5},
	'PLAT_CLON': {'scene': preload("res://Scenes/Platforms/PlatformClon.tscn"), 'weight': 0.5},
	'PLAT_DORADA': {'scene': preload("res://Scenes/Platforms/PlatformDorada.tscn"), 'weight': 1.0},
	'PLAT_MONEDITA': {'scene': preload("res://Scenes/Platforms/PlataformMonedita.tscn"), 'weight': 3.0},
}


var next_platforms: Array = ['PLAT_PLAYER_SPAWNER']
var level = 0
const INITIAL_PLAT_FREQ = 1.4
const PLAT_FREQ_FACTOR = 0.02
var platform_freq = INITIAL_PLAT_FREQ
onready var timer = $Timer


func _ready():
	var _err = GameEvents.connect('level_up', self, '_on_level_up')
	
	set_freq()
	timer.start()
	_calcular_probabilidades()
	_asignar_intervalo()
#	_spawn_platform()


func _spawn_platform():
	if next_platforms.size() > 0:
		_spawn_next_platform()
	else:
		_spawn_random_platform()


func _spawn_next_platform():
	var new_platform = platforms[next_platforms.pop_front()]
	new_platform = new_platform.scene.instance()
	
	new_platform.position.x = rand_range(0, get_viewport().size.x)
	new_platform.position.y = get_viewport().size.y
	new_platform.level = level
	add_child(new_platform)


func _spawn_random_platform():
	var new_platform = get_random_platform()
	new_platform = new_platform.scene.instance()
	
	new_platform.position.x = rand_range(0, get_viewport().size.x)
	new_platform.position.y = get_viewport().size.y
	new_platform.level = level
	add_child(new_platform)


func _on_Timer_timeout():
	_spawn_platform()


func _calcular_probabilidades():
	var total_weight = 0.0
	
	for el in platforms:
		total_weight = total_weight + platforms[el].weight
	
	
	for el in platforms:
		var chances = platforms[el].weight / total_weight
		platforms[el].weight = chances


func _asignar_intervalo():
	var sum = 0.0
	
	for el in platforms:
		platforms[el].interval = sum
		sum = sum + platforms[el].weight


func get_random_platform():
	randomize()
	var r = randf()
	
	var i = 0
	while i < platforms.size() and r > platforms[platforms.keys()[i]].interval:
		i = i + 1
	
	return platforms[platforms.keys()[i - 1]]


func _on_level_up(new_level):
	level = new_level
	set_freq()


func set_freq():
	platform_freq = INITIAL_PLAT_FREQ - PLAT_FREQ_FACTOR * level
	timer.wait_time = platform_freq
	print('New freq: ', platform_freq)

