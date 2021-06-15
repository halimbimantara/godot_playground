extends InputHandler


func _on_Area2D_body_entered(body: Player) -> void:
	if not body is Player: 
		return

	var space_state = get_world_2d().direct_space_state
	var result = space_state.intersect_ray(character.global_position, body.global_position, [character])

	if result.collider is Player: 
		act_input("Chase")
