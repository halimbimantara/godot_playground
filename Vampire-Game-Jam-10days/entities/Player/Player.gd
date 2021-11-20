extends Actor

export (int, 1, 5, 1) var drain_damage := 1

onready var drainArea = $DrainArea

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("drain"):
		drain_life()

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


func _on_DrainArea_hit_body(actor: Actor) -> void:
	if actor is Actor: 
		actor.change_health(-drain_damage)
