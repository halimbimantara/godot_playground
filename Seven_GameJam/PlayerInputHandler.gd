extends InputHandler

func _input(event: InputEvent) -> void:
	if(event.is_action("ui_left")):
		act_input("left")
	
	if(event.is_action("ui_right")):
		act_input("right")
	
	if(event.is_action_pressed("ui_accept")):
		act_input("jump")
