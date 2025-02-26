class_name PlayerCamera
extends Camera2D

@export var lag: float = 0.75
@export var player: Player
var camera_tween: Tween
var active_marker: Marker2D

func _ready() -> void:
	self.active_marker = self.player.camera_marker
	
func _process(_delta: float) -> void:
	if camera_tween:
		camera_tween.kill()
		
	camera_tween = get_tree().create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
	camera_tween.tween_property(self, "global_position", _get_position_for_camera(), self.lag)

func _get_position_for_camera() -> Vector2:
	return self.active_marker.global_position
