extends Character
class_name Player

export(int) var coins := 0

signal changed_coin(value)

func collect_item(type: String):
	if type == "Coin":
		coins += 1
		emit_signal("changed_coin", coins)
