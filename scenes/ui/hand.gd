class_name Hand
extends HBoxContainer

@export var char_stats: CharacterStats

@onready var card_ui := preload("res://scenes/card_ui/card_ui.tscn")


func add_card(card: Card) -> void:
	var new_card_ui	:= card_ui.instantiate()
	add_child(new_card_ui)
	new_card_ui.reparent_requested.connect(_on_card_ui_reparent_requested)
	new_card_ui.card = card
	new_card_ui.parent = self
	new_card_ui.char_stats = char_stats


func discard_card(card: CardUI) -> void:
	card.queue_free()


func disable_hand() -> void:
	# while discarding cards, don't want player to interact with the cards
	for card in get_children():
		card.disabled = true


# add the CardUI back as the child of hbox container or Hand
func _on_card_ui_reparent_requested(child: CardUI) -> void:
	# won't be able to emit the show tooltip request
	child.disabled = true
	child.reparent(self)
	# moves the card back to its original position in the hand
	var new_index := clampi(child.original_index, 0, get_child_count())
	move_child.call_deferred(child, new_index)
	child.set_deferred("disabled", false)
