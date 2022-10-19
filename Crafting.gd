extends Node2D

enum styleType {
	REGULAR,
	FURIKAKE,
	DOUBLESPAM
}

var todaysStyle = -1

var styles = {
	0:"Regular",
	1:"Furikake",
	2:"Double Spam"}

func _ready():
	$Item1.text = styles[0]
	$Item2.text = styles[1]
	$Item3.text = styles[2]

func _on_Buy1_pressed():
	add_child(load("Selling.tscn").instance())


func _on_BackButton_pressed():
	get_parent().remove_child(self)
