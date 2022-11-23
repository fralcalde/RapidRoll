class_name PlatformSpawner
extends Platform


signal spawn_player(position)

onready var anim_player = $AnimationPlayer
onready var player_sprite = $PlayerSpawn
var spawned = false

# Called when the node enters the scene tree for the first time.
func _ready():
	anim_player.play('SPAWNING')


func _enter_tree():
	GameEvents.player_spawning()


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == 'COUNTDOWN':
		spawn_player()


func _process(_delta):
	var altura_pantalla = get_viewport_rect().size.y
	var spawn_height = altura_pantalla / 2
	
	if position.y == spawn_height and spawned == false:
		spawn_player()
		spawned = true


func spawn_player():
	emit_signal('spawn_player', player_sprite.global_position)
	GameEvents.spawn_player(player_sprite.global_position)
	anim_player.stop()
	player_sprite.visible = false
