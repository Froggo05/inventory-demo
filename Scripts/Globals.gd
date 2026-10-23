extends Node
#-----enums-----

#-----sub-components-----

#-----signals-----

#-----variables-----

#-----private-----

#-----public-----
var SelectedItem: Item
var inventoryCount: int
var hoveredCellCoordinate: Vector2i
var hoveredInventoryId: int

var mouseIsHovering: bool = false

func getUniqueInventoryIndex()-> int:
	inventoryCount += 1
	return inventoryCount-1

#-----signal responses-----

func updateHoveredCell(inventoryCoordinate: Vector2i, inventoryIndex: int)->void:
	hoveredCellCoordinate = inventoryCoordinate
	hoveredInventoryId = inventoryIndex
	print("Updating Hover: ", hoveredCellCoordinate, " in inventory: ", inventoryIndex)
