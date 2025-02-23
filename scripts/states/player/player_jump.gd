class_name PlayerJump
extends PlayerState

func enter(previousState: State) -> void:
	super.enter(previousState)
	if previousState.get_type() != Type.ON_WALL:
		var direction: float = Input.get_axis("move_left", "move_right")
		if direction != 0:
			var target_speed = self._player.SPEED * 0.5 * direction
			if (direction < 0 && self.get_player_velocity_x() > target_speed) || (direction > 0 && self.get_player_velocity_x() < target_speed):
				self.set_player_velocity_x(self._player.SPEED * 0.5 * direction)
	
func physics_update(_delta: float) -> void:
	self.set_player_velocity_y(self._player.JUMP_VELOCITY)
	self.transition.emit(self, Type.FALL)

func get_type() -> Type:
	return Type.JUMP
