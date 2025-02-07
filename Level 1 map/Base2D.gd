extends Area2D

@onready var health = $ProgressBar
@onready var game_over_ui_scene = preload("res://Cung/2D Player/Game Over UI.tscn")  # Path to your game over UI scene
var game_over_ui_instance = null  # To store the instance of the game over UI

func _on_body_entered(body):
	if "Soldier_A" in body.name:
		health.value -= 5
		print(health.value)
		if health.value <= 0:
			show_game_over_ui()

func show_game_over_ui():
	# Instantiate and display the game over UI
	if not game_over_ui_instance:
		game_over_ui_instance = game_over_ui_scene.instantiate()
		get_tree().root.add_child(game_over_ui_instance)  # Add to the root to make it visible

	# Create and start a timer for delay
	var timer = Timer.new()
	timer.wait_time = 3.0  # Delay in seconds
	timer.one_shot = true
	timer.connect("timeout", Callable(self, "_on_game_over_timeout"))
	get_tree().root.add_child(timer)  # Add timer to the root
	timer.start()

func _on_game_over_timeout():
	# Remove only the game over UI instance
	if game_over_ui_instance:
		game_over_ui_instance.queue_free()
		game_over_ui_instance = null

	# Change to the new scene
	get_tree().change_scene_to_file("res://Oliver/Main map/New main map.tscn")
