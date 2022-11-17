extends KinematicBody2D

const GRAVITY = 300

export var speed = 32000
var _velocity = Vector2.ZERO
var move_input = 0
var tamano_pantalla
var muerte_fuera_de_pantalla

signal player_died


func _ready():
	tamano_pantalla = get_viewport_rect().size.x
	print(tamano_pantalla)


func _process(_delta):
	move_input = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	_mantener_en_pantalla()


func _physics_process(delta):
	_velocity.x = speed * move_input * delta
	_velocity.y += GRAVITY * delta
	_velocity = move_and_slide(_velocity,Vector2.UP)


func _mantener_en_pantalla():
	if position.x > tamano_pantalla:
		position.x = tamano_pantalla
	elif position.x < 0:
		position.x = 0


func take_damage():
	emit_signal("player_died")
	queue_free()
