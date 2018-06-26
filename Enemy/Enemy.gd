extends KinematicBody2D

signal take_damage
signal health_changed
signal dead

export (int) var speed
export (int) var health
export (int) var damage
export (int) var gold_value = 5


var status_effekte = []
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
	for x in status_effekte:
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
	for x in status_effekte:
		if x.has_tag(x.e_tags.cast_on_death):
			x.cast_on_death(self)
	get_parent().player.add_money(gold_value)
	dead()
		
func dead():
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
	var olny_Refresh = false
	if _status.has_tag(_status.e_tags.dont_stack):
		for x in status_effekte:
			if x.name.is_subsequence_of(_status.name):
				x.refresh(_status) 
				olny_Refresh = true
	
	if !olny_Refresh:
		add_child(_status)
		status_effekte.append(_status)

func remove_Status(_status):
	status_effekte.erase(_status)