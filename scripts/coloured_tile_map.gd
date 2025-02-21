@tool
class_name ColouredTileMap
extends TileMapLayer

@export var mode: Constants.Colour:
	set(val):
		mode = val
		self._on_colour_shift(GameState.background_colour)
		
func _ready() -> void:
	GameState.colour_shift.connect(self._on_colour_shift)
	self._on_colour_shift(GameState.background_colour)

func _on_colour_shift(color: int) -> void:
	self.visible = (color != self.mode)
