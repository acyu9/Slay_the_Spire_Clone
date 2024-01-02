class_name CardState
extends Node

enum State {BASE, CLICKED, DRAGGING, AIMING, RELEASED}

signal transition_requested(from: CardState, to: State)

# assign state in nodes in the Inspector
@export var state: State

# reference to card_ui node
var card_ui: CardUI


# entering the state
func enter() -> void:
	pass


# exiting the state
func exit() -> void:
	pass
		

func on_input(_event: InputEvent) -> void:
	pass


func on_gui_input(_event: InputEvent) -> void:
	pass


func on_mouse_entered() -> void:
	pass
	

func on_mouse_exited() -> void:
	pass
