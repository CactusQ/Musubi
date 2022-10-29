extends Node2D

var p = null
func _ready():
	p = find_parent("Purchasing")
	var total_profit = p.balance_usd - p.STARTING_BALANCE;
	if total_profit > 0:
		$Subtitle.text = "Congratulations! You have sold " + \
			str(p.total_musubi_sold)+" musubi in total and made $" + \
			str(total_profit)+"!"
	else:
		$Subtitle.text = "You have sold " + \
			str(p.total_musubi_sold)+" musubi in total and lost $" + \
			str(-total_profit)+". Don't give up."

func _on_Button_pressed():
	find_parent("Length").remove_child(p)
