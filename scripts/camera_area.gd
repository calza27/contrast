class_name CameraArea
extends Area2D

signal player_entered(CameraArea)
signal player_exited(CameraArea)
@export var mode: Constants.Colour
@onready var camera_point: Marker2D = %CameraPoint

func _ready() -> void:
	self.set_collision_layer_value(self.mode+2, true)
	self.set_collision_mask_value(self.mode+2, true)

func _on_body_entered(_body: Node2D) -> void:
	self.player_entered.emit(self)

func _on_body_exited(_body: Node2D) -> void:
	self.player_exited.emit(self)
