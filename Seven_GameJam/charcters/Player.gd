extends Character



func _on_StateMachine_state_changed(new_state) -> void:
	$Debg.text = new_state
