class_name PlayerJump
extends PlayerState

func enter(previousState: State) -> void:
	super.enter(previousState)
	
func physics_update(_delta: float) -> void:
	self._player.velocity.y = self._player.JUMP_VELOCITY
	self.transition.emit(self, Type.FALL)
	
func get_type() -> Type:
	return Type.JUMP
