class_name PlayerFall
extends PlayerState

@export var can_double_jump: bool = false
const COYOTE_TIME: float = 0.2
var coytote_timer: float = 0
const JUMP_BUFFER_TIME: float = 0.2
var jump_buffer_timer: float = 0
var _can_dash: bool = true
var _double_jump_ready = true

func _ready() -> void:
	self._double_jump_ready = self.can_double_jump

func enter(previousState: State) -> void:
	super.enter(previousState)
	self.jump_buffer_timer = 0
	self.coytote_timer = 0
	if previousState is PlayerState:
		var previous_player_state: PlayerState = previousState as PlayerState
		if previous_player_state.get_type() == Type.MOVE || previous_player_state.get_type() == Type.ON_WALL:
			self.coytote_timer = self.COYOTE_TIME
	
func physics_update(delta: float) -> void:
	if self.coytote_timer > 0:
		self.coytote_timer -= delta
		
	if self.jump_buffer_timer > 0:
		self.jump_buffer_timer -= delta
	
	if self._player.is_on_floor():
		self._can_dash = true
		_reset_double_jump()
		if self.jump_buffer_timer > 0:
			self.transition.emit(self, Type.JUMP)
		else:
			self.transition.emit(self, Type.IDLE)
		return
		
	if self._player.is_on_wall():
		self._can_dash = true
		_reset_double_jump()
		self.transition.emit(self, Type.ON_WALL)
		return
	
	self.set_player_velocity_y(move_toward(self.get_player_velocity_y(), self._player.TERMINAL_VELOCITY, self.get_gravity_y() * delta))
	var direction: float = Input.get_axis("move_left", "move_right")
	if direction != 0:
		var target_speed = self._player.FALL_GLIDE_SPEED * direction
		if (direction < 0 && self.get_player_velocity_x() > target_speed) || (direction > 0 && self.get_player_velocity_x() < target_speed):
			var rate = self._player.FALL_GLIDE_SPEED * delta
			self.set_player_velocity_x(move_toward(self.get_player_velocity_x(), target_speed, rate))

func input(event: InputEvent) -> void:
	if event.is_action_released("jump") && self.get_player_velocity_y() < 0:
		self.set_player_velocity_y(self.get_player_velocity_y() * self._player.JUMP_CUT_MULTI)
	if event.is_action_pressed("jump"):
		if self.coytote_timer > 0:
			self.transition.emit(self, Type.JUMP)
		elif self._double_jump_ready:
			self._double_jump_ready = false
			self.transition.emit(self, Type.JUMP)
		else:
			self.jump_buffer_timer = self.JUMP_BUFFER_TIME
		return
	if event.is_action_pressed("dash") && self._can_dash:
		self._can_dash = false
		self.transition.emit(self, Type.DASH)
		return
	if event.is_action_pressed("attack"):
		self.transition.emit(self, Type.ATTACK)
		return
		
func get_type() -> Type:
	return Type.FALL
	
func _reset_double_jump() -> void:
	self._double_jump_ready = self.can_double_jump
