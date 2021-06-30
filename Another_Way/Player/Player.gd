extends KinematicBody2D
class_name Player

export (int) var ACCELERATION = 600
export (int) var MAX_SPEED = 70
export (float) var FRICTION = 0.3
export (int) var GRAVITY = 400
export (int) var JUMP_FORCE = 160
export (int) var MAX_HITPOINTS = 5

onready var animationPlayer: AnimationPlayer = $AnimationPlayer
onready var frontFloor: RayCast2D = $Senses/FrontFloor
onready var rearFloor: RayCast2D = $Senses/RearFloor

enum { MOVE, JUMP, FALLING, ATTACK, HIT }

var state = MOVE
var motion = Vector2.ZERO
var flip_direction: int = 1
var is_jumping := false
var life = MAX_HITPOINTS

func _physics_process(delta: float) -> void:
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	match state:
		MOVE: _state_move(input_vector, delta)
		JUMP: _state_jump(input_vector, delta)
		FALLING: _state_falling(input_vector, delta)
		ATTACK: _state_attack(input_vector, delta)
		HIT: _state_hit(input_vector, delta)


func _input(event: InputEvent):
	if not state == HIT:
		if event.is_action_pressed("jump"):
			if not state == JUMP and not is_jumping:
				_change_state(JUMP)
			
		if event.is_action_pressed("attack"):
			if not state == ATTACK:
				_change_state(ATTACK)


func _state_hit(input: Vector2, delta: float):
	animationPlayer.play("Hit")
	input.x = (flip_direction * -1)
	
	if is_grounded():
		motion.y = -JUMP_FORCE / 2
	
	apply_gravity(delta)
	apply_friction(input)
	apply_horizontal_force(input, delta)
	move()


func _state_attack(input: Vector2, delta: float):
	animationPlayer.play("Attack")
	input = Vector2.ZERO
	
	apply_gravity(delta)
	apply_friction(input)
	apply_horizontal_force(input, delta)
	apply_flip_scale(input)
	move()


func _state_falling(input: Vector2, delta: float):
	animationPlayer.play("Falling")
	
	if is_grounded():
		is_jumping = false
		_change_state(MOVE)
	
	apply_gravity(delta)
	apply_friction(input)
	apply_horizontal_force(input, delta)
	apply_flip_scale(input)
	move()


func _state_jump(input: Vector2, delta: float):
	animationPlayer.play("Jump")
	
	if is_grounded() and not is_jumping:
		is_jumping = true
		motion.y = -JUMP_FORCE
	
	if motion.y > 0:
		_change_state(FALLING)
	
	apply_gravity(delta)
	apply_friction(input)
	apply_horizontal_force(input, delta)
	apply_flip_scale(input)
	move()


func _state_move(input: Vector2, delta: float):
	if input == Vector2.ZERO:
		animationPlayer.play("Idle")
	
	if input != Vector2.ZERO:
		animationPlayer.play("Run")
	
	if motion.y > 0:
		_change_state(FALLING)
	
	apply_gravity(delta)
	apply_friction(input)
	apply_horizontal_force(input, delta)
	apply_flip_scale(input)
	move()


func _change_state(new_state):
	print("New state: ", new_state)
	state = new_state


func is_grounded() -> bool:
	if frontFloor.is_colliding() or rearFloor.is_colliding():
		return true
	return false


func apply_gravity(delta: float):
	if not is_grounded():
		motion.y += GRAVITY * delta
		motion.y = min(motion.y, JUMP_FORCE)


func apply_friction(input: Vector2, scale: float = 1.0):
	if input.x == 0 and is_grounded():
		motion.x = lerp(motion.x, 0, (FRICTION * scale))


func apply_horizontal_force(input: Vector2, delta: float):
	if input.x != 0:
		motion.x += input.x * ACCELERATION * delta
		motion.x = clamp(motion.x, -MAX_SPEED, MAX_SPEED)


func apply_flip_scale(input: Vector2):
	var value = input.x
	
	if value != 0:
		if value > 0 and flip_direction == -1:
			scale.x *= -1
			flip_direction = 1
		if value < 0 and flip_direction == 1:
			scale.x *= -1
			flip_direction = -1


func change_life(value):
	life += value


func move():
	motion = move_and_slide(motion, Vector2.UP)


func _on_AnimationPlayer_animation_finished(anim_name):
	match anim_name:
		"Attack":
			is_jumping = false
			_change_state(MOVE)
		"Hit":
			is_jumping = false
			_change_state(MOVE)


func _on_Hurtbox_hit(damage):
	if not state == HIT:
		change_life(-damage)
		_change_state(HIT)
