extends Label

func _process(delta):
	var game_node = get_tree().get_root().get_node("/root/Game")
	if game_node:
		self.text = "Gold: " + str(game_node.Gold)
	else:
		self.text = "Gold: ERROR"
