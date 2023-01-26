extends AudioStreamPlayer

var _effects = {
	'level_up': preload("res://SoundEffects/LevelUp.wav"),
	'player_died': preload("res://SoundEffects/Death.wav"),
	'coin_picked_up': preload("res://SoundEffects/pickupCoin.wav"),
	'clone_picked_up': preload("res://SoundEffects/ClonePickedUp.wav"),
}


func _ready():
	var _err = GameEvents.connect("level_up", self, "play_effect", ["level_up"])
	_err = GameEvents.connect("player_died", self, "play_effect", ["player_died"])
	_err = GameEvents.connect("coin_picked_up", self, 'play_effect', ["coin_picked_up"])
	_err = GameEvents.connect("clon_picked_up", self, 'play_effect', ["clone_picked_up"])


func play_effect(effect_name: String) -> void:
	stream = _effects[effect_name]
	play()
