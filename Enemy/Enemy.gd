extends KinematicBody2D

signal take_damage
signal health_changed
signal dead

export (int) var speed
export (int) var experience
export (int) var damage
export (int) var gold_value = 5
export (int) var max_health
var health

var last_tower_hit = null
var status_effecte = []
var tags
var dead = false

var velocity = Vector2()

func _ready():
		pass
		
func spawn(_position):
		global_position = _position
		health = max_health


func control(delta):
	var direction = Vector2(1, 0)
	var changed_speed = speed
	for x in status_effecte:
		if x.has_tag($Tags.e_effect.speed):
			changed_speed = x.effekt(changed_speed, $Tags.e_effect.speed)
		if x.has_tag($Tags.e_effect.health):
			take_damage(x.effekt(health, $Tags.e_effect.health))
		if x.has_tag($Tags.e_effect.direction):
			direction = x.effekt(direction, $Tags.e_effect.direction)
	velocity = direction * changed_speed * delta * -100
	
	for x in status_effecte:
		if x.has_tag($Tags.e_effect.animation):
			x.effekt(self, $Tags.e_effect.animation)
	if health <= 0:
		die()
		
func take_damage(damage):
	if dead or damage == null:
		return	
	health = health - damage
	emit_signal('health_changed',health)	
		
func die():
	for x in status_effecte:
		if x.has_tag($Tags.e_effect.cast_on_death):
			x.effekt(0,$Tags.e_effect.cast_on_death)
	get_parent().player.add_money(gold_value)
	if last_tower_hit:
		last_tower_hit.add_exp(experience)
	dead()
		
func dead():
	dead = true
	queue_free()
	
func _physics_process(delta):
		if dead:
			return
		control(delta)
		move_and_slide(velocity)
		
func get_velocity():
	return velocity
	
func add_Status(_status):
	var olny_Refresh = false
	if _status.has_tag($Tags.e_effect.dont_stack):
		for x in status_effecte:
			if x.name.is_subsequence_of(_status.name):
				x.refresh(_status) 
				_status.queue_free()
				olny_Refresh = true
	
	if !olny_Refresh:
		add_child(_status)
		status_effecte.append(_status)
	
	if _status.has_tag($Tags.e_effect.init):
		_status.effekt(self, $Tags.e_effect.init)

func remove_Status(_status):
	status_effecte.erase(_status)
	remove_child(_status)
	_status.queue_free()

func is_Enemy():
	return true