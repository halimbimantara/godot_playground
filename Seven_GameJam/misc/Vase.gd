extends StaticBody2D

export(PackedScene) var brokenEffect

var Coin = preload("res://Misc/Coin.tscn")
var Orb = preload("res://Misc/Orb.tscn")
var Potion = preload("res://Misc/Potion.tscn")

func choose_drop() -> PackedScene:
	var options = [Coin, Orb, Potion]
	options.shuffle()
	return options.pop_front()

func drop_item():
	var random_item = choose_drop()
	var random_instance = Utils.instance_scene_on_main(random_item, global_position)
	random_instance.global_position.x += rand_range(-4, 4)
	random_instance.global_position.y += rand_range(-4, 0)


func _on_Hurtbox_hit(damage) -> void:
	drop_item()
	Utils.instance_scene_on_main(brokenEffect, global_position)
	queue_free()
