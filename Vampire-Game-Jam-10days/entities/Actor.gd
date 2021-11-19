extends KinematicBody2D
class_name Actor

export (int) var SPEED = 120
export (int) var JUMP_FORCE = 180
export (int) var GRAVITY = 400
export (float, 0, 1.0) var FRICTION = 0.1
export (float, 0, 1.0) var ACCELERATION = 0.25

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
