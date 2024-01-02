# meta-name: Effect
# meta-description: Create an effect which can be applied to a target
class_name MyAwesomeEffect
extends Effect

var member_var := 0


func execute(targets: Array[Node]) -> void:
	print('effect targets: %s' % targets)
	print('does %s something' % member_var)
