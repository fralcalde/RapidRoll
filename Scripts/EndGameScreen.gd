extends CanvasLayer


onready var anim_player = $AnimationPlayer
onready var final_score = $ScoreContainer/Label


func _ready():
	final_score.text = str(GameStats.score)
	
	var _err = MobileAds.connect("interstitial_closed", self, "_on_interstitial_closed")
	if MobileAds.get_is_interstitial_loaded():
		MobileAds.show_interstitial()
	else:
		print("Endgame screen didn't have an interstitial ready...")
		_on_interstitial_closed()


func _on_Button_pressed():
	go_to_main_menu()


func _unhandled_input(event):
	if event.is_action_pressed("ui_accept"):
		go_to_main_menu()


func go_to_main_menu():
	anim_player.play("DESPAWN")


func spawn_main_menu():
	GameEvents.spawn_main_menu()


func _on_interstitial_closed() -> void:
	anim_player.play("SPAWN")
