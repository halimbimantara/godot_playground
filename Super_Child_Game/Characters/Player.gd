extends Character

class_name Player

export(String, "Idle", "Run", "Hit", "Jump") var State := "Idle"

onready var coyote_timer: Timer = $CoyoteTimer
onready var remote_transform: RemoteTransform2D = $RemoteTransform2D
onready var hitBox: Area2D = $HitBox


func _physics_process(delta: float) -> void:
	var input = Vector2.ZERO
	
	match State:
		"Idle":
			update_animation("Idle")
			input = get_input_axis()
			
			if input.x != 0:
				State = "Run"
			
			if input.x != 0:
				State = "Jump"
			
			apply_all(input, delta)
			
		"Run":
			update_animation("Run")
			input = get_input_axis()
			
			if input.x == 0:
				State = "Idle"
			
			if input.y != 0:
				State = "Jump"
			
			apply_all(input, delta)
			
		"Jump":
			update_animation("Jump")
			input = get_input_axis()
			
			if is_on_floor() and input.x != 0:
				State = "Run"
			
			if is_on_floor() and input.x == 0:
				State = "Idle"
			
			apply_all(input, delta)
			
		"Hit":
			pass
	
	update_hit_box()
	apply_move()


func take_damage(damage: int) -> void:
	HIT_POINTS -= damage
	
	if HIT_POINTS <= 0:
		die()

func update_hit_box():
	if is_on_floor():
		hitBox.set_monitoring(false)
	else:
		hitBox.set_monitoring(true)

func get_input_axis() -> Vector2:
	var input = Vector2.ZERO
	
	if Input.get_action_strength("ui_left") > 0:
		input.x -= Input.get_action_strength("ui_left")
	
	if Input.get_action_strength("ui_right") > 0:
		input.x = Input.get_action_strength("ui_right")
		
	if is_on_floor() or coyote_timer.time_left > 0:
		if Input.is_action_just_pressed("jump"):
			input.y = -1

	return input


func _on_HitBox_area_entered(hurtBox: HurtBox) -> void:
	if not hurtBox is HurtBox:
		return
	
	motion.y = -JUMP_FORCE
