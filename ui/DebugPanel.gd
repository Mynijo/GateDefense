extends HBoxContainer

func _ready():

	pass



func _on_PrintStray_pressed():
	get_tree().get_root().print_stray_nodes()


func _on_PrintTree_pressed():
	get_tree().get_root().print_tree_pretty()


func _on_NextWave_pressed():
	get_parent().get_parent().get_node("EnemySpawner").next_wave()
