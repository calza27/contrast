class_name CameraRegister
extends Node

@export var player_camera: PlayerCamera
@export var camera_areas: Array[CameraArea]

func _ready() -> void:
	for area in self.camera_areas:
		area.player_entered.connect(_on_player_entered_area)
		area.player_exited.connect(_on_player_exited_area)
		
func _on_player_entered_area(area: CameraArea) -> void:
	self.player_camera.active_marker = area.camera_point
	
func _on_player_exited_area(_area: CameraArea) -> void:
	self.player_camera.active_marker = Utils.get_player().camera_marker
