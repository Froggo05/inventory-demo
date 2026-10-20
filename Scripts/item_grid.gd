class_name InventorySlotGridContainer extends GridContainer

#-----enums-----

#-----sub-components-----
@onready var inventorySlotPacked: PackedScene = preload("uid://bnpc3x54j2idn")
#-----signals-----

#-----variables-----
@export var InventorySize: Vector2i = Vector2i.ONE
@export var ButtonScale: float = 1.0
var InventoryGrid: Array = []

#-----private-----
func _ready() -> void:
	_generateGrid(InventorySize)

#-----public-----
func _generateGrid(inventorySize: Vector2i)->void:
	self.columns = inventorySize.x 
	InventoryGrid.resize(inventorySize.x)
	
	for x in range(inventorySize.x):
		InventoryGrid[x] = []
		InventoryGrid[x].resize(inventorySize.y)
	
	for y in range(inventorySize.y):
		for x in range(inventorySize.x):
			var slot =  inventorySlotPacked.instantiate() as Slot
			slot.scale = Vector2(ButtonScale, ButtonScale)
			slot.name = str(Vector2i(x,y))
			slot.inventoryCoordinate = Vector2i(x,y)
			slot.label.text = "(" + str(x) + ", " + str(y) + ")"
			slot.updateTexture(slot.inventoryCoordinate, inventorySize)
			InventoryGrid[x][y] = slot
			add_child(slot)
	print(InventoryGrid)
#-----signal responses-----
