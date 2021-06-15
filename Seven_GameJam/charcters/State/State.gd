extends Node2D
class_name BaseState

signal finished(next_state_name)

export(NodePath) var animationPlayerPath
export(NodePath) var characterPath

var animationPlayer: AnimationPlayer
var character: Character

func _ready() -> void:
	animationPlayer = get_node(animationPlayerPath)
	character = get_node(characterPath)

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
