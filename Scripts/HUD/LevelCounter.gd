extends CenterContainer


onready var anim_player = $AnimationPlayer
onready var level_number = $VSeparator/Number

# Called when the node enters the scene tree for the first time.
func _ready():
	var _err = GameEvents.connect("level_up", self, "_on_level_up")
	level_number.text = str(GameStats.level)
	modulate.a = 0


func _on_level_up():
	level_number.text = str(GameStats.level)
	anim_player.play("LEVEL_UP")

