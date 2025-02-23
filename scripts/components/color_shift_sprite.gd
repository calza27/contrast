class_name ColorShiftSprite
extends Node2D

@export var invert: bool = false
const MATERIAL: ShaderMaterial = preload(Constants.FILES["colour_shift_material"])

func _ready() -> void:
	SignalBus.colour_shift.connect(self._on_colour_shift)
	self._on_colour_shift(GameState.background_colour)
	
func _on_colour_shift(color: int) -> void:
	if self.invert:
		color = 1 - color
	if color == 0:
		self.material = MATERIAL
	else:
		self.material = null
