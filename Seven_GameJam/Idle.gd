extends BaseState

func handle_input(event : String):
	emit_signal("finished", "Move")
