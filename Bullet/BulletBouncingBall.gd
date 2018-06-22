extends "res://Bullet/Bullet.gd"

export (int) var max_chains = 5
export (int) var detect_radius = 100

var chain_counter = 0
var target = []
var enemys_hitted = []
var firstLook = true


func start(_position, _direction):
	position = _position
	rotation = _direction.angle()
	$Lifetime.wait_time = lifetime
	velocity = _direction * speed
	$Lifetime.start()
	
	var circle = CircleShape2D.new()
	$DetectRadius/CollisionShape2D.shape = circle
	$DetectRadius/CollisionShape2D.shape.radius = detect_radius


func _on_Bullet_body_entered(body):
	if enemys_hitted.has(body):
		return
	

	enemys_hitted.append(body)
	if body.has_method('take_damage'):
	    body.take_damage(damage)
	if chain_counter < max_chains:
		chain()
	else:
		explode()
		
func chain():
	chain_counter += 1
	
	var closestTaget = null
	var newOne = true
	
	for x in target:
		newOne = true
		for y in enemys_hitted:
			if x == y:
				newOne = false
				pass
		if newOne:
			if closestTaget == null:
				closestTaget = x
			else:
				if (x.global_position - position).length() < (closestTaget.global_position - position).length():
					closestTaget = x
	
	if closestTaget:
		var distance = (closestTaget.global_position - position).length()
		var _time = (distance / speed)
		var predicted_position = closestTaget.global_position + (closestTaget.get_velocity() * _time)
		
		var dir = (predicted_position - global_position).normalized()
		rotation = dir.angle()
		velocity = dir * speed
	else:
		explode()


func _on_DetectRadius_body_entered(body):
	target.append(body)


func _on_DetectRadius_body_exited(body):
	target.erase(body)
	if target.size() == enemys_hitted.size():
		explode()
