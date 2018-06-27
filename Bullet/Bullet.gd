extends Area2D

export (int) var speed
var speed_effected
export (float) var damage
var damage_effected
export (float) var lifetime
var lifetime_effected
export (float) var crit_chance
var crit_chance_effected


var velocity = Vector2()
var runes = []
var runes_screen = []
var status = []

var explose_after_hit = []
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
		if r.has_tag(r.e_rune_tag.explode):
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
		if r.has_tag(r.e_rune_tag.enemy_was_hit):
			r.enemy_was_hit(body)
		
	if !explose_after_hit:
		explode()
	
func _on_Lifetime_timeout():
	explode()

func calcDmg(body):
	var dmg = get_damage()
	if rand_range(0, 100) < get_crit_chance():
		dmg *= 2
		for r in runes:
			if r.has_tag(r.e_rune_tag.enemy_was_crit):
				r.enemy_was_crit(body)
	return dmg		

func add_Status(_status):
	status.append(_status)	

func set_explose_after_hit(_who, _flag):
	if _flag:
		explose_after_hit.erase(_who)
	else:
		explose_after_hit.append(_who)
func set_explose(_who, _flag):
	if _flag:
		explose.erase(_who)
	else:
		explose.append(_who)

func set_runes(_runes):
	for r in _runes:
		runes.append(r)
	init_runes()
func set_runes_screen(_runes_screen):
	runes_screen = _runes_screen
	for r in _runes_screen:
		runes.append(r.instance())
	init_runes()
func init_runes():
	for r in runes:
		r._init()
		r.effect(self)

func get_lifetime():
	if lifetime_effected:
		return lifetime_effected
	return lifetime
func effect_lifetime(_lifetime):
	lifetime_effected = _lifetime

func get_speed():
	if speed_effected:
	 return speed_effected
	return speed
func effect_speed(_speed):
	speed_effected = _speed

func get_damage():
	if damage_effected:
		return damage_effected
	return damage
func effect_damage(_damage):
	damage_effected = _damage

func get_crit_chance():
	if crit_chance_effected:
		return crit_chance_effected
	return crit_chance
func effect_crit_chance(_crit_chance):
	crit_chance_effected = _crit_chance

func is_Bullet():
	return true

