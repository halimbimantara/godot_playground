extends Node2D
class_name BaseState

signal finished(next_state_name)

var character
var animationPlayer: AnimationPlayer

func _ready() -> void:
	character = get_owner()
	animationPlayer = get_node("../../AnimationPlayer")


func enter():
	animationPlayer.play(self.name)
	pass


func exit():
	pass


func update_state(delta : float):
	pass


func handle_input(event : String):
	pass


func on_animation_finished(animation: String):
	pass
