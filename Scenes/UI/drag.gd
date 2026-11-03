class_name Drag extends RefCounted
#-----enums-----
#enum dragType{}
#-----sub-components-----

#-----signals-----

#-----variables-----
var item: Item
var type: String #Drag type, might add later
var position: Vector2
var offset: Vector2
var dragSmoothing: float = 1.0
var targetPosition: Vector2

#-----private-----
func _init(targetItem: Item, dragType: String = "") -> void:
	item = targetItem
	type = dragType
	#need to store the item slot relative to the item size clicked

#-----public-----
func endDrag()->void:
	free()

func setTarget(pos: Vector2)->void:
	targetPosition = pos

func updateItemPosition(delta)->void:
	item.global_position = item.global_position.move_toward(targetPosition, delta * dragSmoothing)

#-----signal responses-----
