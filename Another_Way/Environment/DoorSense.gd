extends Area2D

signal entered_door_sense()
signal exited_door_sense()

onready var animationPlayer: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	animationPlayer.play("idle")

func _on_DoorSense_body_entered(body: Node) -> void:
	animationPlayer.play("pushed")
	emit_signal("entered_door_sense")


func _on_DoorSense_body_exited(body: Node) -> void:
	if get_overlapping_bodies().size() < 1:
		animationPlayer.play("idle")
		emit_signal("exited_door_sense")
