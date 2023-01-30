extends CanvasLayer


onready var anim_player = $AnimationPlayer
onready var final_score = $ScoreContainer/Label


func _ready():
	anim_player.play("SPAWN")
	final_score.text = str(GameStats.score)


func _on_Button_pressed():
	go_to_main_menu()


func _unhandled_input(event):
	if event.is_action_pressed("ui_accept"):
		go_to_main_menu()


func go_to_main_menu():
	anim_player.play("DESPAWN")


func spawn_main_menu():
	GameEvents.spawn_main_menu()
