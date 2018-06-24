extends Area2D

export (int) var speed
export (int) var damage
export (float) var lifetime

var velocity = Vector2()
var runes = []
var runesScreen = []
var status = []

var exploseAfterHit = []
var explose = []

func start(_position, _direction):
	position = _position
	rotation = _direction.angle()
	$Lifetime.wait_time = lifetime
	velocity = _direction * speed
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

func get_speed():
	return speed
	
func _on_Bullet_body_entered(body):
	if body.has_method('add_Status'):
		for s in status:
			body.add_Status(s.duplicate())		
	if body.has_method('take_damage'):
	    body.take_damage(damage)
	
	for r in runes:
		var temp = r.get_tags()
		if r.has_tag(r.e_runeTag.enemyWasHit):
			r.enemyWasHit(body)
		
	if !exploseAfterHit:
		explode()
	
func _on_Lifetime_timeout():
	explode()

func get_rotation():
	return rotation

func set_rotation(_rotation):
	rotation = _rotation
	
func get_velocity():
	return velocity
	
func set_velocity(_vel):
	velocity = _vel

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
	
func add_Status(_status):
	status.append(_status)	

func set_Runes(_runes):
	runesScreen = _runes
	for r in _runes:
		runes.append(r.instance())
	initRunes()

func initRunes():
	for r in runes:
		r._init()
		r.effect(self)
		
		