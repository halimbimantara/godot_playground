extends BaseState

func enter():
	.enter()
	character.hurtBox.start_invencibility_time()
	character.motion.y = -(character.JUMP_FORCE / 2)

func on_animation_finished(animation: String):
	emit_signal("finished", "Idle")
