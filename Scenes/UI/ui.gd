@tool
class_name UI extends Control
#-----enums-----

#-----sub-components-----
@onready var baseItemPacked: PackedScene = preload("uid://c681mrvm6ivda")

#-----signals-----

#-----variables-----
var dragInstance: Drag

var leftclickActive: bool = false

static var avaliableInventories: Dictionary[int, InventoryManager] = {}

#-----private-----
func _ready() -> void:
	for child in get_children():
		if child is InventoryManager:
			avaliableInventories.set(child.IUID, child)

func _updateDrag()->void:
	if dragInstance == null:
		return
	dragInstance.setItemTarget(get_global_mouse_position())

func _startDrag()->void:
	if dragInstance != null:
		#push_warning("Last drag not finished")
		dragInstance = null
	var item = _getInventorySlotHovered()
	if item == null:
		#maybe add a minimum mousemovement before drag
		print("No item in hovered slot | Drag failed")
		return
	#print("Starting Drag")
	dragInstance = Drag.new(item, self)

func _getInventorySlotHovered()->Item:
	if !Global.mouseIsHovering:
		#push_warning("No Inventory Hovered")
		return
	var activeinventory = avaliableInventories[Global.hoveredInventoryId] as InventoryManager
	var inventorySlot = activeinventory.inventoryGrid[
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

func _physics_process(_delta: float) -> void:
	if leftclickActive:
		_updateDrag()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Leftclick"):
		leftclickActive = true
		_startDrag()
	if event.is_action_released("Leftclick"):
		leftclickActive = false
		_endDrag()

#-----public-----

static func getInventoryManager(iuid: int)->InventoryManager:
	return avaliableInventories[iuid]

#-----signal responses-----

@onready var inventory: InventoryManager = $Inventory

func _on_button_pressed() -> void:
	var item: Item = baseItemPacked.instantiate()
	
	inventory.addItemToInventory(item)
