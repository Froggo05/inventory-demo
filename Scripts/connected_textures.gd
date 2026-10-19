extends Node2D
enum TextureIndex{
	ERROR = -1,
	BOX,
	TOP_LEFT_CORNER,
	TOP_EDGE,
	TOP_RIGHT_CORNER,
	TOP_CUP,
	LEFT_EDGE,
	CENTRE,
	RIGHT_EDGE,
	VERTICLE_TUBE,
	BOTTOM_LEFT_CORNER,
	BOTTOM_EDGE,
	BOTTOM_RIGHT_CORNER,
	BOTTOM_CUP,
	LEFT_CUP,
	HORIZONTAL_TUBE,
	RIGHT_CUP,
	
}

@export var defaultTexture: Sprite2D
@export var hoverTexture: Sprite2D

@warning_ignore("unused_parameter", "shadowed_variable_base_class")
func _getTextureCoordinate(slotPosition: Vector2i, itemSize:Vector2i)->int:#returns a frame index (int)
	var minimums: Vector2i = Vector2i.ZERO
	var maximums: Vector2i = itemSize
	if itemSize == Vector2i.ONE: #if its a 1x1 always has nothing on its sides
		print("standalonePiece")
		return TextureIndex.BOX
	
	if minimums.x == maximums.x:
		return 
	
	
	
	
	return TextureIndex.CENTRE
