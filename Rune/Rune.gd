extends Node

enum e_runeTag{
	enemyWasHit
}

export (e_runeTag) var tags = []

func effect(obj):
	pass
	
func get_tags():
	return tags
	
func has_tag(_tag):
	if tags == null:
		return false
	return tags.has(_tag)