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
var dragSmoothing: float = 25.0
var targetinitialPos: Vector2
var uiRef: UI
var initialItemInvPos: Vector2i
var initialIUID: int
#-----private-----
func _init(targetItem: Item, dragType: String = "") -> void:
	item = targetItem
	initialItemInvPos = item.invPosition
	type = dragType
	initialPosition = item.global_position
	initialIUID = item.IUID
	UI.getInventoryManager(initialIUID).removeItem(initialItemInvPos, item)
	#need to store the item slot relative to the item size clicked

#-----public-----
func endDrag()->void:
	if Global.mouseIsHovering:
		UI.getInventoryManager(Global.hoveredIUID).placeItem(Global.hoveredCellCoordinate, item)
	else:
		UI.getInventoryManager(initialIUID).placeItem(initialItemInvPos, item)

func setItemTargetPos(pos: Vector2)->void:
	item.targetPosition = pos 

#-----signal responses-----
