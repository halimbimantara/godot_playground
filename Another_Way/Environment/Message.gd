extends Area2D

export(String) var message := ""

onready var label: Label = $Node2D/Label
onready var animationPlayer: AnimationPlayer = $AnimationPlayer

func _ready():
	label.text = message


func _on_ArrowMessage_body_entered(body):
	if body is Player:
		animationPlayer.play("FadeIn")


func _on_ArrowMessage_body_exited(body):
	if body is Player:
		animationPlayer.play("FadeOut")
