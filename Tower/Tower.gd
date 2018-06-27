extends KinematicBody2D



export (float) var gun_cooldown
var gun_cooldown_effected
export (int) var detect_radius
var detect_radius_effected


export (int) var cost = 50

export (float) var turret_speed = 1.0
var rune_slots

var runes_screen = []
var runes = []
var Bullet

signal shoot

var target = []

var can_shoot = true

func _ready():	
	rune_slots = load("res://Rune/RuneSlots.tscn").instance() 
	add_child(rune_slots)
	myInit()

func runes_changed():	
	apply_runes(rune_slots.get_runes())
	
func myInit():
	$GunCooldown.wait_time = get_gun_cooldown()
	$DetectRadius/CollisionShape2D.shape.radius = get_detect_radius()

func control(delta):
        pass
		
func _process(delta):	
	if target.size() != 0:
		var distance = (target.front().global_position - global_position).length()
		var _time = (distance / (Bullet.instance().get_speed()))
		var predicted_position = target.front().global_position + (target[0].get_velocity() * _time)
		
		if predicted_position.x < global_position.x:
			target.erase(target[0])
		
		var target_dir = (predicted_position - global_position).normalized()
		
		var current_dir = Vector2(1, 0).rotated($Body.global_rotation)
		$Body.global_rotation = current_dir.linear_interpolate(target_dir, turret_speed * delta).angle()
		
		if target_dir.dot(current_dir) > 0.9999:
			tryToShoot()
			
func spawn(_position):
	position = _position
	self.connect("shoot", self.get_parent().get_parent(), "_on_Tower_shoot")

func _on_DetectRadius_body_entered(body):
	target.append(body)

func _on_DetectRadius_body_exited(body):
	target.erase(body)

func tryToShoot():
	if can_shoot:
		shoot()
		
func shoot():	
	$GunCooldown.start()
	can_shoot = false
	var dir = Vector2(1, 0).rotated($Body.global_rotation)
	var b = Bullet.instance()		
	emit_shoot('shoot', b, $Body.global_position, dir)
	
	for r in runes:
		var temp = r.get_tags()
		if r.has_tag(r.e_rune_tag.shoot):
			r.shoot('shoot', b, $Body.global_position, dir)
		
func emit_shoot(_sig, _bullet, _pos, _dir):
	if runes_screen:
		var bullet_r = []
		for rs in runes_screen:
			rs.sort_Obj(self)
			bullet_r.append(rs)
		_bullet.set_runes(bullet_r)
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


func apply_runes(_runes):
	reset_tower()
	for r in _runes:
		r.effect(self)
		runes.append(r)

func reset_tower():
	runes.clear()
	effect_gun_cooldown(gun_cooldown)
	effect_detect_radius(detect_radius)


func is_Tower():
	return true

func _on_Tower_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == BUTTON_LEFT: 
		get_child(4).show()
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == BUTTON_RIGHT:
		get_child(4).hide() 
