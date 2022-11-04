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
	
# Increasing noise, will increase randomization for all prices
var NOISE = 0.25

# Item quantities
var qty = {
	0:[1, 5, 20],
	1:[1, 5, 20],
	2:[1, 5, 20], 
	3:[1, 5, 20], 
	4:[1, 5, 20]}

# Related pricing
var prices = {
	0:[0.5, 2, 6],
	1:[0.25, 1, 3],
	2:[0.1, 0.4, 1.2], 
	3:[0.05, 0.02, 0.06], 
	4:[0.5, 2, 6]}
	
var backgrounds = {
	0:"shop_spam.png",
	1:"shop_rice.png",
	2:"shop_nori.png",
	3:"shop_wrap.png"
}

func round_place(num, places):
	return (round(num*pow(10, places))/pow(10, places))
	
	
# Called when the node enters the scene tree for the first time.
func _ready():
	
	# Calculate new prices based on daily price fluctuations
	var x = get_parent().daily_price_var
	for key in prices.keys():
		for i in range(len(prices[key])):
			prices[key][i] = round_place(prices[key][i]*x, 2)
	
	$shop_background.texture = load("res://images/"+backgrounds[item])
	item_name = names[item]
	$Item1.text = str(qty[item][0])+" for $"+str(prices[item][0]).pad_decimals(2)
	$Item2.text = str(qty[item][1])+" for $"+str(prices[item][1]).pad_decimals(2)
	$Item3.text = str(qty[item][2])+" for $"+str(prices[item][2]).pad_decimals(2)
	_update_shop()

func _update_shop():
	#$Subtitle.text = "You have "+ str(get_parent().items[item])+" "+ item_name
	var balance = get_parent().balance_usd
	$Buy1.disabled = prices[item][0] > balance
	$Buy2.disabled = prices[item][1] > balance
	$Buy3.disabled = prices[item][2] > balance
	
	# Disable buying posters if max. qty would be reached
	if item == 4:
		var current_posters = get_parent().items[item]
		$Subtitle.text += " (max. "+str(NUM_MAX_POSTERS)+")"
		$Buy1.disabled = $Buy1.disabled or current_posters + qty[4][0] > NUM_MAX_POSTERS
		$Buy2.disabled = $Buy2.disabled or current_posters + qty[4][1] > NUM_MAX_POSTERS
		$Buy3.disabled = $Buy3.disabled or current_posters + qty[4][2] > NUM_MAX_POSTERS

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
