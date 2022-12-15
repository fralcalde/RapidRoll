extends Platform


var scoring = false
export var SCORE = 1
onready var scoring_area = $ScoringArea


func _physics_process(delta):
	position.y -= speed * delta
	fuera_de_pantalla()
	
	var collisions = scoring_area.get_overlapping_areas()
	for area in collisions:
		if area is PickBox:
			GameEvents.emit_signal("player_scoring", SCORE * (level + 1))
