extends StaticBody2D

var Bullet = preload("res://Sean722/Towers/red_bullet.tscn")
var BulletDamage = 5
var currTarget = null
var currTargets = []
var fireCooldown = 1.5  # Cooldown time in seconds
var fireTimer = 0.0

func _process(delta):
	fireTimer -= delta
	
	if currTarget and not is_instance_valid(currTarget):
		currTarget = null

	if currTarget == null:
		update_targets()
		currTarget = get_highest_progress_target()

	if fireTimer <= 0 and currTarget:
		fire_bullet(currTarget)
		fireTimer = fireCooldown
	
	if is_instance_valid(currTarget):
		self.look_at(currTarget.global_position)
	else:
		for i in get_node("BulletContainer").get_child_count():
			get_node("BulletContainer").get_child(i).queue_free()

func _on_tower_body_entered(body):
	if "Soldier_A" in body.name:
		update_targets()

func _on_tower_body_exited(body):
	if body in currTargets:
		currTargets.erase(body)
		if currTarget == body:
			currTarget = get_highest_progress_target()

func update_targets():
	currTargets = []
	var overlapping_bodies = get_node("Tower").get_overlapping_bodies()
	for body in overlapping_bodies:
		if "Soldier" in body.name:
			currTargets.append(body)
	if currTarget and not is_instance_valid(currTarget):
		currTarget = get_highest_progress_target()

func get_highest_progress_target():
	var highest_progress_target = null
	for target in currTargets:
		if highest_progress_target == null or target.get_parent().get_progress() > highest_progress_target.get_parent().get_progress():
			highest_progress_target = target
	return highest_progress_target

func fire_bullet(target):
	var tempBullet = Bullet.instantiate()
	tempBullet.target = target
	tempBullet.bulletDamage = BulletDamage
	get_node("BulletContainer").add_child(tempBullet)
	tempBullet.global_position = $Aim.global_position
	
	
	
func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_mask == 1:
		var towerPath = get_tree().get_root().get_node("Main/Towers")
		for i in range(towerPath.get_child_count()):
			if towerPath.get_child(i).name != self.name:
				towerPath.get_child(i).get_node("Upgrade/Upgrade").hide()
		var upgrade_node = get_node("Upgrade/Upgrade")
		upgrade_node.visible = not upgrade_node.visible
		upgrade_node.global_position = self.position + Vector2(-572, 81)
			
func _ready():
	
	self.z_index = 1
