class_name Platform
extends StaticBody2D


export var speed = 300


func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	position.y -= speed * delta
	fuera_de_pantalla()

func fuera_de_pantalla():
	if position.y < 50:
		queue_free()
