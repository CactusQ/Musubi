extends Node2D

var game_length_days = 0

func _ready():
	self.name = "Length"

func _load_purchasing():
	var purchasing = load("res://scenes/4Purchasing.tscn").instance()
	add_child(purchasing)

func _on_FiveButton_pressed():
	game_length_days = 5
	_load_purchasing()

func _on_TenButton_pressed():
	game_length_days = 10
	_load_purchasing()	
	
func _on_TwentyButton_pressed():
	game_length_days = 20
	_load_purchasing()
