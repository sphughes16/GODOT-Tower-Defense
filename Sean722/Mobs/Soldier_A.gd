extends CharacterBody2D

@export var speed = 100
var Health = 10

func _process(delta):
	get_parent().set_progress(get_parent().get_progress() + speed * delta)
	if get_parent().get_progress_ratio() == 1:
		queue_free()  # Remove the soldier if at the end of the path
	if Health <= 0:
		die()  # Call the die function

func take_damage(amount: int):
	Health -= amount
	if Health <= 0:
		die()  # Call the die function

func die():
	var game = get_tree().get_root().get_node("/root/Game")
	if game:
		game.add_gold(5)  # Directly call the add_gold method
	print("Soldier died, gold added.")
	queue_free()  # Remove the soldier
