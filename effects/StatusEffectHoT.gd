extends "res://effects/StatusEffect.gd"

export (int) var healValue
export (float) var tick_rate

var ready = true

func _ready():
	$Ticker.wait_time = tick_rate
	$Ticker.start()

func _init():
	$Tags.add_tag($Tags.e_effect.health)


func effekt(value, tag):
	if tag == $Tags.e_effect.health:
		if ready:
			if  get_parent().health + healValue <= get_parent().max_health:
				ready = false
				$Ticker.start()
				$Ticker.wait_time = tick_rate
				return -healValue
		return 0
	return value

func _on_Ticker_timeout():
	ready = true
