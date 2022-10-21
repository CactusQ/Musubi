extends Node2D



# Called when the node enters the scene tree for the first time.
func _ready():
	var sold = get_parent().musubi_sold
	var prof = get_parent().profit
	var crafting = get_parent().get_parent()
	var style_name = crafting.styles[crafting.todays_style]
	$Subtitle.text = "You sold " +str(sold)+" "+str(style_name)+" musubi for $"+str(prof)+"today."
	find_parent("Purchasing").balance_usd += prof

func _on_OkayButton_pressed():
	var purchasing = find_parent("Purchasing")
	purchasing._prepare_new_day()
	var crafting = get_parent().get_parent()
	crafting.get_parent().remove_child(crafting)
