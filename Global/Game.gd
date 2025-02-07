extends Node

var Gold = 100
var Health = 100

# Function to add gold
func add_gold(amount):
	Gold += amount
	print("Gold is now: " + str(Gold))
