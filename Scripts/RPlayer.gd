class_name RPlayer
extends RigidBody2D

signal player_died
signal player_scoring

const GRAVITY = 300
var move_input = 0
var move_speed = 300


func _process(_delta):
	move_input = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")


func _integrate_forces(state):
	var _velocity = state.get_linear_velocity()
	var delta = state.get_step()
	_velocity.y += GRAVITY * delta
	
	var desired_vel = Vector2(move_input * move_speed, _velocity.y)
	state.set_linear_velocity(desired_vel)
	
	if _velocity.y > 0:
		emit_signal("player_scoring")


func take_damage():
	emit_signal("player_died")
	queue_free()
