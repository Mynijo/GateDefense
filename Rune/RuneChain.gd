extends "res://Rune/RuneEffect.gd"

export (int) var chain
export (int) var detect_radius = 400

var bullet

var chain_counter = 0
var targetHits = []
var target = []
var detectRadius

	
func _ready():
	_init()

func _init():
	tags.append(e_runeTag.enemyWasHit)
	
func effect(_obj):
	bullet = _obj
	if _obj.name.is_subsequence_of('Bullet'):
		detectRadius = Area2D.new()
		detectRadius.set_collision_mask_bit(2, true)
		detectRadius.name = "DetectRadius"
		var c = CollisionShape2D.new()
		c.name = "CollisionShape2D"
		detectRadius.add_child(c)
		var circle = CircleShape2D.new()
		c.shape = circle
		c.shape.radius = detect_radius
		_obj.add_child(detectRadius)
		
	if _obj.has_method('set_exploseAfterHit'):
		_obj.set_exploseAfterHit(self, false)
		
func enemyWasHit(body):
	targetHits.append(body)
	chain()
	
func chain():
	chain_counter += 1
	
	if chain_counter >= chain:
		bullet_Explose()
		return
	
	var closestTaget = null
	var newOne = true
	
	find_targets()
	
	for x in target:
		newOne = true
		for y in targetHits:
			if x == y:
				newOne = false
				pass
		if newOne:
			if closestTaget == null:
				closestTaget = x
			else:
				if (x.global_position - bullet.position).length() < (closestTaget.global_position - bullet.position).length():
					closestTaget = x
	
	if closestTaget:
		var distance = (closestTaget.global_position - bullet.position).length()
		var _time = (distance / bullet.get_speed())
		var predicted_position = closestTaget.global_position + (closestTaget.get_velocity() * _time)
		
		var dir = (predicted_position - bullet.global_position).normalized()
		bullet.set_rotation(dir.angle())
		bullet.set_velocity(dir * bullet.get_speed())
	else:
		bullet_Explose()
		
func bullet_Explose():
	if bullet.has_method('set_exploseAfterHit'):
			bullet.set_exploseAfterHit(self, true)

	
func find_targets():
	target.clear()
	var temp = detectRadius.get_overlapping_bodies()
	for t in temp:
		if !targetHits.has(t):
			target.append(t)
	