class_name HurtBox, "res://Imagenes/HurtBox.svg"
extends Area2D

func _init():
	collision_mask = 2
	monitorable = false
	
 

func _ready():
	connect("area_entered", self, "_on_area_entered")
	
	
	
	pass
func _on_area_entered(hitbox: HitBox):
	if owner.has_method("take_damage"):
		owner.take_damage()
	
	

