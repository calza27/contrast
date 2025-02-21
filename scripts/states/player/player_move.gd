class_name PlayerMove
extends PlayerState

const ACCELERATION: float = 1

func enter(previousState: State) -> void:
	super.enter(previousState)

func physics_update(delta: float) -> void:
	if !self._player.is_on_floor():
		self.transition.emit(self, Type.FALL)
		return
		
	if Input.is_action_pressed("jump"):
		self.transition.emit(self, Type.JUMP)
		return
		
	var direction: float = Input.get_axis("move_left", "move_right")
	if direction == 0:
		self.transition.emit(self, Type.IDLE)
		return
	
	var target_speed = self._player.SPEED * direction
	var rate = self._player.SPEED * ACCELERATION * delta
	self._player.velocity.x = move_toward(self._player.velocity.x, target_speed, rate)

func input(event: InputEvent) -> void:
	#if event.is_action_pressed("attack"):
		#self.transition.emit(self, Type.ATTACK)
	pass
			
func get_type() -> Type:
	return Type.MOVE
