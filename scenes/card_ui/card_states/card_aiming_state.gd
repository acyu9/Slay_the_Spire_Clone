extends CardState

const MOUSE_Y_SNAPBACK_THRESHOLD := 138


func enter() -> void:
	# need to make sure the only target is the enemy
	card_ui.targets.clear()
	
	# animate card to center of hand
	var offset := Vector2(card_ui.parent.size.x / 2, -card_ui.size.y / 2)
	offset.x -= card_ui.size.x / 2
	card_ui.animate_to_position(card_ui.parent.global_position + offset, 0.2)
	# don't want card drop area to be registered to the targets array so don't monitor
	card_ui.drop_point_detector.monitoring = false
	# global script event bus
	Events.card_aim_started.emit(card_ui)


func exit() -> void:
	Events.card_aim_ended.emit(card_ui)


func on_input(event: InputEvent) -> void:
	var mouse_motion := event is InputEventMouseMotion
	var mouse_at_bottom := card_ui.get_global_mouse_position().y > MOUSE_Y_SNAPBACK_THRESHOLD
	
	# snap back if not in drop area or aiming is cancelled
	if (mouse_motion and mouse_at_bottom)  or event.is_action_pressed("right_mouse"):
		transition_requested.emit(self, CardState.State.BASE)
	elif event.is_action_released("left_mouse") or event.is_action_pressed("left_mouse"):
		get_viewport().set_input_as_handled()
		transition_requested.emit(self, CardState.State.RELEASED)
		
