extends Area2D

export(String) var message := ""

onready var label: Label = $Node2D/Label
onready var animationPlayer: AnimationPlayer = $AnimationPlayer

func _ready():
	label.text = message


func _on_ArrowMessage_body_entered(body):
	animationPlayer.play("FadeIn")


func _on_ArrowMessage_body_exited(body):
	animationPlayer.play("FadeOut")
