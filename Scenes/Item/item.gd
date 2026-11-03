@tool
class_name Item extends Node2D

#-----enums-----

#-----sub-components-----

#-----signals-----

#-----variables-----
@export var attributes: ItemAttributes
@export var texture: Texture
@export var gridSize: Vector2i = Vector2i.ONE
@export var itemSize: Vector2i = Vector2i(8,8)
var inventoryPosition : Vector3i = -Vector3i.ONE

#-----private-----

#-----public-----
func getTags()-> Dictionary:
	var tagDict: Dictionary = {}
	var attributeList = attributes.get_property_list()
	for attribute: Dictionary in attributeList:
		tagDict = {attribute["name"]: attributes.get(attribute["name"])}
	
	return tagDict

#-----signal responses-----
