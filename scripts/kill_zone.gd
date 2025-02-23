class_name KillZone
extends Area2D

@export var mode: Constants.Colour
@onready var timer: Timer = %Timer

func _ready() -> void:
	self.set_collision_layer_value(self.mode+2, true)
	self.set_collision_mask_value(self.mode+2, true)

func _on_body_entered(body: Node2D) -> void:
	if mode != GameState.background_colour:
		timer.start()

func _on_timer_timeout() -> void:
	SignalBus.player_death.emit()
