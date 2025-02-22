class_name Level
extends Node2D

@export var starting_colour: Constants.Colour

func _ready() -> void:
	GameState.background_colour = self.starting_colour
