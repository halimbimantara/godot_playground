extends Actor

export (int, 1, 5, 1) var drain_damage := 1

onready var drainArea = $DrainArea
onready var camera: Camera2D = $Camera2D

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("drain"):
		drain_life()
	if event.is_action_pressed("ui_cancel"):
		self.change_health(-1)

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
	if Input.is_action_just_pressed("drain"):
		drainArea.trigger_enable()


func _check_flip():
	._check_flip()
	var amount = 4
	
	if IS_FACING_RIGHT:
		camera.set_h_offset(amount)
	else:
		camera.set_h_offset(-amount)


func _die() -> void:
	# warning-ignore:return_value_discarded
	get_tree().reload_current_scene()


func _on_DrainArea_hit_body(actor: Actor) -> void:
	if actor is Actor:
		actor.change_health(-drain_damage)
