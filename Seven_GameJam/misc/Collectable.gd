extends Node2D
class_name Collectable

export(String) var type = ""
export(PackedScene) var CollectEffec = null

func _on_Area2D_body_entered(body: Node) -> void:
	if not body is Player: 
		return
	
	body.collect_item(type)
	
	if CollectEffec != null:
		Utils.instance_scene_on_main(CollectEffec, global_position)
	
	queue_free()
