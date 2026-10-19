class_name Slot extends TextureButton

#-----enums-----

#-----sub-components-----
@export_category("Sub-Components")
@export var defaultTexture: TextureRect

#-----signals-----

#-----variables-----
@export_category("Variables")
@export var scaleMax: Vector2 = Vector2(5.0, 5.0)
var tween: Tween


#-----private-----

func _resetTween()->void:
	if tween != null:
		tween.kill()
	tween = create_tween().bind_node(self)
	tween.set_ease(Tween.EASE_IN_OUT)

#-----public-----

#-----signal responses-----

func on_mouse_entered() -> void:
	_resetTween()
	tween.tween_property(defaultTexture, "modulate", Color(1.0, 1.0, 1.0, 0.0), 0.2)

func on_mouse_exited() -> void:
	_resetTween()
	tween.tween_property(defaultTexture, "modulate", Color(1.0, 1.0, 1.0, 1.0), 0.2)
