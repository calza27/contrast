class_name PlayerMove
extends PlayerState

const ACCELERATION: float = 1.0
const TURN_RATE: float = 5.0

func enter(previousState: State) -> void:
	super.enter(previousState)

func physics_update(delta: float) -> void:
	if !self._player.is_on_floor():
		self.transition.emit(self, Type.FALL)
		return
		
	var input_direction: float = Input.get_axis("move_left", "move_right")
	if input_direction == 0:
		self.transition.emit(self, Type.IDLE)
		return
		
	var rate = self._player.SPEED * self.ACCELERATION * delta
	var curr_direction: float = 0
	if self.get_player_velocity_x() != 0:
		curr_direction = self.get_player_velocity_x() / abs(self.get_player_velocity_x())
	if curr_direction == input_direction * -1:
		rate *= self.TURN_RATE
		
	var target_speed = self._player.SPEED * input_direction
	self.set_player_velocity_x(move_toward(self.get_player_velocity_x(), target_speed, rate))

func input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		self.transition.emit(self, Type.JUMP)
		return
	if event.is_action_pressed("dash"):
		self.transition.emit(self, Type.DASH)
		return
	if event.is_action_pressed("attack"):
		self.transition.emit(self, Type.ATTACK)
	pass
			
func get_type() -> Type:
	return Type.MOVE
