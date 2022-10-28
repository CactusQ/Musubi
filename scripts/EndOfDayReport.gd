extends Node2D


func round_place(num,places):
	return (round(num*pow(10,places))/pow(10,places))

# Called when the node enters the scene tree for the first time.
func _ready():
	var purchasing = find_parent("Purchasing")
	var crafting = find_parent("Crafting")
	var selling = find_parent("Selling")
	var sold = selling.musubi_sold
	var prof = selling.profit
	var pop = selling.population
	
	var style_name = crafting.styles[crafting.todays_style]
	$Subtitle.text = "You sold " +str(sold)+" "+str(style_name)+" musubi for $"+str(prof)+" today."
	
	if sold > 0 and selling.sold_out:
		$Subtitle.text += " (Sold out!)"

	# Display end of day statistics
	$RiceSubtitle.visible = purchasing.items[1] != 0
	$PosterSubtitle.visible = purchasing.items[4] != 0
	$PopSubtitle.text = str(pop)+" people walked by."
	
	var x = round_place(selling.poster_traffic_inc, 2)
	$PosterSubtitle.text = "Your posters created "+str(float(x))+"X more traffic than usual today."

	# Update statistics and balance
	purchasing.balance_usd += prof
	purchasing.total_musubi_sold += sold
	purchasing.total_population += pop

func _on_OkayButton_pressed():
	var purchasing = find_parent("Purchasing")
	var crafting = find_parent("Crafting")
	purchasing._prepare_new_day()
	purchasing.remove_child(crafting)
