extends CharacterBody2D

@export var speed = 200  # Bullet speed
@export var life_time = 2.0  # Time in seconds before the bullet disappears after losing its target
var target = null  # Reference to the target soldier node
var bulletDamage = 5
var time_since_target_lost = 0.0  # Time elapsed since the target was lost

func _ready():
	# Start tracking the time since the bullet was created
	time_since_target_lost = 0.0

func _physics_process(delta):
	if target and is_instance_valid(target):
		var target_position = target.global_position
		velocity = global_position.direction_to(target_position) * speed
		look_at(target_position)
		move_and_slide()
		time_since_target_lost = 0.0  # Reset the timer if target is valid
	else:
		# Bullet continues moving with the last direction if target is lost
		velocity = velocity.normalized() * speed
		move_and_slide()
		time_since_target_lost += delta
		# Destroy the bullet after the life_time has passed since losing the target
		if time_since_target_lost >= life_time:
			queue_free()  # Free the bullet if its life time has expired

func _on_area_2d_body_entered(body):
	if body == target and is_instance_valid(body):  # Check if the bullet hit the target soldier
		if body.has_method("take_damage"):
			body.call("take_damage", bulletDamage)  # Call the take_damage method
		queue_free()  # Free the bullet after it hits the target
