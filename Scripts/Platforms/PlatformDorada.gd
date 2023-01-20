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
	if area.get_parent().has_method("set_particles_texture"):
		area.get_parent().set_particles_texture("GOLD")
