extends KinematicBody2D

signal take_damage
signal health_changed
signal dead

export (int) var speed
export (int) var health
export (int) var damage
export (int) var goldValue = 5


var StatusEffekte = []
var tags
var dead = false

var velocity = Vector2()
var alive = true

func _ready():
		pass
		
func spawn(_position):
		position = _position


func control(delta):
	
	var changed_speed = speed
	for x in StatusEffekte:
		if x.has_tag(x.e_tags.speed):
			changed_speed = x.effekt(changed_speed, x.e_tags.speed)
		if x.has_tag(x.e_tags.health):
			take_damage(-x.effekt(0, x.e_tags.health))
			
	velocity = Vector2(changed_speed * delta * -100, 0)
	
func take_damage(damage):
	if dead:
		return	
	health -= damage
	emit_signal('health_changed',health)
	if health <= 0:
		die()
		
func die():
	for x in StatusEffekte:
		if x.has_tag(x.e_tags.castOnDeath):
			x.castOnDeath(self)
	get_parent().player.add_money(goldValue)
	dead()
		
func dead():
	get_parent().mobs_counter -= 1
	dead = true
	queue_free()
	
func _physics_process(delta):
		if not alive:
			return
		control(delta)
		move_and_slide(velocity)
		
		
func get_velocity():
	return velocity
	
func add_Status(_status):
	var olnyRefresh = false
	if _status.has_tag(_status.e_tags.dontStack):
		for x in StatusEffekte:
			if x.name.is_subsequence_of(_status.name):
				x.refresh(_status) 
				olnyRefresh = true
	
	if !olnyRefresh:
		add_child(_status)
		StatusEffekte.append(_status)

func remove_Status(_status):
	StatusEffekte.erase(_status)