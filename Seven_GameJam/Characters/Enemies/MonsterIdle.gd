extends BaseState

export(String) var timeroutState = "Wander"
onready var waitTimer: Timer = $WaitTimer

func enter():
	.enter()
	waitTimer.start()

func update_state(delta : float):
	character.input_vector = Vector2.ZERO


func _on_WaitTimer_timeout() -> void:
	emit_signal("finished", timeroutState)
