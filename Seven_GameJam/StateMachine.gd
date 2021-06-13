extends Node2D
class_name StateMachine

export(String) var InitialState = "Idle"
signal state_changed
var current_state : BaseState = null


func _ready():
	for state_node in get_children():
		state_node.connect("finished", self, "_change_state")
	
	current_state = get_node("Idle")
	_change_state("Idle")


func _physics_process(delta):
	current_state.update_state(delta)


func _delegate_input(input : String):
	current_state.handle_input(input)


func _change_state(state_name: String):
	var update_state = get_node(state_name)
	
	if update_state != null:
		current_state.exit()
		current_state = update_state
		emit_signal("state_changed", state_name)
