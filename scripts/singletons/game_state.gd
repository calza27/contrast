extends Node

signal colour_shift(color: int)

var background_colour: Constants.Colour = Constants.Colour.WHITE

func flip_color() -> void:
	if background_colour == Constants.Colour.WHITE:
		background_colour = Constants.Colour.BLACK
	else:
		background_colour = Constants.Colour.WHITE
	colour_shift.emit(background_colour)
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("colour_shift"):
		flip_color()
