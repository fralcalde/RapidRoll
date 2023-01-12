extends Node2D


func _ready():
	if OS.get_name() != "Android":
		queue_free()
	
	$Tween.interpolate_property($".", "modulate", Color("ffffff"), Color("00ffffff"), 10.0, Tween.TRANS_LINEAR)
	$Tween.start()


func _on_LeftButton_pressed():
	Input.action_press("ui_left")


func _on_LeftButton_released():
	Input.action_release("ui_left")


func _on_RightButton_pressed():
	Input.action_press("ui_right")


func _on_RightButton_released():
	Input.action_release("ui_right")
