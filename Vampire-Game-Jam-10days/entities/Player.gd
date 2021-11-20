extends Actor


func _physics_process(delta: float) -> void:
	pass

func _set_input():
	input = Vector2.ZERO
	
	if Input.is_action_pressed("move_right"):
		input.x = 1
	
	if Input.is_action_pressed("move_left"):
		input.x = -1
	
	if Input.is_action_just_pressed("jump"):
		input.y = -1


func _apply_gravity(delta: float)->void:
	if Input.is_action_pressed("jump") and motion.y > 0:
		motion.y += (GRAVITY*0.2) * delta
	else:
		motion.y += GRAVITY * delta


func drain_life()->void:
	pass
