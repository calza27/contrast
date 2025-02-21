extends CanvasLayer

@onready var _colour_rect: ColorRect = %ColourRect

func _ready() -> void:
	GameState.colour_shift.connect(self._on_colour_shift)
	self._on_colour_shift(GameState.background_colour)
	
func _on_colour_shift(background_colour: int) -> void:
	self._colour_rect.set_color(Color(background_colour, background_colour, background_colour))
