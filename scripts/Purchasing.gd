extends Node2D

# ITEMS
enum ItemType {
  SPAM,
  RICE,
  NORI,
  PLASTIC,
  POSTER
}

var items = {
	0: 0, #Spam
	1: 0, #Rice
	2: 0, #Nori
	3: 0, #Plastic
	4: 0  #Posters
} setget _update_items

func _update_items(new):
	$Footer/SpamCountLabel.text = str(new[0])
	$Footer/RiceCountLabel.text = str(new[1])
	$Footer/NoriCountLabel.text = str(new[2])
	$Footer/PlasticCountLabel.text = str(new[3])
	$Footer/PosterCountLabel.text = str(new[4])
	
var POSTER_PRICE = 20
var POSTER_AMOUNT = 10

# GAME VARIABLES
var current_day = 0 setget _set_day
func _set_day(x):
	current_day = x
	$Footer/Day.text = str(self.current_day) + " / " + \
		str(get_parent().game_length_days)

var STARTING_BALANCE = 20
var balance_usd = STARTING_BALANCE setget _set_balance
func _set_balance(x):
	balance_usd = x
	$Footer/Balance.text =  "$"+str(balance_usd)
	$PosterBuyButton.disabled = POSTER_PRICE > balance_usd or items[4] > 0

# For Game Over Reporting Scene
var total_musubi_sold = 0
var total_population = 0

# External conditions that change every day and influence foot traffic
var day_conditions = ["Test day", "Field Trip", "No Event", "No Event", "Assembly", "Game Day"]
var todays_cond = 0

var rng = RandomNumberGenerator.new()
var daily_price_var = 1.0

func _ready():
	self.name = "Purchasing"
	_prepare_new_day()

func _prepare_new_day():
	
	# Generate new price fluctuations for the day
	daily_price_var = rng.randfn(1, 0.25)
	
	# Delete rice and posters
	self.items[1] = 0
	self.items[4] = 0
	
	current_day += 1
	if current_day > get_parent().game_length_days:
		add_child(load("res://scenes/9GameOver.tscn").instance())
	else:
		_generate_new_day_condition()
		_render_all()
	
func _generate_new_day_condition():
	rng.randomize()
	todays_cond = randi() % day_conditions.size()

func _render_all():
	$Footer/Day.text = str(self.current_day) + " / " + str(get_parent().game_length_days)
	$Footer/Balance.text =  "$"+str(balance_usd)
	$Footer/Condition.text = str(day_conditions[todays_cond])
	$PosterBuyButton.disabled = POSTER_PRICE > balance_usd or items[4] > 0

func _on_SpamBuyButton_pressed():
	var shop = load("res://scenes/5Shop.tscn").instance()
	shop.item = ItemType.SPAM
	add_child(shop)

func _on_NoriBuyButton_pressed():
	var shop = load("res://scenes/5Shop.tscn").instance()
	shop.item = ItemType.NORI
	add_child(shop)
	
func _on_RiceBuyButton_pressed():
	var shop = load("res://scenes/5Shop.tscn").instance()
	shop.item = ItemType.RICE
	add_child(shop)

func _on_PlasticBuyButton_pressed():
	var shop = load("res://scenes/5Shop.tscn").instance()
	shop.item = ItemType.PLASTIC
	add_child(shop)

func _on_PosterBuyButton_pressed():
	balance_usd -= POSTER_PRICE
	items[4] = int(rng.randfn(POSTER_AMOUNT, POSTER_AMOUNT*0.3))
	_render_all()

func _on_ContinueButton_pressed():
	var crafting_scene = load("res://scenes/6Crafting.tscn").instance()
	add_child(crafting_scene)

func _on_HelpButton_pressed():
	add_child(load("res://scenes/Help.tscn").instance())


var master_bus = AudioServer.get_bus_index ("Master")
func _on_HSlider_value_changed(value):
	AudioServer.set_bus_volume_db(master_bus, value)
	if value == -30:
		AudioServer.set_bus_mute (master_bus, true)
	else:
		AudioServer.set_bus_mute(master_bus, false)


