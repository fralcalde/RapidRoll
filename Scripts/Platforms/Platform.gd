class_name Platform
extends KinematicBody2D


export var speed = 0
var level = 0
const INITIAL_SPEED = 100
const SPEED_INCREASE_FACTOR = 10


func _ready():
	var _err = GameEvents.connect('level_up', self, "_on_level_up")
	
	# Set initial speed
	speed = INITIAL_SPEED + SPEED_INCREASE_FACTOR * level


func _on_level_up(new_level):
	level = new_level
	calculate_speed()


func calculate_speed():
	speed = INITIAL_SPEED + SPEED_INCREASE_FACTOR * level


func _physics_process(delta):
	position.y -= speed * delta
	fuera_de_pantalla()


func fuera_de_pantalla():
	if position.y < 0:
		queue_free()
