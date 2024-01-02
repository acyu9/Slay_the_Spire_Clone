extends CardState

var played: bool


func enter() -> void:
	# when entering the released state, haven't played the card yet
	played = false
	
	if not card_ui.targets.is_empty():
		Events.tooltip_hide_requested.emit()
		played = true
		card_ui.play()


func on_input(_event: InputEvent) -> void:
	# don't care about input once the card is played
	if played:
		return
	
	# haven't played the card but received input = don't have a valid target
	# the card is released in non-card drop area so return to base
	transition_requested.emit(self, CardState.State.BASE)
