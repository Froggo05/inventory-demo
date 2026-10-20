class_name drag extends Node
#-----enums-----

#-----sub-components-----

#-----signals-----

#-----variables-----
var item: Item
var position: Vector2

#-----private-----
func _init(targetItem: Item, initialPosition: Vector2) -> void:
	item = targetItem
	position = initialPosition

#-----public-----
func endDrag()->void:
	 

#-----signal responses-----
