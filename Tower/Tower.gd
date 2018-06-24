extends KinematicBody2D

export (PackedScene) var Bullet

export (float) var gun_cooldown = 2
export (int) var cost = 50

export (float) var turret_speed = 1.0
export (int) var detect_radius = 800

signal shoot

var target = []

var can_shoot = true

func _ready():
	
	var circle = CircleShape2D.new()
	$GunCooldown.wait_time = gun_cooldown * Bullet.instance().gunCooldownMultiplier
	$DetectRadius/CollisionShape2D.shape = circle
	$DetectRadius/CollisionShape2D.shape.radius = detect_radius

func control(delta):
        pass

func _process(delta):
	if target.size() != 0:
		var distance = (target.front().global_position - position).length()
		var _time = (distance / Bullet.instance().get_speed())
		var predicted_position = target.front().global_position + (target[0].get_velocity() * _time)
		
		if predicted_position.x < global_position.x:
			target.erase(target[0])
		
		var target_dir = (predicted_position - global_position).normalized()
		
		var current_dir = Vector2(1, 0).rotated($Body.global_rotation)
		$Body.global_rotation = current_dir.linear_interpolate(target_dir, turret_speed * delta).angle()
		
		if target_dir.dot(current_dir) > 0.9999:
			shoot()
			
			
func spawn(_position):
	position = _position
	self.connect("shoot", self.get_parent().get_parent(), "_on_Tower_shoot")


func setBullet(_Bullet):
	Bullet = _Bullet
	var temp = Bullet.instance().gunCooldownMultiplier
	var temp2 = gun_cooldown * temp
	$GunCooldown.wait_time = temp2
	$GunCooldown.start()


func _on_DetectRadius_body_entered(body):
	target.append(body)

func _on_DetectRadius_body_exited(body):
	target.erase(body)

func shoot():
	if can_shoot:
		$GunCooldown.start()
		can_shoot = false
		var dir = Vector2(1, 0).rotated($Body.global_rotation)
		emit_signal('shoot', Bullet, $Body.global_position, dir)
		

func _on_GunCooldown_timeout():
	can_shoot = true
