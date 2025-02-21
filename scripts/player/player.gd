class_name Player
extends CharacterBody2D

@export var SPEED: int = 300
@export var DASH_SPEED: int = 450
@export var WALL_PUSH: float = 200
@export var FALL_GLIDE_SPEED: float = 300
@export var TERMINAL_VELOCITY: float = 500
@export var JUMP_VELOCITY: float = -400

@onready var ray_left: RayCast2D = %RayLeft
@onready var ray_right: RayCast2D = %RayRight
@onready var state_machine: PlayerStateMachine = %PlayerStateMachine

func _ready() -> void:
	GameState.colour_shift.connect(self._on_colour_shift)
	self._on_colour_shift(GameState.background_colour)
	self.state_machine.start(self)

func wall_collision(wall_normal_x: float) -> bool:
	if wall_normal_x == 0:
		return false
	if wall_normal_x == 1 && !self.ray_left.is_colliding():
		return false
	if wall_normal_x == -1 && !self.ray_right.is_colliding():
		return false
	return true
	
func _physics_process(_delta: float) -> void:
	self.move_and_slide()

func _on_colour_shift(color: Constants.Colour) -> void:
	if color == Constants.Colour.BLACK:
		self.set_collision_mask_value(2, false)
		self.set_collision_mask_value(3, true)
		self.ray_left.set_collision_mask_value(2, false)
		self.ray_left.set_collision_mask_value(3, true)
		self.ray_right.set_collision_mask_value(2, false)
		self.ray_right.set_collision_mask_value(3, true)
	elif color == Constants.Colour.WHITE:
		self.set_collision_mask_value(2, true)
		self.set_collision_mask_value(3, false)
		self.ray_left.set_collision_mask_value(2, true)
		self.ray_left.set_collision_mask_value(3, false)
		self.ray_right.set_collision_mask_value(2, true)
		self.ray_right.set_collision_mask_value(3, false)
