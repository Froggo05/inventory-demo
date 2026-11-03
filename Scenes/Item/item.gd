@tool
class_name Item extends Node2D

#-----enums-----

#-----sub-components-----

#-----signals-----

#-----variables-----
@export var attributes: ItemAttributes
@export var texture: Sprite2D
@export var size: Vector2i = Vector2i(1,1)
@export var moveFactor: float = 6.0
var invPosition : Vector2i = -1.0 * Vector2i.ONE
var IUID: int
var targetPosition: Vector2

#-----private-----
func _ready() -> void:
	texture.scale *= Global.uiScale

func _physics_process(delta: float) -> void:
	_updatePosition(delta)

func _updatePosition(delta)->void:
	self.global_position = self.global_position.slerp(targetPosition, clamp(delta * moveFactor, 0.0, 1.0))

#-----public-----
func getTags()-> Dictionary:
	var tagDict: Dictionary = {}
	var attributeList = attributes.get_property_list()
	for attribute: Dictionary in attributeList:
		tagDict = {attribute["name"]: attributes.get(attribute["name"])}
	return tagDict

func calculateItemPositionInSlots(slotSize: float)->Vector2:
	var CentrePos:Vector2 = UI.getInventoryManager(IUID).global_position + ((invPosition * slotSize) + ((invPosition + size) * slotSize))/2
	return CentrePos
#-----signal responses-----
