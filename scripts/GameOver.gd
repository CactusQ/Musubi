extends Node2D



var p = null
func _ready():
	p = find_parent("Purchasing")
	$Subtitle.text = "Congratulations. You have sold " + \
		str(p.total_musubi_sold)+" musubi and made $" + \
		str(p.balance_usd - p.STARTING_BALANCE)

func _on_Button_pressed():	
	find_parent("Length").remove_child(p)
