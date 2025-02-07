extends Area2D


# Called when the node enters the scene tree for the first time.
var entered = false

func _on_body_entered(body: PhysicsBody2D):
	entered = true
	


func _on_body_exited(body):
	entered = false

func _process(delta):
	if entered == true:
		if Input.is_action_just_pressed("ui_accept"):
			get_tree().change_scene_to_file("res://Level 1 map/Level 1 map.tscn")
