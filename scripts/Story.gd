extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	self.name = "Story"
	
func _on_LetsgoButton_pressed():
	var length = load("res://scenes/3Length.tscn").instance()
	add_child(length)
