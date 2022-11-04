extends Node2D


# Daily variables
var musubi_sold = 0
var profit = 0
var population = 0
var chance_of_selling = 0
var sales_category = ""
var todays_price = 0
var sold_out = false
var poster_traffic_inc = 0

var BASELINE_POPULATION = 100
var BASELINE_CHANCE_OF_SELLING = 0.15

var purchasing = null

# Variables to simulate "real-time" sells
var day_ended = false
var simulations_count = 0
var simulations_per_timeout = 0
var DAY_LENGTH_IN_SECONDS = 20

# How daily conditions influence foot traffic
var cond_to_chance = [0.5, 0.75, 1.0, 1.0, 1.25, 1.5]

# Cost of making one musubi
var recipe = {
	0: 1, # Spam
	1: 1, # Rice
	2: 1, # Nori
	3: 1, # Plastic
}



var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	
	self.name = "Selling"
	purchasing = find_parent("Purchasing")
	var crafting = find_parent("Crafting")
	if _not_enough_stock(): 
		purchasing.get_node("Footer/SoldOut").visible = true
	todays_price = crafting.prices[crafting.todays_style]
	
	# Calculate chance of selling depending on price and some randomness
	chance_of_selling = rng.randfn(BASELINE_CHANCE_OF_SELLING, BASELINE_CHANCE_OF_SELLING*0.20)
	chance_of_selling /= (todays_price)
	
	# Calculate population (people walking by) of potential buyers walking by
	# Increase traffic after each day passes
	population = BASELINE_POPULATION * pow((1.1), purchasing.current_day)

	# Modify foot traffic according to daily condition
	population *= cond_to_chance[purchasing.todays_cond]
	
	# Increase amount of people walking by depending on amount of posters
	var num_posters = purchasing.items[4]
	poster_traffic_inc = pow((1.1), num_posters)
	population = int(population * poster_traffic_inc)
	musubi_sold = 0
	
	# Calculate how many sells we simulate every 0.5 second
	simulations_per_timeout = ceil(population / DAY_LENGTH_IN_SECONDS / 2)
	
	$Timer.start()

func _sell_musubi_():
	# One musubi costs one of each ingredient to make
	for ingredient in recipe:
		purchasing.items[ingredient] -= recipe[ingredient]
	musubi_sold += 1
	profit += todays_price
	purchasing.balance_usd += todays_price

# Check if we have enough to sell musubi
func _not_enough_stock() -> bool:
	for ingredient in recipe:
		if purchasing.items[ingredient] < recipe[ingredient]:
			return true
	return false

func _on_EndDayButton_pressed():
	_end_day()
	
# Working with moving the sprites (Jenica)
	
var exit_frame = true

func _process(delta):
		pass
#	$asian_girl.position.x += 5
#	$blueshirt_girl.position.x += 3
#	$redshirt_boy.position.x += 4
#	$scooter_boy.position.x += 6
#	$redshirt_girl.position.x += 3
	
			
func _on_Timer_timeout():
	if simulations_count >= population:
		_end_day()
	else:
		for i in range(simulations_per_timeout):
			if _not_enough_stock(): 
				purchasing.get_node("Footer/SoldOut").visible = true
				sold_out = true
				break
			if randf() <= chance_of_selling:
				_sell_musubi_()		
		simulations_count += simulations_per_timeout
		

	
func _end_day():
	# If we end the day prematurely, simulate the remaining sells
	while not sold_out and simulations_count < population:
		if _not_enough_stock(): 
			sold_out = true
		if randf() <= chance_of_selling:
			_sell_musubi_()
		simulations_count += 1
	
	if day_ended == false:
		day_ended = true
		add_child(load("res://scenes/8EndOfDayReport.tscn").instance())
	

