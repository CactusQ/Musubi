extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_OkayButton_pressed():
	var purchasing = find_parent("Purchasing")
	purchasing._prepare_new_day()
	var crafting = get_parent().get_parent()
	crafting.get_parent().remove_child(crafting)
