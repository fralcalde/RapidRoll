extends Control


onready var vidas = 3 setget set_vidas, get_vidas


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func set_vidas(new_val):
	vidas = new_val
	$HBoxContainer/Vidas.text = str(new_val)


func get_vidas():
	return vidas
