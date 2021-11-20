extends KinematicBody2D
class_name Actor

export (int) var HIT_POINT := 1
export (int) var SPEED := 100
export (int) var JUMP_FORCE := 200
export (int) var GRAVITY := 600
export (float, 0, 1.0) var FRICTION := 0.2
export (float, 0, 1.0) var ACCELERATION := 0.3

var motion = Vector2.ZERO
var input = Vector2.ZERO


func _physics_process(delta:float)->void:
	_set_input()
	_apply_gravity(delta)
	_apply_friction()
	_apply_move()
	_apply_jump()


func _set_input():
	pass


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
