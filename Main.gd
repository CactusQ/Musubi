extends Node2D

var game_length_days = 0

func _ready():
	self.name = "Homescreen"
	game_length_days = 0
	_load_welcome()

func _load_welcome():
	add_child(load("Welcome.tscn").instance())
	
func _load_purchasing():
	var purchasing = load("Purchasing.tscn").instance()
	purchasing.name = "Purchasing"
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
