class_name Player
extends CharacterBody2D

@export var SPEED: int = 300
@export var DASH_MULTI: float = 1.5
@export var WALL_PUSH: float = 200
@export var FALL_GLIDE_SPEED: float = 300
@export var TERMINAL_VELOCITY: float = 600
@export var JUMP_VELOCITY: float = -450
@export var JUMP_CUT_MULTI: float = 0.5
@export var HANG_THRESHOLD: float = 50
@export var HANG_MULTI: float = 0.75
@export var JUMP_SHIFT_DISTANCE: int = 8
@export var CAMERA_LEDGE_TIMEOUT: float = 1.0
var _ray_casts: Array = []
var _camera_ledge_timer: float = 0 
@onready var ray_left: RayCast2D = %RayLeft
@onready var ray_right: RayCast2D = %RayRight
@onready var upper_outer_left: RayCast2D = %UpperOuterLeft
@onready var upper_inner_left: RayCast2D = %UpperInnerLeft
@onready var upper_inner_right: RayCast2D = %UpperInnerRight
@onready var upper_outer_right: RayCast2D = %UpperOuterRight
@onready var lower_outer_right: RayCast2D = %LowerOuterRight
@onready var lower_outer_left: RayCast2D = %LowerOuterLeft
@onready var player_sprite: ColorShiftSprite = %PlayerSprite
@onready var state_machine: PlayerStateMachine = %PlayerStateMachine
@onready var camera_marker: Marker2D = %CameraMarker

func _ready() -> void:
	SignalBus.colour_shift.connect(self._on_colour_shift)
	self._on_colour_shift(GameState.background_colour)
	self.state_machine.start(self)
	self._ray_casts.append(ray_left)
	self._ray_casts.append(ray_right)
	self._ray_casts.append(upper_outer_left)
	self._ray_casts.append(upper_inner_left)
	self._ray_casts.append(upper_inner_right)
	self._ray_casts.append(upper_outer_right)
	self._ray_casts.append(lower_outer_right)
	self._ray_casts.append(lower_outer_left)
	self._reset_camera_point()

func wall_collision(wall_normal_x: float) -> bool:
	if wall_normal_x == 0:
		return false
	if wall_normal_x == 1 && !self.ray_left.is_colliding():
		return false
	if wall_normal_x == -1 && !self.ray_right.is_colliding():
		return false
	return true
	
func can_shift_past_overhead_wall() -> Constants.Direction:
	if upper_inner_left.is_colliding() && !upper_outer_left.is_colliding():
		return Constants.Direction.LEFT
	if upper_inner_right.is_colliding() && !upper_outer_right.is_colliding():
		return Constants.Direction.RIGHT
	return Constants.Direction.NONE
	
func can_look_over_ledge() -> Constants.Direction:
	if !lower_outer_left.is_colliding() && lower_outer_right.is_colliding() && self.player_sprite.scale.x == -1:
		return Constants.Direction.LEFT
	if !lower_outer_right.is_colliding() && lower_outer_left.is_colliding() && self.player_sprite.scale.x == 1:
		return Constants.Direction.RIGHT
	return Constants.Direction.NONE
	
func _physics_process(delta: float) -> void:
	if self.velocity.x != 0:
		self.player_sprite.scale.x = (self.velocity.x / abs(self.velocity.x))
	self.move_and_slide()
	
	if !self.can_look_over_ledge():
		self._camera_ledge_timer = 0
		self._reset_camera_point()
	else:
		if self._camera_ledge_timer <= 0:
			self._camera_ledge_timer = self.CAMERA_LEDGE_TIMEOUT
		else:
			self._camera_ledge_timer -= delta
			if self._camera_ledge_timer <= 0:
				self._camera_ledge_shift()

func _on_colour_shift(color: Constants.Colour) -> void:
	if color == Constants.Colour.BLACK:
		self.set_collision_mask_value(2, false)
		self.set_collision_mask_value(3, true)
		for ray in self._ray_casts:
			ray.set_collision_mask_value(2, false)
			ray.set_collision_mask_value(3, true)
	elif color == Constants.Colour.WHITE:
		self.set_collision_mask_value(2, true)
		self.set_collision_mask_value(3, false)
		for ray in self._ray_casts:
			ray.set_collision_mask_value(2, true)
			ray.set_collision_mask_value(3, false)
			
func _camera_ledge_shift() -> void:
	self.camera_marker.position.x = 20
	self.camera_marker.position.y = 40

func _reset_camera_point() -> void:
	self.camera_marker.position.x = 5
	self.camera_marker.position.y = 1
