extends KinematicBody2D
class_name Actor

signal change_life(new_value)

export (int) var HIT_POINT := 1
export (int) var SPEED := 100
export (int) var JUMP_FORCE := 200
export (int) var GRAVITY := 600
export (float, 0, 1.0) var FRICTION := 0.2
export (float, 0, 1.0) var ACCELERATION := 0.3
export (bool) var IS_FACING_RIGHT := true

var motion = Vector2.ZERO
var input = Vector2.ZERO


func _physics_process(delta:float)->void:
	_set_input()
	_apply_gravity(delta)
	_apply_friction()
	_apply_move()
	_apply_jump()
	_check_flip()


func _set_input():
	pass


func _check_flip():
	if motion.x > 0 and not IS_FACING_RIGHT:
		IS_FACING_RIGHT = true
		scale.x *= -1
	if motion.x < 0 and IS_FACING_RIGHT:
		IS_FACING_RIGHT = false
		scale.x *= -1


func _apply_friction():
	if input.x != 0:
		if is_on_floor():
			motion.x = lerp(motion.x, input.x * SPEED, ACCELERATION)
		else:
			motion.x = lerp(motion.x, input.x * (SPEED * 0.75), ACCELERATION)
	else:
		motion.x = lerp(motion.x, 0, FRICTION)


func _apply_jump()->void:
	if input.y == -1 and is_on_floor():
		motion.y = -JUMP_FORCE


func _apply_gravity(delta: float)->void:
	motion.y += GRAVITY * delta


func _apply_move()->void:
	motion = move_and_slide(motion, Vector2.UP)


func _die() -> void:
	queue_free()


func change_health(amount: int) -> void:
	HIT_POINT += amount
	
	if HIT_POINT < 1:
		_die()
	
	emit_signal("change_life", HIT_POINT)
