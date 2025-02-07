extends Node2D

@onready var path = preload("res://Sean722/Mobs/Level_1_Path.tscn")
@export var spawn_interval = 5.0  # Time interval between spawns

var timer : Timer = null

func _ready():
	timer = Timer.new()
	timer.wait_time = spawn_interval
	timer.one_shot = false
	add_child(timer)
	timer.connect("timeout", Callable(self, "_on_timer_timeout"))
	timer.start()

func _on_timer_timeout():
	print("Timer triggered")
	var tempPath = path.instantiate()
	add_child(tempPath)
	var soldier = tempPath.get_child(0)  
	soldier.add_to_group("Soldier")
