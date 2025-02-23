class_name Level
extends Node2D

@export var starting_colour: Constants.Colour

func _ready() -> void:
	GameState.background_colour = self.starting_colour
	SignalBus.player_death.connect(_on_player_death)
	
func _on_player_death() -> void:
	get_tree().reload_current_scene()
