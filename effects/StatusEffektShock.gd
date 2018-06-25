extends "res://effects/StatusEffekt.gd"

var ready = true

export (float) var iniDamage
export (float) var explodeDamage
export (float) var explodeRadius

var body
var shockRadius
var first = true

func _ready():
	_init()


func _init():
	tags.append(e_tags.castOnDeath)
	tags.append(e_tags.health)
	tags.append(e_tags.dontStack)
	tags.append(e_tags.needBody)

	

func effekt(value, tag):
	if tag == e_tags.health:
		if first:
			first = false
			return value - iniDamage
	return value
		
func castOnDeath(body):
	generate_detectRadius(body)	
	var temp = find_targets()
	for t in temp:
		if t.has_method('add_Status'):
			var s = self.duplicate()
			s._init()
			t.add_Status(s)
	
func generate_detectRadius(body):
	if shockRadius:
		return
	shockRadius = Area2D.new()
	shockRadius.set_collision_mask_bit(2, true)
	shockRadius.name = "ShockRadius"
	var c = CollisionShape2D.new()
	c.name = "CollisionShape2D"
	shockRadius.add_child(c)
	var circle = CircleShape2D.new()
	c.shape = circle
	c.shape.radius = explodeRadius
	body.add_child(shockRadius)

	
func find_targets():
	return shockRadius.get_overlapping_bodies()


func _on_IgniteTicker_timeout():
	ready = true