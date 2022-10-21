extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _ready():
	var p = get_parent()
	
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Button_pressed():	
	var main = find_parent("Homescreen")
	var child = get_parent()
	main.remove_child(child)
