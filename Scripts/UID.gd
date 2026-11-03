class_name UID extends Node

static var inventoryCount: int = 0

static func GENERATEINVENTORYINDEX()->int:
	inventoryCount += 1
	var nextUID = hash(inventoryCount)
	return nextUID
