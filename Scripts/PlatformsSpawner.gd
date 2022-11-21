extends Node

const SPECIAL_PLATFORM_CHANCE = 25


export var platforms = {
	'PLAT': {'scene': preload("res://Scenes/Platforms/Plataforma.tscn"), 'weight': 8.0},
	'PLAT_PINCHOS': {'scene': preload("res://Scenes/Platforms/PlatformPinchos.tscn"), 'weight': 2.0},
	#'PLAT_PLAYER': {'scene': preload("res://Scenes/PlataformPlayer.tscn"), 'weight': 0.0},
}


var next_platforms: Array = []


func _ready():
	_calcular_probabilidades()
	_asignar_intervalo()
	_spawn_platform()


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
	add_child(new_platform)


func _spawn_random_platform():
	var new_platform = get_random_platform()
	new_platform = new_platform.scene.instance()
	
	new_platform.position.x = rand_range(0, get_viewport().size.x)
	new_platform.position.y = get_viewport().size.y
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
