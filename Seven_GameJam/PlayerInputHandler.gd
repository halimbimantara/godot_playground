extends InputHandler

func _input(event: InputEvent) -> void:
	if(event.is_action_pressed("ui_left")):
		act_input("left")
	
	if(event.is_action_pressed("ui_right")):
		stateMachine._delegate_input("right")
