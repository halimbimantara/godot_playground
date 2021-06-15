extends BaseState

func enter():
	.enter()
	character.motion.y = -(character.JUMP_FORCE / 2)

func on_animation_finished(animation: String):
	emit_signal("finished", "Idle")
