extends "res://effects/StatusEffekt.gd"

export (PackedScene) var StatusEffektSlow
export (PackedScene) var bullet
var first_time = true
func _ready():
	_init()

signal shoot

func _init():
	tags.append(e_tags.speed)
	tags.append(e_tags.cast_on_death)	
	
func effekt(value, tag):
	if first_time:
		first_time = false
		var temp = $Sprite
		#$Sprite.modulate.r = 0
		
	if tag == e_tags.speed:
		return 0
	if tag == e_tags.cast_on_death:
		shoot()
	return value
		
	
func shoot():
	self.connect("shoot", self.get_tree().get_current_scene(), "_on_Tower_shoot")
	var b 
	var dir
	#var runnes = []
	
	for x in range(0,6):
		dir = Vector2(1, 0).rotated(x)
		b = bullet.instance()
		#runnes.clear()
		#runnes.append(StatusEffektSlow.instance())
		#b.set_runes(runnes)
		b.effect_lifetime(1) 
		emit_signal('shoot', b, get_parent().global_position, dir)