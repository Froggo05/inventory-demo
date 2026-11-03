@tool
class_name Item extends Control

#-----enums-----

#-----sub-components-----

#-----signals-----

#-----variables-----
@export var attributes: ItemAttributes
@export var texture: TextureRect
@export var invSize: Vector2i = Vector2i(1,1)
@export var moveFactor: float = 6.0
var itemScale:float = 0.008

var invPosition : Vector2i = -1.0 * Vector2i.ONE
var IUID: int
var targetPosition: Vector2
var itemOffset: Vector2 = Vector2( self.size.x/2, self.size.y/2)
#-----private-----
func _ready() -> void:
	texture.scale *= Global.uiScale * 0.008

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
	var avgPosition = ((invPosition * slotSize) + ((invPosition + invSize) * slotSize))/2 - self.size/2
	var CentrePos:Vector2 = UI.getInventoryManager(IUID).global_position + avgPosition
	return CentrePos - itemOffset
#-----signal responses-----
