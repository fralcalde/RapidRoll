extends Node

const SPECIAL_PLATFORM_CHANCE = 25

export(Array) var platforms = [
	{'scene': preload("res://Scenes/Plataforma.tscn"), 'weight': 8.0, 'interval': 0.0},
	{'scene': preload("res://Scenes/Plataforma_Con_Pinchos.tscn"), 'weight': 2.0, 'interval': 0.0},
]


func _ready():
	_calcular_probabilidades()
	_asignar_intervalo()
	_spawn_platforms()


func _spawn_platforms():
	var new_platform = get_random_platform()
	new_platform = new_platform.scene.instance()
	
	new_platform.position.x = rand_range(0, get_viewport().size.x)
	new_platform.position.y = get_viewport().size.y
	add_child(new_platform)


func _on_Timer_timeout():
	_spawn_platforms()


func _calcular_probabilidades():
	var total_weight = 0.0
	
	for el in platforms:
		total_weight = total_weight + el.weight
	
	
	for el in platforms:
		var chances = el.weight / total_weight
		el.weight = chances


func _asignar_intervalo():
	var sum = 0.0
	
	for el in platforms:
		el.interval = sum
		sum = sum + el.weight


func get_random_platform():
	randomize()
	var r = randf()
	
	var i = 0
	while i < platforms.size() and r > platforms[i].interval:
		i = i + 1
	
	return platforms[i - 1]
