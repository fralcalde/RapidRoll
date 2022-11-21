class_name PlatformSpawner
extends Platform


signal spawn_player(position)


onready var anim_player = $AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	anim_player.play('COUNTDOWN')


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == 'COUNTDOWN':
		emit_signal('spawn_player', $PlayerSpawn.global_position)
