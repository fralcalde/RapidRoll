class_name PickedBox, "res://Imagenes/HurtBox.svg"
extends Area2D


func _init():
	collision_mask = 8
	monitorable = false
	collision_layer = 0
 

func _ready():
	var _err_area_entered = connect("area_entered", self, "_on_area_entered")
	
	if _err_area_entered != OK:
		printerr("Connecting signal: ", _err_area_entered)


func _on_area_entered(_pickbox: PickBox):
	if owner.has_method("picked_up"):
		owner.picked_up()

