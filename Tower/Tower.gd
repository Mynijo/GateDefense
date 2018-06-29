extends KinematicBody2D

export (float) var gun_cooldown
var gun_cooldown_effected
export (int) var detect_radius
var detect_radius_effected

export (int) var cost = 50
export (float) var turret_speed = 1.0

var rune_slots
var runes = []
var Bullet

signal shoot

var target = []

var can_shoot = true

func _ready():	
	rune_slots = load("res://ui/RuneSlots.tscn").instance() 
	add_child(rune_slots)
	$GunCooldown.wait_time = get_gun_cooldown()
	$DetectRadius/CollisionShape2D.shape = CircleShape2D.new()
	$DetectRadius/CollisionShape2D.shape.radius = get_detect_radius()
		
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
			if can_shoot:
				shoot()
			
func spawn(_position):
	position = _position
	self.connect("shoot", self.get_tree().get_current_scene(), "_on_Tower_shoot")

func _on_DetectRadius_body_entered(body):
	target.append(body)

func _on_DetectRadius_body_exited(body):
	target.erase(body)
		
func shoot():	
	$GunCooldown.start()
	can_shoot = false
	var b = Bullet.instance()		
	if runes:		
		b.set_runes(runes, self)
	emit_signal('shoot', b, global_position, Vector2(1, 0).rotated($Body.global_rotation))
	
	for r in runes:
		if r.has_tag(r.e_rune_tag.shoot):
			r.effect(self,r.e_rune_tag.shoot)

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
	
func runes_changed():	
	apply_runes(rune_slots.get_runes())
	
func apply_runes(_runes):
	reset_tower()
	for r in _runes:
		add_child(r)
		#r._init()
		if r.has_tag(r.e_rune_tag.init_tower):
			r.effect(self, r.e_rune_tag.init_tower)
		if r.has_tag(r.e_rune_tag.effect_tower):
			r.effect(self, r.e_rune_tag.effect_tower)
		runes.append(r)

func reset_tower():
	for r in runes:
		remove_child(r)
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
