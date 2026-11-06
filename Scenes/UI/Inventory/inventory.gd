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
@export var inventorySize: Vector2i = Vector2i.ONE:
	set(value):
		inventorySize = clamp(value, Vector2i(0,0), Vector2i(50,50))
	get():
		return clamp(inventorySize, Vector2i(0,0), Vector2i(50,50))
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

func placeItem(inventoryPos: Vector2i, item: Item)->void:
	var cellCheck = checkItemDropPosition(inventoryPos, item)
	if cellCheck == SLOTCHECK.EMPTY:
		item.invPosition = inventoryPos
		item.IUID = IUID
		item.targetPosition = item.calculateItemPositionInSlots(inventoryGrid[inventoryPos.x][inventoryPos.y].sizePixels)
		#print("Place item of size: ", item.invSize)
		
		var itemBounds: Vector2i = Vector2i(inventoryPos.x + item.invSize.x, inventoryPos.y + item.invSize.y)
		var yrange = range(inventoryPos.y, itemBounds.y)
		var xrange = range(inventoryPos.x, itemBounds.x)
		
		for y in yrange:
			for x in xrange:
				var slot = inventoryGrid[x][y] as Slot
				slot.setItem(item)
	else:
		placeItem(item.invPosition, item) #works because item.invPosition hasnt been updated by our method yet and the past position should be valid
		push_warning("Cant move: ", item," REASON: " ,SLOTCHECK.find_key(cellCheck))

func removeItem(inventoryPos: Vector2i, item: Item)->void:	
	var itemBounds: Vector2i = Vector2i(inventoryPos.x + item.invSize.x, inventoryPos.y + item.invSize.y)
	var yrange = range(inventoryPos.y, itemBounds.y)
	var xrange = range(inventoryPos.x, itemBounds.x)
	
	for y in yrange:
		for x in xrange:
			var slot = inventoryGrid[x][y] as Slot
			slot.removeItem()

func checkItemDropPosition(inventoryPos: Vector2i, item: Item)->int:
	var itemBounds: Vector2i = Vector2i(inventoryPos.x + item.invSize.x, inventoryPos.y + item.invSize.y)
			
	var yrange = range(inventoryPos.y, itemBounds.y)
	var xrange = range(inventoryPos.x, itemBounds.x)
	
	if itemBounds.y > inventorySize.y:
		#push_error("Checking out of bounds (Y)", itemBounds.y, " -> ",inventorySize.y)
		return SLOTCHECK.NULL
	if itemBounds.x > inventorySize.x:
		#push_error("Checking out of bounds (X)", itemBounds.x, " -> ",inventorySize.x)
		return SLOTCHECK.NULL
		
	for y in yrange:
		for x in xrange:
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
	#print("Mouse is hovering Inventory", Global.hoveredIUID)

func _on_mouse_exited() -> void:
	Global.mouseIsHovering = false


func _on_item_grid_resized() -> void:
	size = inventorySlotGridContainer.size
