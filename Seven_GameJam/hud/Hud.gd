extends CanvasLayer

export(int) var max_life := 3
export(int) var life := 3 
export(PackedScene) var HeartIcon
export(PackedScene) var HeartEmpty

onready var lifeContainer = $Control/LifeContainer


func _ready() -> void:
	update_hearts()


func update_hearts():
	for node in lifeContainer.get_children():
		node.queue_free()
	
	for n in life:
		create_heart()
	
	for n in max_life - life:
		create_empty_heart()


func create_heart():
	var instance = HeartIcon.instance()
	lifeContainer.add_child(instance)


func create_empty_heart():
	var instance = HeartEmpty.instance()
	lifeContainer.add_child(instance)


func _on_Player_life_change(life:int, max_life:int) -> void:
	self.life = life
	self.max_life = max_life
	update_hearts()
