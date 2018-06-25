extends KinematicBody2D



export (float) var gun_cooldown
var gun_cooldown_effected
export (int) var detect_radius
var detect_radius_effected


export (int) var cost = 50

export (float) var turret_speed = 1.0


var runesScreen = []
var runes = []
var Bullet

signal shoot

var target = []

var can_shoot = true

func _ready():	
	myInit()
	
func myInit():
	$GunCooldown.wait_time = get_gun_cooldown()
	$DetectRadius/CollisionShape2D.shape.radius = get_detect_radius()

func control(delta):
        pass
		
func _process(delta):	
	if target.size() != 0:
		var distance = (target.front().global_position - position).length()
		var _time = (distance / (Bullet.instance().get_speed() * 2))
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

func _on_DetectRadius_body_entered(body):
	target.append(body)

func _on_DetectRadius_body_exited(body):
	target.erase(body)

func shoot():
	if can_shoot:
		$GunCooldown.start()
		can_shoot = false
		var dir = Vector2(1, 0).rotated($Body.global_rotation)
		var b = Bullet.instance()		
		emit_shoot('shoot', b, $Body.global_position, dir)
		
		for r in runes:
			var temp = r.get_tags()
			if r.has_tag(r.e_runeTag.shoot):
				r.shoot('shoot', b, $Body.global_position, dir)
		
func emit_shoot(_sig, _bullet, _pos, _dir):
	if runesScreen:
		var bullet_r = []
		for rs in runesScreen:
			var r = rs.instance()
			r.sort_Obj(self)
			bullet_r.append(r)
		_bullet.set_Runes(bullet_r)
	emit_signal(_sig, _bullet, _pos, _dir)
	
func _on_GunCooldown_timeout():
	can_shoot = true
	
func get_gun_cooldown():
	if gun_cooldown_effected:
		return gun_cooldown_effected
	return gun_cooldown
	
func effect_gun_cooldown(_gun_cooldown):
	gun_cooldown_effected = _gun_cooldown
	$GunCooldown.wait_time = gun_cooldown_effected
	$GunCooldown.start()
	
func get_detect_radius():
	if detect_radius_effected:
		return detect_radius_effected
	return detect_radius
	
func effect_detect_radius(_detect_radius):
	detect_radius_effected = _detect_radius
	$DetectRadius/CollisionShape2D.shape.radius = detect_radius_effected
	
func set_Runes(_runes):
	for r in _runes:
		runes.append(r)
	initRunes()

func set_RunesScreen(_runesScreen):
	runesScreen = _runesScreen
	for r in _runesScreen:
		runes.append(r.instance())
	initRunes()

func initRunes():
	for r in runes:
		r._init()
		r.effect(self)

func is_Tower():
	return true