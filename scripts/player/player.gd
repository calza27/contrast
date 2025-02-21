class_name Player
extends CharacterBody2D

@export var SPEED: int = 200
@export var WALL_PUSH: float = 100
@export var TERMINAL_VELOCITY: float = 250
@export var JUMP_VELOCITY: float = -400

@onready var state_machine: PlayerStateMachine = %PlayerStateMachine

func _ready() -> void:
	GameState.colour_shift.connect(self._on_colour_shift)
	self._on_colour_shift(GameState.background_colour)
	self.state_machine.start(self)

func _physics_process(_delta: float) -> void:
	self.move_and_slide()

func _on_colour_shift(color: int) -> void:
	if color == 0:
		self.set_collision_mask_value(2, false)
		self.set_collision_mask_value(3, true)
	elif color == 1:
		self.set_collision_mask_value(2, true)
		self.set_collision_mask_value(3, false)
