extends Panel

@onready var tower = preload("res://Sean722/Towers/bullet_tower_red.tscn")
var currTile

func _on_gui_input(event):
	if Game.Gold >= 10:
		var tempTower = tower.instantiate()  # Fixed syntax error here
		if event is InputEventMouseButton and event.button_mask == MOUSE_BUTTON_MASK_LEFT and event.pressed:
			# Left Click Down
			add_child(tempTower)
			tempTower.process_mode = Node.PROCESS_MODE_DISABLED
			tempTower.global_position = event.global_position

		elif event is InputEventMouseMotion and event.button_mask == MOUSE_BUTTON_MASK_LEFT:
			# Left Click Down Drag
			if get_child_count() > 1:
				get_child(1).global_position = event.global_position

		elif event is InputEventMouseButton and event.button_mask == 0:
			# Left Click Up
			print("Left button Up")
			if get_child_count() > 1:
				get_child(1).queue_free()
			var path = get_tree().get_root().get_node("Level1Map/Towers")
			path.add_child(tempTower)
			tempTower.global_position = event.global_position
			Game.Gold -= 10
		else:
			if get_child_count() > 1:
				get_child(1).queue_free()
