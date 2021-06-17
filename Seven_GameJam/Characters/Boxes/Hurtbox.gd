extends Area2D
class_name HurtBox

# warning-ignore:unused_signal
signal hit(damage)
onready var timer: Timer = $Timer


func start_invencibility_time():
	timer.start()
