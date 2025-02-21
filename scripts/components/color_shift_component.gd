class_name ColorShiftComponent
extends Node

@export var sprite: Sprite2D
@export var invert: bool = false

func _ready() -> void:
	GameState.colour_shift.connect(self._on_colour_shift)
	self._on_colour_shift(GameState.background_colour)
	
func _on_colour_shift(color: int) -> void:
	if self.invert:
		color = 1 - color
	self.sprite.modulate = Color(color, color, color)
