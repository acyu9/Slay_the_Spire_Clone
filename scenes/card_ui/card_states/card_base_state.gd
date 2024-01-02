extends CardState


func enter() -> void:
	# can enter state before card ui node is ready so need to wait
	if not card_ui.is_node_ready():
		await card_ui.ready
	
	# so when clicking really fast, the card won't be in the wrong position
	# because the tween animation is still running when it's already another state
	if card_ui.tween and card_ui.tween.is_running():
		card_ui.tween.kill()
	
	card_ui.panel.set("theme_override_styles/panel", card_ui.BASE_STYLEBOX)
	card_ui.reparent_requested.emit(card_ui)
	# don't want the top left of the card to be where the mouse clicks
	card_ui.pivot_offset = Vector2.ZERO
	# don't want to see the card description when enter the state
	Events.tooltip_hide_requested.emit()


func on_gui_input(event: InputEvent) -> void:
	# check if the card is interactable
	if not card_ui.playable or card_ui.disabled:
		return
		
	if event.is_action_pressed("left_mouse"):
		card_ui.pivot_offset = card_ui.get_global_mouse_position() - card_ui.global_position
		# transition_requested(from, to)
		transition_requested.emit(self, CardState.State.CLICKED)


func on_mouse_entered() -> void:
	if not card_ui.playable or card_ui.disabled:
		return
		
	card_ui.panel.set("theme_override_styles/panel", card_ui.HOVER_STYLEBOX)
	Events.card_tooltip_requested.emit(card_ui.card.icon, card_ui.card.tooltip_text)


func on_mouse_exited() -> void:
	if not card_ui.playable or card_ui.disabled:
		return
		
	card_ui.panel.set("theme_override_styles/panel", card_ui.BASE_STYLEBOX)
	Events.tooltip_hide_requested.emit()
	
