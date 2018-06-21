extends Node2D
export (PackedScene) var tower
export (PackedScene) var player

var placed = false

func ready():
	self.connect("shoot", self.get_paten(), "_on_Tower_shoot")

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and !placed:
		if event.button_index == BUTTON_LEFT and event.pressed:
			if player.money < 10:
				return
			player.addMoney(50)
			var t = tower.instance()
			add_child(t)
			t.spawn(position.normalized())
			placed = true
			