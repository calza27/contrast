class_name PlayerIdle
extends PlayerState

const DECCELERATION = 0.05
func enter(previousState: State) -> void:
	super.enter(previousState)

func physics_update(_delta: float) -> void:
	if !self._player.is_on_floor():
		self.transition.emit(self, Type.FALL)
		return
		
	if Input.get_axis("move_left", "move_right") != 0:
		self.transition.emit(self, Type.MOVE)
		return
	
	if Input.is_action_pressed("jump"):
		self.transition.emit(self, Type.JUMP)
		return
		
	var rate = self._player.SPEED * DECCELERATION
	self.set_player_velocity_x(move_toward(self.get_player_velocity_x(), 0, rate))

func input(event: InputEvent) -> void:
	if event.is_action_pressed("attack"):
		self.transition.emit(self, Type.ATTACK)
	pass
	
func get_type() -> Type:
	return Type.IDLE
