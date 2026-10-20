class_name InventoryManager extends Control

#-----enums-----

#-----sub-components-----
@export var InventoryGrid: InventorySlotGridContainer
#-----signals-----

#-----variables-----
var itemsArray: Array = []
var initialMousePos: Vector2 = Vector2.ZERO
#-----private-----

#-----public-----
func addItem(item: Item)->void:
	itemsArray.append(item)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Leftclick"):
		initialMousePos
#-----signal responses-----
