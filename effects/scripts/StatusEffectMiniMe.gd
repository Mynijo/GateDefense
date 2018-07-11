extends "res://effects/scripts/StatusEffect.gd"

signal spawn_MiniMe

export (PackedScene) var MiniMe


func _init():
	$Tags.add_tag($Tags.e_effect.debuff)
	$Tags.add_tag($Tags.e_effect.init)
	$Tags.add_tag($Tags.e_effect.cast_on_death)
	
func effekt(value, tag):
	if tag == $Tags.e_effect.init:
		parent = value
	if tag == $Tags.e_effect.cast_on_death:
			self.connect("spawn_MiniMe", self.get_tree().get_current_scene(), "_on_spawn_attack")
			spawm_MiniMe_on_map()
			
func spawm_MiniMe_on_map():
	MiniMe_ins = MiniMe.instance()
	emit_signal('spawn_bomb', MiniMe_ins, parent.global_position, parent.last_tower_hit)