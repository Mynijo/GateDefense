extends KinematicBody2D

signal take_damage
signal health_changed
signal dead

export (int) var speed
export (int) var health
export (int) var damage
export (int) var goldValue = 5


var velocity = Vector2()
var alive = true

func _ready():
		pass
		
func spawn(_position):
		position = _position

func control(delta):
	velocity = Vector2(speed * delta * -100, 0)
	
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