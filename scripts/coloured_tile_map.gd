@tool
class_name ColouredTileMap
extends TileMapLayer

@export var mode: Constants.Colour:
	set(val):
		mode = val
		if mode == Constants.Colour.GREY:
			_index = 1
		self._on_colour_shift(GameState.background_colour)
const MATERIAL: ShaderMaterial = preload(Constants.FILES["colour_shift_material"])
var _index: int = 0
		
func _ready() -> void:
	self.z_index = self._index
	SignalBus.colour_shift.connect(self._on_colour_shift)
	self._on_colour_shift(GameState.background_colour)

func _on_colour_shift(color: Constants.Colour) -> void:
	self.z_index = -1 if color == self.mode else self._index
