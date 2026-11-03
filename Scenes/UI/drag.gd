class_name Drag extends Node
#-----enums-----
#enum dragType{}
#-----sub-components-----

#-----signals-----

#-----variables-----
var item: Item
var type: String #Drag type, might add later
var initialPosition: Vector2
var offset: Vector2
var dragSmoothing: float = 1.0
var targetinitialPos: Vector2
var uiRef: UI

#-----private-----
func _init(targetItem: Item, ui: UI, dragType: String = "") -> void:
	uiRef = ui
	item = targetItem
	type = dragType
	initialPosition = item.targetPosition
	#need to store the item slot relative to the item size clicked

#-----public-----
func endDrag()->void:
	if Global.mouseIsHovering:
		var inventory: InventoryManager = uiRef.avaliableInventories[Global.hoveredInventoryId]
		inventory.removeItem(item.invPosition, item)
		inventory.placeItem(Global.hoveredCellCoordinate, item)
	else:
		setItemTarget(initialPosition)

func setItemTarget(pos: Vector2)->void:
	item.targetPosition = pos



#-----signal responses-----
