class_name AntiSlot extends Node2D

#-----enums-----

#-----sub-components-----
@export var placementConfirmation: TextureRect
#-----signals-----

#-----variables-----
var canSeat: bool = false
var inventoryPosition: Vector2i= Vector2.ZERO
var positionInItem: Vector2i
var placementConfirmationColour: Color:
	set(value):
		return
	get():
		if canSeat:
			return Color(0, 0.39215687, 0, 0.5)
		else:
			return Color(0.54509807, 0, 0, 0.5)

#-----private-----
func _checkPosition()->void:
	
	canSeat = true
	canSeat = false

#-----public-----

#-----signal responses-----
