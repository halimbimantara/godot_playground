extends BaseState

export(PackedScene) var JumpEffect

onready var coyoteTimer: Timer = $CoyoteTimer
onready var jumpEffectPosition: Position2D = $JumpEffectPosition

var jumping: bool = false
var should_jump: bool = false

func enter():
	.enter()
	should_jump = true


# warning-ignore:unused_argument
func update_state(delta : float):
	if should_jump:
		jump()
	
	if(character.motion.y > 0):
		emit_signal("finished", "Falling")
	
	if(Input.is_action_pressed("ui_left")): 
		character.input_vector = Vector2.LEFT
	
	elif(Input.is_action_pressed("ui_right")): 
		character.input_vector = Vector2.RIGHT
	
	else:
		character.input_vector = Vector2.ZERO


func jump():
	if character.is_on_floor() or coyoteTimer.time_left > 0:
		if !jumping:
			jumping = true
			Utils.instance_scene_on_main(JumpEffect, jumpEffectPosition.global_position)
			character.motion.y = -character.JUMP_FORCE

func handle_input(event : String):
	if event == "reload":
		emit_signal("finished", "SwordAttack")


func _on_StateMachine_state_changed(new_state: String) -> void:
	if new_state == "Falling":
			coyoteTimer.start()
	
	if new_state == "Idle" or new_state == "Move":
		if character.is_on_floor():
			jumping = false
