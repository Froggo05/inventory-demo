@tool
class_name Item extends Control

#-----enums-----

#-----sub-components-----

#-----signals-----

#-----variables-----
@export var attributes: ItemAttributes
@export var sprite: TextureRect
@export var invSize: Vector2i = Vector2i(1,1)
@export var moveFactor: float = 6.0
var invPosition : Vector2i = -1.0 * Vector2i.ONE
var IUID: int
var targetPosition: Vector2

#-----private-----
func _ready() -> void:
	sprite.scale = Vector2.ONE * (Global.uiScale/((sprite.texture.get_size().x / 8.0))) #calculate the ratio between this image and the inv slot tile size img
	print(sprite.scale)
	#position = sprite.scale * sprite.texture.get_size()
	self.custom_maximum_size = sprite.size
	pass

func _physics_process(delta: float) -> void:
	_updatePosition(delta)

func _updatePosition(delta)->void:
	self.global_position = self.global_position.lerp(targetPosition, clamp(delta * moveFactor, 0.0, 1.0))

#-----public-----
func getTags()-> Dictionary:
	var tagDict: Dictionary = {}
	var attributeList = attributes.get_property_list()
	for attribute: Dictionary in attributeList:
		tagDict = {attribute["name"]: attributes.get(attribute["name"])}
	return tagDict

func calculateItemPositionInSlots(slotSize: float)->Vector2:
	var avgPosition = Vector2(invPosition * slotSize)
	var CentrePos:Vector2 = UI.getInventoryManager(IUID).global_position + avgPosition #invetnory pos (for offset) + avg position of first and last cell for center point
	return CentrePos
#-----signal responses-----
