extends Node

const SPECIAL_PLATFORM_CHANCE = 25

export(Array) var platforms


func _ready():
	_spawn_platforms()


func _spawn_platforms():
	randomize()
	var index
	var new_platform = platforms[0]
	
	if rand_range(0,100) > 100 - SPECIAL_PLATFORM_CHANCE:
		index = int(rand_range(1, platforms.size()-1))
		new_platform = platforms[index]
		
	new_platform = new_platform.instance()
	
	new_platform.position.x = rand_range(0, get_viewport().size.x)
	new_platform.position.y = get_viewport().size.y
	add_child(new_platform)


func _on_Timer_timeout():
	_spawn_platforms()
	
