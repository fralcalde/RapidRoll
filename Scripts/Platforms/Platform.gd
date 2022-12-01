class_name Platform
extends KinematicBody2D


export var speed = 150


func _physics_process(delta):
	position.y -= speed * delta
	fuera_de_pantalla()


func fuera_de_pantalla():
	if position.y < 0:
		queue_free()
