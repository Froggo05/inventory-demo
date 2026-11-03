class_name UID extends Node

static var inventoryCount: int = 0

static func GENERATEINVENTORYINDEX()->int:
	inventoryCount += 1
	var nextIUID = hash(rand_from_seed(inventoryCount))
	return nextIUID
