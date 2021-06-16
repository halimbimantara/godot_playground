extends StaticBody2D

export(PackedScene) var brokenEffect


func _on_Hurtbox_hit(damage) -> void:
	Utils.instance_scene_on_main(brokenEffect, global_position)
	queue_free()
