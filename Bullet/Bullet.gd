extends Area2D

export (int) var speed
export (int) var damage
export (float) var lifetime

var velocity = Vector2()

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
	if body.has_method('take_damage'):
	    body.take_damage(damage)
	explode()

func _on_Lifetime_timeout():
	explode()