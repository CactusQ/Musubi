extends Node2D


# Daily variables
var musubi_sold = 0
var profit = 0
var population = 0
var sales_category = ""
var todays_price = 0
var sold_out = false

var BASELINE_POPULATION = 100
var BASELINE_CHANCE_OF_SELLING = 0.15

var purchasing = null

var category_thresholds = {
	"low": 0,
	"average": BASELINE_POPULATION * BASELINE_CHANCE_OF_SELLING,
	"high": BASELINE_POPULATION
}

# Cost of making one musubi
var recipe = {
	0: 1, # Spam
	1: 1, # Rice
	2: 1, # Nori
	3: 1, # Plastic
}

# Called when the node enters the scene tree for the first time.
func _ready():
	purchasing = find_parent("Purchasing")
	var crafting = get_parent()
	
	todays_price = crafting.prices[crafting.todays_style]
	
	# Calculate chance of selling depending on price and external condition
	var chance_of_selling = BASELINE_CHANCE_OF_SELLING
	chance_of_selling /= (todays_price)
	
	# Calculate population of potential buyers walking by
	population = BASELINE_POPULATION * pow((1.1), purchasing.current_day)
	
	# Increase amount of people walking by depending on amount of posters
	var num_posters = purchasing.items[4]
	population *= pow((1.05), num_posters)
	musubi_sold = 0
	
	# For every person walking by, do random event of selling or not selling
	print(BASELINE_POPULATION)
	print(population)
	print(chance_of_selling)
	for i in range(population):
		if _not_enough_stock(): 
			sold_out = true
			break
		if randf() >= chance_of_selling:
			_sell_musubi_()
	

	
	
	add_child(load("EndOfDayReport.tscn").instance())
	
func _sell_musubi_():
	# One musubi costs one of each ingredient to make
	for ingredient in recipe:
		purchasing.items[ingredient] -= recipe[ingredient]
	musubi_sold += 1
	profit += todays_price

# Check if we have enough to sell musubi
func _not_enough_stock() -> bool:
	for ingredient in recipe:
		if purchasing.items[ingredient] < recipe[ingredient]:
			return true
	return false


func _on_EndDayButton_pressed():
	add_child(load("EndOfDayReport.tscn").instance())
