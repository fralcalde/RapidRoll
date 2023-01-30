extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("INTRO")


func _unhandled_input(event):
	if event.is_action_pressed("ui_accept"):
		$AnimationPlayer.play("DESPAWN")


func start_game():
	print("Start game!!")
	GameEvents.start_game()
	queue_free()


func _on_TouchScreenButton_pressed():
	$AnimationPlayer.play("DESPAWN")


func start_platform_spawner():
	GameEvents.start_platform_spawner()
