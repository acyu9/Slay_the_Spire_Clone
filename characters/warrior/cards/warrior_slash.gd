extends Card

@export var optional_sound: AudioStream


func apply_effects(targets: Array[Node]):
	var damage_effect := DamageEffect.new()
	damage_effect.amount = 4
	damage_effect.sound = sound
	# targets is an array so this is aoe attack
	damage_effect.execute(targets)
