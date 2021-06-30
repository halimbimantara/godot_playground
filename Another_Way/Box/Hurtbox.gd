extends Area2D
class_name Hurtbox

signal hit(damage)

func _on_Hurtbox_area_entered(hitbox: Hitbox):
	if hitbox is Hitbox:
		emit_signal("hit", hitbox.damage)
