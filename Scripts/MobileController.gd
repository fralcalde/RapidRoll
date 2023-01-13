extends Node2D


const FADE_TIME = 15.0


func _ready():
	if OS.get_name() != "Android":
		queue_free()
	
	$Tween.interpolate_property($".", "modulate", Color("ffffff"), Color("00ffffff"), FADE_TIME, Tween.TRANS_LINEAR)
	$Tween.start()


func _on_LeftButton_pressed():
	Input.action_press("ui_left")


func _on_LeftButton_released():
	Input.action_release("ui_left")


func _on_RightButton_pressed():
	Input.action_press("ui_right")


func _on_RightButton_released():
	Input.action_release("ui_right")
