extends Node2D

var p = null
var _enable_play_again = false

func _ready():

	$EndTitle.visible = false
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
		self._enable_play_again = true
		$Button.icon = load("res://buttons/_play_again_button.png")

func _on_Button_pressed():
	if self._enable_play_again == false:
		$Subtitle.visible = false
		$EndTitle.visible = true
		$Button.icon = load("res://buttons/_play_again_button.png")
		self._enable_play_again = true
	else:
		find_parent("Length").remove_child(p)	
