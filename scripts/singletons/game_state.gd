extends Node

var background_colour: Constants.Colour = Constants.Colour.WHITE:
	set(c):
		background_colour = c
		SignalBus.colour_shift.emit(background_colour)

func flip_color() -> void:
	if background_colour == Constants.Colour.WHITE:
		background_colour = Constants.Colour.BLACK
	else:
		background_colour = Constants.Colour.WHITE
	SignalBus.colour_shift.emit(background_colour)
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("colour_shift"):
		flip_color()
