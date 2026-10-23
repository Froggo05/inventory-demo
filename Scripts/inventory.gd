class_name InventoryManager extends Control

#-----enums-----

#-----sub-components-----
@export var inventorySlotGridContainer: InventorySlotGridContainer
#-----signals-----

#-----variables-----
@export var inventorySize: Vector2i = Vector2i.ONE
var itemsArray: Array = []
var initialMousePos: Vector2 = Vector2.ZERO
var inventoryIndex: int
var inventoryGrid: Array[Array]:
	set(value):
		return
	get():
		return inventorySlotGridContainer.InventoryGrid
#-----private-----
func _ready() -> void:
	inventoryIndex = Global.getUniqueInventoryIndex()
	inventorySlotGridContainer.generateGrid(inventorySize, inventoryIndex)
#-----public-----
func addItem(item: Item)->void:
	itemsArray.append(item)

#-----signal responses-----
func _on_mouse_entered() -> void:
	Global.mouseIsHovering = true
	print("Mouse is hovering Inventory", Global.hoveredInventoryId)

func _on_mouse_exited() -> void:
	Global.mouseIsHovering = false
