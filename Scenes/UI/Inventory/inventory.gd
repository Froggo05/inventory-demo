@tool
class_name InventoryManager extends Control

#-----enums-----
enum SLOTCHECK{
	NULL = -1,
	EMPTY,
	FULL,
	SAME
}
#-----sub-components-----
@export var inventorySlotGridContainer: InventorySlotGridContainer
#-----signals-----

#-----variables-----
@export var inventorySize: Vector2i = Vector2i.ONE
var itemsArray: Array = []
var initialMousePos: Vector2 = Vector2.ZERO
var IUID: int
var inventoryGrid: Array[Array]:
	set(value):
		return
	get():
		return inventorySlotGridContainer.InventoryGrid
#-----private-----
func _ready() -> void:
	IUID = UID.GENERATEINVENTORYINDEX()
	inventorySlotGridContainer.generateGrid(inventorySize, IUID)
	
#-----public-----
func addItem(item: Item)->void:
	itemsArray.append(item)

func checkCell(cellPosition: Vector2i, item: Item)->int:
	var slot: = inventoryGrid[cellPosition.x][cellPosition.y] as Slot
	if slot.hasItem:
		if slot.itemContained == item:
			return SLOTCHECK.SAME
		else:
			return SLOTCHECK.FULL
	else:
		return SLOTCHECK.EMPTY

#-----signal responses-----
func _on_mouse_entered() -> void:
	Global.mouseIsHovering = true
	print("Mouse is hovering Inventory", Global.hoveredInventoryId)

func _on_mouse_exited() -> void:
	Global.mouseIsHovering = false


func _on_item_grid_resized() -> void:
	size = inventorySlotGridContainer.size
