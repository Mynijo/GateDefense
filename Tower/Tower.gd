extends KinematicBody2D

export (float) var gun_cooldown
var gun_cooldown_effected
export (int) var detect_radius
var detect_radius_effected

export (int) var cost = 50
export (float) var turret_speed = 1.0

var rune_slots
var runes = []
var Attack

signal shoot

var target = []

var experience = 0

var can_shoot = true


enum e_rule{
	closest_first
}


func _ready():	
	rune_slots = load("res://ui/RuneSlots.tscn").instance()
	rune_slots.set_begin(Vector2(-32,32)) 
	add_child(rune_slots)
	$GunCooldown.wait_time = get_gun_cooldown()
	$DetectRadius/CollisionShape2D.shape = CircleShape2D.new()
	$DetectRadius/CollisionShape2D.shape.radius = get_detect_radius()
		
func _process(delta):	
	if target.size() != 0:
		order_by(e_rule.closest_first)
		var distance = (target.front().global_position - global_position).length()
		var test = Attack.instance()
		var _time = (distance / (test.get_speed()))
		test.free()
		var predicted_position = target.front().global_position + (target[0].get_velocity() * _time)
		
		if predicted_position.x < global_position.x:
			target.erase(target[0])
		
		var target_dir = (predicted_position - global_position).normalized()
		
		var current_dir = Vector2(1, 0).rotated($Body.global_rotation)
		$Body.global_rotation = current_dir.linear_interpolate(target_dir, turret_speed * delta).angle()
		
		if target_dir.dot(current_dir) > 0.9999:
			if can_shoot:
				shoot()
	else:
		var current_dir = Vector2(1, 0).rotated($Body.global_rotation)
		$Body.global_rotation = current_dir.linear_interpolate(Vector2(1,0), turret_speed * delta).angle()
		
func spawn(_position):
	position = _position
	self.connect("shoot", self.get_tree().get_current_scene(), "_on_Tower_shoot")


func order_by(order_by):
	if target.size() <= 0:
		return
	if order_by == e_rule.closest_first:
		var closest = null
		for t in target:
			if !closest:
				closest = t
			else:
				if t.global_position.x < closest.global_position.x:
					closest = t
		if closest != target.front():
			target.erase(closest)
			target.push_front(closest)


func _on_DetectRadius_body_entered(body):
	target.append(body)
	

func _on_DetectRadius_body_exited(body):
	target.erase(body)
		
func shoot():	
	$GunCooldown.start()
	can_shoot = false
	var b = Attack.instance()		
	if runes:		
		b.set_runes(runes, self)
	emit_signal('shoot', b, global_position, Vector2(1, 0).rotated($Body.global_rotation), self)
	
	for r in runes:
		if r.has_tag($Tags.e_rune.shoot):
			r.effect(self,$Tags.e_rune.shoot)

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
		if r.has_tag($Tags.e_rune.init_tower):
			r.effect(self, $Tags.e_rune.init_tower)
		if r.has_tag($Tags.e_rune.effect_tower):
			r.effect(self, $Tags.e_rune.effect_tower)
		runes.append(r)

func reset_tower():
	for r in runes:
		r.queue_free()
		remove_child(r)
	runes.clear()
	effect_gun_cooldown(gun_cooldown)
	effect_detect_radius(detect_radius)

func is_Tower():
	return true

func _on_Tower_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == BUTTON_LEFT: 
		get_child(5).show()
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == BUTTON_RIGHT:
		get_child(5).hide() 

func add_exp(_exp):
	experience += _exp