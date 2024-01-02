class_name CardStateMachine
extends Node

@export var initial_state: CardState

var current_state: CardState
var states := {}


func init(card: CardUI) -> void:
	for child in get_children():
		# if child is card state then add it to dict of all the states
		if child is CardState:
			states[child.state] = child
			child.transition_requested.connect(_on_transition_requested)
			child.card_ui = card

	# if do have an initial state, enter that state (func from card_state.gd)
	if initial_state:
		initial_state.enter()
		# set the initial state to current state
		current_state = initial_state


# if current state is there, then call the corresponding functions
func on_input(event: InputEvent) -> void:
	if current_state:
		current_state.on_input(event)


func on_gui_input(event: InputEvent) -> void:
	if current_state:
		current_state.on_gui_input(event)


func on_mouse_entered() -> void:
	if current_state:
		current_state.on_mouse_entered()


func on_mouse_exited() -> void:
	if current_state:
		current_state.on_mouse_exited()


func _on_transition_requested(from: CardState, to: CardState.State) -> void:
	# something wrong so just return
	if from != current_state:
		return

	var new_state: CardState = states[to]
	
	# if the to/new state is not in the dict for some reason, just return
	if not new_state:
		return
	
	if current_state:
		current_state.exit()
	
	new_state.enter()
	current_state = new_state
