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
	for x in $StatusEffects.get_Status_list($Tags.e_effect.speed):
		changed_speed = x.effekt(changed_speed, $Tags.e_effect.speed)
	for x in $StatusEffects.get_Status_list($Tags.e_effect.health):
		take_damage(x.effekt(health, $Tags.e_effect.health))
	for x in $StatusEffects.get_Status_list($Tags.e_effect.direction):
		direction = x.effekt(direction, $Tags.e_effect.direction)	
	
	if 	!$Animation.is_playing():
		$Animation.play('walk')
		
	velocity = direction * changed_speed * delta * -100	
	
	for x in $StatusEffects.get_Status_list($Tags.e_effect.animation):
		x.effekt(self, $Tags.e_effect.animation)
			
	if health <= 0:
		die()
		
func take_damage(damage):
	if dead or damage == null:
		return	
	health = health - damage
	emit_signal('health_changed',health)	
		
func die():
	for x in $StatusEffects.get_Status_list($Tags.e_effect.cast_on_death):
			x.effekt(self,$Tags.e_effect.cast_on_death)
			
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
	$StatusEffects.add_Status(_status)
	
	if _status.has_tag($Tags.e_effect.init):
		_status.effekt(self, $Tags.e_effect.init)

func remove_Status(_status):
	$StatusEffects.remove_Status(_status)

func get_StatusEffects(_tag = null):
	return  $StatusEffects.get_Status_list(_tag)

func is_Enemy():
	return true