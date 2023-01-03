extends RigidBody2D

var move_input = 0
var move_input_str = 300
var angular_speed = 2


func _process(_delta):
	move_input = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")


func _integrate_forces(state):
	var _velocity = state.get_linear_velocity()
	var desired_vel = Vector2(move_input * move_input_str, _velocity.y)
	state.set_linear_velocity(desired_vel)
	state.angular_velocity += angular_speed * move_input
