extends KinematicBody2D

signal take_damage
signal health_changed
signal dead

export (int) var speed
export (int) var health
export (int) var damage
export (int) var goldValue = 5

var StatusEffekte = []


var velocity = Vector2()
var alive = true

func _ready():
		pass
		
func spawn(_position):
		position = _position
var tags

func control(delta):
	var changed_speed = speed
	for x in StatusEffekte:
		if x.has_tag(x.e_tags.speed):
			changed_speed = x.effekt(changed_speed, x.e_tags.speed)
		if x.has_tag(x.e_tags.health):
			take_damage(-x.effekt(0, x.e_tags.health))
			
	velocity = Vector2(changed_speed * delta * -100, 0)
	
func take_damage(damage):
	health -= damage
	emit_signal('health_changed',health)
	if health <= 0:
		dead()
		
func dead():
	get_parent().player.add_money(goldValue)
	get_parent().mobs_counter -= 1
	queue_free()
	
func _physics_process(delta):
		if not alive:
			return
		control(delta)
		move_and_slide(velocity)
		
		
func get_velocity():
	return velocity
	
func add_Status(_status):	
	add_child(_status)
	StatusEffekte.append(_status)

func remove_Status(_status):
	StatusEffekte.erase(_status)