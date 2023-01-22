extends Platform

export var SCORE = 1
onready var scoring_area = $ScoringArea
onready var anim_player = $AnimationPlayer


func _ready():
	anim_player.play("SPAWN")


func _physics_process(delta):
	position.y -= speed * delta
	fuera_de_pantalla()
	
	var collisions = scoring_area.get_overlapping_areas()
	for area in collisions:
		if area is PickBox:
			GameEvents.emit_signal("player_scoring", SCORE * (GameStats.level + 1))


func die():
	anim_player.play("DESPAWN")


func _on_ScoringArea_area_entered(area: PickBox):
	if area.get_parent().has_method("start_emit_gold_particles"):
		area.get_parent().start_emit_gold_particles()


func _on_ScoringArea_area_exited(area: PickBox):
	if area.get_parent().has_method("stop_emit_gold_particles"):
		area.get_parent().stop_emit_gold_particles()
