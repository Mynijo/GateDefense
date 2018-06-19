extends KinematicBody2D

export (PackedScene) var Bullet
export (float) var gun_cooldown


export (float) var turret_speed = 1.0
export (int) var detect_radius = 400

var target = null

var can_shoot = true

func _ready():
	var circle = CircleShape2D.new()
	$GunCooldown.wait_time = gun_cooldown
	$DetectRadius/CollisionShape2D.shape = circle
	$DetectRadius/CollisionShape2D.shape.radius = detect_radius

func control(delta):
        pass

func _process(delta):
	if target:
		var target_dir = (target.global_position - $Body.global_position).normalized()
		var current_dir = Vector2(1, 0).rotated($Body.global_rotation)
		$Body.global_rotation = current_dir.linear_interpolate(target_dir, turret_speed * delta).angle()

func _on_DetectRadius_body_entered(body):
	target = body


func _on_DetectRadius_body_exited(body):
	target = null
