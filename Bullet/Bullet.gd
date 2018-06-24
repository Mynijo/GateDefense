extends Area2D

export (int) var speed
export (int) var damage
export (float) var lifetime

var velocity = Vector2()
var runes = []
var runesScreen = []
var status = []

var exploseAfterHit = true

func start(_position, _direction):
	position = _position
	rotation = _direction.angle()
	$Lifetime.wait_time = lifetime
	velocity = _direction * speed
	$Lifetime.start()

func _process(delta):
	position += velocity * delta

func explode():
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
		
	if exploseAfterHit:
		explode()
	

func _on_Lifetime_timeout():
	explode()

func set_rotation(_rotation):
	rotation = _rotation
	
func set_velocity(_vel):
	velocity = _vel

func set_exploseAfterHit(_flag):
	exploseAfterHit = _flag
	
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
		
		