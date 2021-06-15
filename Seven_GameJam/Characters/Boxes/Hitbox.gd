extends Area2D
class_name HitBox

export(int) var damage = 1

func _on_Hitbox_area_entered(hurtbox: HurtBox) -> void:
	if not hurtbox is HurtBox:
		return
	
	if hurtbox.timer.time_left == 0:
		hurtbox.start_invencibility_time()
		hurtbox.emit_signal("hit", damage)
