extends Area2D
class_name HurtBox

signal hit(damage)
onready var timer: Timer = $Timer


func start_invencibility_time():
	set_monitoring(false)
	set_monitorable(false)
	timer.start()


func _on_Timer_timeout() -> void:
	set_monitoring(true)
	set_monitorable(true)
