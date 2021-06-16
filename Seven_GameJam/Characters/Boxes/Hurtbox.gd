extends Area2D
class_name HurtBox

signal hit(damage)
onready var timer: Timer = $Timer


func start_invencibility_time():
	timer.start()
