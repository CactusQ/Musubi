extends Node2D


var item = -1
var item_name = ""
var NUM_MAX_POSTERS = 40

var names = {
	0:"Spam",
	1:"Rice",
	2:"Nori", 
	3:"Wraps", 
	4:"Posters"}

# Item quantitiy
var qty = {
	0:[1, 5, 20],
	1:[1, 5, 20],
	2:[1, 5, 20], 
	3:[1, 5, 20], 
	4:[1, 5, 20]}
	
var prices = {
	0:[0.5, 2, 6],
	1:[0.25, 1, 3],
	2:[0.1, 0.4, 1.2], 
	3:[0.05, 0.02, 0.06], 
	4:[0.5, 2, 6]}

# Called when the node enters the scene tree for the first time.
func _ready():
	item_name = names[item]
	$Item1.text = str(qty[item][0])+" "+item_name+":"
	$Item2.text = str(qty[item][1])+" "+item_name+":"
	$Item3.text = str(qty[item][2])+" "+item_name+":"
	$Price1.text = "$"+str(prices[item][0])
	$Price2.text = "$"+str(prices[item][1])
	$Price3.text = "$"+str(prices[item][2])
	_update_shop()

func _update_shop():
	$Subtitle.text = "You have "+ str(get_parent().items[item])+" "+ item_name
	var balance = get_parent().balance_usd
	$Buy1.disabled = prices[item][0] > balance
	$Buy2.disabled = prices[item][1] > balance
	$Buy3.disabled = prices[item][2] > balance
	
	if item == 4:
		var current_posters = get_parent().items[item]
		$Subtitle.text += " (max. "+str(NUM_MAX_POSTERS)+")"
		$Buy1.disabled = $Buy1.disabled or current_posters + qty[4][0] > NUM_MAX_POSTERS
		$Buy2.disabled = $Buy1.disabled or current_posters + qty[4][1] > NUM_MAX_POSTERS
		$Buy3.disabled = $Buy1.disabled or current_posters + qty[4][2] > NUM_MAX_POSTERS

func _on_BackButton_pressed():
	get_parent().remove_child(self)

func _on_Buy1_pressed():
	get_parent().items[item] += qty[item][0]
	get_parent().balance_usd -= prices[item][0]
	_update_shop()
	
func _on_Buy2_pressed():
	get_parent().items[item] += qty[item][1]
	get_parent().balance_usd -= prices[item][1]
	_update_shop()
	
func _on_Buy3_pressed():
	get_parent().items[item] += qty[item][2]
	get_parent().balance_usd -= prices[item][2]
	_update_shop()
