class_name PlatformSpawner
extends Platform


signal spawn_player(position)


onready var anim_player = $AnimationPlayer
onready var player_sprite = $PlayerSpawn


# Called when the node enters the scene tree for the first time.
func _ready():
	anim_player.play('COUNTDOWN')


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == 'COUNTDOWN':
		emit_signal('spawn_player', player_sprite.global_position)
		GameEvents.spawn_player(player_sprite.global_position)
