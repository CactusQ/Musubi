extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	self.name = "Homescreen"

func _on_start_game_button_pressed():
	var story = load("res://scenes/2Storytelling.tscn").instance()
	add_child(story)
