extends Area2D

export (int) var speed
var speed_effected
export (float) var damage
var damage_effected
export (float) var lifetime
var lifetime_effected
export (float) var critChance
var critChance_effected


var velocity = Vector2()
var runes = []
var runesScreen = []
var status = []

var exploseAfterHit = []
var explose = []

func start(_position, _direction):
	position = _position
	rotation = _direction.angle()
	$Lifetime.wait_time = get_lifetime()
	velocity = _direction * get_speed()
	$Lifetime.start()

func _process(delta):
	position += velocity * delta

func explode():
	for r in runes:
		var temp = r.get_tags()
		if r.has_tag(r.e_runeTag.explode):
			r.explode()
			
	if !explose:
		queue_free()
	
func _on_Bullet_body_entered(body):
	if body.has_method('add_Status'):
		for s in status:
			body.add_Status(s.duplicate(DUPLICATE_USE_INSTANCING))		
	if body.has_method('take_damage'):
	    body.take_damage(calcDmg(body))
	
	for r in runes:
		if r.has_tag(r.e_runeTag.enemyWasHit):
			r.enemyWasHit(body)
		
	if !exploseAfterHit:
		explode()
	
func _on_Lifetime_timeout():
	explode()

func calcDmg(body):
	var dmg = get_damage()
	if rand_range(0, 100) < get_critChance():
		dmg *= 2
		for r in runes:
			if r.has_tag(r.e_runeTag.enemyWasCrit):
				r.enemyWasCrit(body)
	return dmg		

func add_Status(_status):
	status.append(_status)	

func set_exploseAfterHit(_who, _flag):
	if _flag:
		exploseAfterHit.erase(_who)
	else:
		exploseAfterHit.append(_who)
		
func set_explose(_who, _flag):
	if _flag:
		explose.erase(_who)
	else:
		explose.append(_who)
	
func set_Runes(_runes):
	for r in _runes:
		runes.append(r)
	initRunes()
	
func set_RunesScreen(_runesScreen):
	runesScreen = _runesScreen
	for r in _runesScreen:
		runes.append(r.instance())
	initRunes()

func get_lifetime():
	if lifetime_effected:
		return lifetime_effected
	return lifetime

func get_speed():
	if speed_effected:
	 return speed_effected
	return speed

func get_damage():
	if damage_effected:
		return damage_effected
	return damage

func get_critChance():
	if critChance_effected:
		return critChance_effected
	return critChance
	
func effect_critChance(_critChance):
	critChance_effected = _critChance

func effect_damage(_damage):
	damage_effected = _damage

func effect_lifetime(_lifetime):
	lifetime_effected = _lifetime

func is_Bullet():
	return true

func initRunes():
	for r in runes:
		r._init()
		r.effect(self)
		
		