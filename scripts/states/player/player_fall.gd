class_name PlayerFall
extends PlayerState

func enter(previousState: State) -> void:
	super.enter(previousState)
	
func physics_update(delta: float) -> void:
	if self._player.is_on_floor():
		self.transition.emit(self, Type.IDLE)
		return
		
	if self._player.is_on_wall():
		self.transition.emit(self, Type.ON_WALL)
		return
	
	self._player.velocity.y = move_toward(self._player.velocity.y, self._player.TERMINAL_VELOCITY, self._player.get_gravity().y * delta)

func input(event: InputEvent) -> void:
	#if event.is_action_pressed("attack"):
		#self.transition.emit(self, Type.ATTACK)
	pass
		
func get_type() -> Type:
	return Type.FALL
