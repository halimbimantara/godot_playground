extends Actor

func _set_input():
	input = Vector2.ZERO
	
	if Input.is_action_pressed("move_right"):
		input.x = 1
	
	if Input.is_action_pressed("move_left"):
		input.x = -1
	
	if Input.is_action_just_pressed("jump"):
		input.y = -1
