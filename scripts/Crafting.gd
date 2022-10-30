extends Node2D

enum styleType {
	REGULAR,
	FURIKAKE,
	DOUBLESPAM
}

var todays_style = -1

var styles = {
	0:"Regular",
	1:"Furikake",
	2:"Teriyaki"}
	
var prices = {
	0: 1,
	1: 1.2,
	2: 1.4,
}

func _ready():
	self.name = "Crafting"
	$Item1.text = styles[0] + " ($" +str(prices[0])+ ")"
	$Item2.text = styles[1] + " ($" +str(prices[1])+ ")"
	$Item3.text = styles[2] + " ($" +str(prices[2])+ ")"

func _on_Buy1_pressed():
	todays_style = 0
	add_child(load("res://scenes/7Selling.tscn").instance())

func _on_Buy2_pressed():
	todays_style = 1
	add_child(load("res://scenes/7Selling.tscn").instance())

func _on_Buy3_pressed():
	todays_style = 2
	add_child(load("res://scenes/7Selling.tscn").instance())

func _on_BackButton_pressed():
	get_parent().remove_child(self)

func _on_checkbox1_pressed():
	todays_style = 0
	add_child(load("res://scenes/7Selling.tscn").instance())
