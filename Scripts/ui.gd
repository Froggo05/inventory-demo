extends Control
#-----enums-----

#-----sub-components-----

#-----signals-----

#-----variables-----
var dragInstance: Drag

var leftclickActive: bool = false

var avaliableInventories: Array = []
#-----private-----
func _ready() -> void:
	for child in get_children():
		if child is InventoryManager:
			avaliableInventories.append(child)
			child.inventoryIndex = avaliableInventories.size() - 1

func _updateDrag(delta)->void:
	if dragInstance == null:
		return
	dragInstance.setTarget(get_global_mouse_position())
	dragInstance.updateItemPosition(delta)

func _startDrag()->void:
	if dragInstance != null:
		push_warning("Last drag not finished")
	var item = _lookUpInventorySlotHovered()
	if item == null:
		print("No item in hovered slot | Drag failed")
		return
	print("Starting Drag")
	dragInstance = Drag.new(item)

func _lookUpInventorySlotHovered()->Item:
	if !Global.mouseIsHovering:
		push_warning("No Inventory Hovered")
		return
	
	var inventory = avaliableInventories[Global.hoveredInventoryId] as InventoryManager
	var inventorySlot = inventory.inventoryGrid[
		Global.hoveredCellCoordinate.x][
		Global.hoveredCellCoordinate.y] as Slot
	
	if !inventorySlot.hasItem:
		print("No item in slot")
		return
	
	return inventorySlot.itemContained

func _endDrag()->void:
	if dragInstance == null:
		return
	dragInstance.endDrag()

func _physics_process(delta: float) -> void:
	if leftclickActive:
		_updateDrag(delta)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Leftclick"):
		leftclickActive = true
		_startDrag()
	if event.is_action_released("Leftclick"):
		leftclickActive = false
		_endDrag()

#-----public-----

#-----signal responses-----
