class_name Item extends Node2D

#-----enums-----

#-----sub-components-----

#-----signals-----

#-----variables-----
@export var attributes: ItemAttributes
@export var texture: Texture
@export var size: Vector2i = Vector2i.ONE
#-----private-----

#-----public-----
func getTags()-> Dictionary:
	var tagDict: Dictionary = {}
	var attributeList = attributes.get_property_list()
	for attribute: Dictionary in attributeList:
		tagDict = {attribute["name"]: attributes.get(attribute["name"])}
	
	return tagDict
#-----signal responses-----
