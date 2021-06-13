extends KinematicBody2D
class_name Character

export(int) var HIT_POINTS := 3
export(int) var MAX_SPEED := 70
export(int) var ACCELERATION := 600
export(int) var JUMP_FORCE := 180
export(int) var GRAVITY := 400
export(float) var FRICTION := 0.5

export(NodePath) var cameraPath

onready var sprite: Sprite = $Sprite
onready var collider: CollisionShape2D = $Collisor
onready var animationPlayer: AnimationPlayer = $AnimationPlayer

var motion := Vector2.ZERO
var input_vector := Vector2.ZERO
var flip_direction := 1


func _physics_process(delta: float) -> void:
	apply_gravity(delta)
	apply_horizontal_force(delta)
	apply_move(delta)
	apply_friction(delta)
	apply_flip_scale()


func apply_flip_scale():
	if input_vector.x != 0:
		if input_vector.x > 0 and flip_direction == -1:
			scale.x *= -1
			flip_direction = 1
		if input_vector.x < 0 and flip_direction == 1:
			scale.x *= -1
			flip_direction = -1


func apply_horizontal_force(delta: float):
	if input_vector.x != 0:
		motion.x += input_vector.x * ACCELERATION * delta
		motion.x = clamp(motion.x, -MAX_SPEED, MAX_SPEED)


func apply_gravity(delta:float):
	if not is_on_floor():
		motion.y += GRAVITY * delta
		motion.y = min(motion.y, JUMP_FORCE)


func apply_move(delta:float):
	motion = move_and_slide(motion, Vector2.UP)


func apply_friction(delta:float):
	if input_vector.x == 0 and is_on_floor():
		motion.x = lerp(motion.x, 0, FRICTION)


func take_damage(damage:int):
	HIT_POINTS -= damage


func _on_Hurtbox_hit(damage: int) -> void:
	take_damage(damage)

