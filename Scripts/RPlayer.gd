class_name RPlayer
extends RigidBody2D

signal player_died

var GRAVITY = 0
const INITIAL_GRAVITY = 400
const GRAVITY_INCREASE_FACTOR = 25

var move_speed = 0
const INITIAL_SPEED = 150
const SPEED_INCREASE_FACTOR = 15
var move_input = 0

export var FALL_SCORE = 1

onready var particles = $Particles2D
var particles_tex = {
	"GOLD": preload("res://Sprites/moneda_frente.png"),
	"NORMAL": null,
	}


func _ready():
	var _err = GameEvents.connect('level_up', self, "_on_level_up")
	var level = GameStats.level
	GRAVITY = INITIAL_GRAVITY + GRAVITY_INCREASE_FACTOR * level
	move_speed = INITIAL_SPEED + SPEED_INCREASE_FACTOR * level


func _process(_delta):
	move_input = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")


func _integrate_forces(state):
	var _velocity = state.get_linear_velocity()
	var delta = state.get_step()
	_velocity.y += GRAVITY * delta
	
	var desired_vel = Vector2(move_input * move_speed, _velocity.y)
	state.set_linear_velocity(desired_vel)
	
	if _velocity.y > 0:
		GameEvents.emit_signal("player_scoring", FALL_SCORE)


func take_damage():
	emit_signal("player_died")
	queue_free()


func _on_level_up():
	calculate_gravity()
	calculate_speed()


func calculate_gravity():
	GRAVITY = INITIAL_GRAVITY + GRAVITY_INCREASE_FACTOR * GameStats.level
	print('New gravity: ', GRAVITY)


func calculate_speed():
	move_speed = INITIAL_SPEED + SPEED_INCREASE_FACTOR * GameStats.level
	print('New speed: ', move_speed)


func set_particles_texture(_type: String):
	if particles_tex.has(_type):
		particles.emitting = false
		particles.texture = particles_tex[_type]
		particles.emitting = true
