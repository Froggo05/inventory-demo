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
func addItemToInventory(item: Item)->void:
	for y in range(inventorySize.y):
		for x in range(inventorySize.x):
			if checkItemDropPosition(Vector2i(x,y), item) == SLOTCHECK.EMPTY:
				add_child(item)
				placeItem(Vector2i(x,y), item)
				print("AddAdded item to: ", Vector2i(x, y))
				return #exit the loop as has placed one item
			else:
				print("Cant place item: ", Vector2i(x, y))

func placeItem(inventoryPos: Vector2i, item: Item)->void:
	var cellCheck = checkItemDropPosition(inventoryPos, item)
	if cellCheck == SLOTCHECK.EMPTY:
		item.invPosition = inventoryPos
		item.IUID = IUID
		item.targetPosition = item.calculateItemPositionInSlots(inventoryGrid[0][0].sizePixels.x)
		print("Place item of size: ", item.invSize)
		for y in range(inventoryPos.y, inventoryPos.y + item.invSize.y):
			for x in range(inventoryPos.x, inventoryPos.x + item.invSize.x):
				var slot = inventoryGrid[inventoryPos.x][inventoryPos.y] as Slot
				slot.setItem(item)
	else:
		push_error("Cant move item: ", item)

func removeItem(inventoryPos: Vector2i, item: Item)->void:
		for y in range(inventoryPos.y, inventoryPos.y + item.invSize.y):
			for x in range(inventoryPos.x, inventoryPos.x + item.invSize.x):
				var slot = inventoryGrid[inventoryPos.x][inventoryPos.y] as Slot
				slot.setItem(null)

func checkItemDropPosition(inventoryPos: Vector2i, item: Item)->int:
	for y in range(inventoryPos.y, inventoryPos.y + item.invSize.y):
		for x in range(inventoryPos.x, inventoryPos.x + item.invSize.x):
			var cellCheck: int = checkCell(Vector2i(x,y), item)
			if cellCheck == SLOTCHECK.FULL:
				return SLOTCHECK.FULL
			if cellCheck == SLOTCHECK.SAME:
				return SLOTCHECK.FULL
	#If the slots are
	return SLOTCHECK.EMPTY

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
