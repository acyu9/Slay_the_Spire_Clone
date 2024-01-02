extends CardState

const DRAG_MINIMUM_THRESHOLD := 0.05

var minimum_drag_time_elapsed := false


func enter() -> void:
	# grab the BattleUI node which is in the ui_layer group
	var ui_layer := get_tree().get_first_node_in_group("ui_layer")
	# break free from hbox container so the card can be dragged around
	# move the card from the Hand to the BattleUI
	if ui_layer:
		card_ui.reparent(ui_layer)
	
	card_ui.panel.set("theme_override_styles/panel", card_ui.DRAG_STYLEBOX)
	Events.card_drag_started.emit(card_ui)
	
	# to avoid fast mouse clicking to register both press & release
	minimum_drag_time_elapsed = false
	# second argument = false means when scene tree is paused, timer is paused
	var threshold_timer := get_tree().create_timer(DRAG_MINIMUM_THRESHOLD, false)
	# func just changes flag to true
	threshold_timer.timeout.connect(func(): minimum_drag_time_elapsed=true)


func exit() -> void:
	Events.card_drag_ended.emit(card_ui)
	

func on_input(event: InputEvent) -> void:
	var single_targeted := card_ui.card.is_single_targeted()
	var mouse_motion := event is InputEventMouseMotion
	var cancel = event.is_action_pressed("right_mouse")
	var confirm = event.is_action_released("left_mouse") or event.is_action_pressed("left_mouse")
	
	# targets has an element in the array which is the card drop area
	if single_targeted and mouse_motion and card_ui.targets.size() > 0:
		transition_requested.emit(self, CardState.State.AIMING)
		return
	
	if mouse_motion:
		card_ui.global_position = card_ui.get_global_mouse_position() - card_ui.pivot_offset
	
	if cancel:
		transition_requested.emit(self, CardState.State.BASE)
	elif minimum_drag_time_elapsed and confirm:
		# can't instantly pick up a new card
		get_viewport().set_input_as_handled()
		transition_requested.emit(self, CardState.State.RELEASED)
