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
	print(new)
	$ItemCountContainer/SpamCountLabel.text = str(new[0])
	$ItemCountContainer/RiceCountLabel.text = str(new[1])
	$ItemCountContainer/NoriCountLabel.text = str(new[2])
	$ItemCountContainer/PlasticCountLabel.text = str(new[3])
	$ItemCountContainer/PosterCountLabel.text = str(new[4])

# GAME VARIABLES
var current_day = 0 setget _set_day
func _set_day(x):
	current_day = x
	$Day.text = "Day "+ str(self.current_day) + " / " + \
		str(get_parent().game_length_days)

var balance_usd = 100 setget _set_balance
func _set_balance(x):
	balance_usd = x
	$Balance.text =  "$"+str(balance_usd)

var temperature = 0
var weather = ""

enum WeatherType {
  SUNNY,
  RAINY,
  CLOUDY,
}

# FUNCTIONS
var rng = RandomNumberGenerator.new()

func _ready():
	_prepare_new_day()

func _prepare_new_day():
	# delete all posters
	items[4] = 0
	
	current_day += 1
	if current_day > get_parent().game_length_days:
		add_child(load("GameOver.tscn").instance())
	else:
		_generate_new_weather()
		_render_all()
	
func _generate_new_weather():
	rng.randomize()
	temperature = int(rng.randf_range(65.0, 90.0))
	weather = WeatherType.keys()[randi() % WeatherType.size()]

func _on_Button_pressed():
	self.spam += 1
	self.balance_usd += 3
	add_child(load("Crafting.tscn").instance())

func _render_all():
	$Day.text = "Day "+ str(self.current_day) + " / " + str(get_parent().game_length_days)
	$Balance.text =  "$"+str(balance_usd)
	$Temperature.text = str(temperature) +"°F / " + str(int((temperature - 32)/1.8)) +"°C"
	$Weather.text = str(weather)

func _on_SpamBuyButton_pressed():
	var shop = load("Shop.tscn").instance()
	shop.item = ItemType.SPAM
	add_child(shop)

func _on_NoriBuyButton_pressed():
	var shop = load("Shop.tscn").instance()
	shop.item = ItemType.NORI
	add_child(shop)
	
func _on_RiceBuyButton_pressed():
	var shop = load("Shop.tscn").instance()
	shop.item = ItemType.RICE
	add_child(shop)

func _on_PlasticBuyButton_pressed():
	var shop = load("Shop.tscn").instance()
	shop.item = ItemType.PLASTIC
	add_child(shop)

func _on_PosterBuyButton_pressed():
	var shop = load("Shop.tscn").instance()
	shop.item = ItemType.POSTER
	add_child(shop)

func _on_ContinueButton_pressed():
	add_child(load("Crafting.tscn").instance())
