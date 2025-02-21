class_name PlayerOnWall
extends PlayerState

const WALL_FRICTION: float = 0.5

func enter(previousState: State) -> void:
	super.enter(previousState)
	if self._player.velocity.y < 0:
		self._player.velocity.y = 0
	
func physics_update(delta: float) -> void:
	if self._player.is_on_floor():
		self.transition.emit(self, Type.IDLE)
		return
	
	var wall_normal: float = self._player.get_wall_normal().x
	var direction: float = Input.get_axis("move_left", "move_right")
	if direction == wall_normal:
		self._player.velocity.x = self._player.WALL_PUSH * wall_normal
		self.transition.emit(self, Type.MOVE)
		return
		
	var fall_speed: float = self._player.TERMINAL_VELOCITY
	var fall_rate: float = self._player.get_gravity().y * delta
	if -1 * direction == wall_normal:
		fall_speed *= WALL_FRICTION
		fall_rate *= WALL_FRICTION
	self._player.velocity.y = move_toward(self._player.velocity.y, fall_speed, fall_rate)

func input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		var wall_normal: float = self._player.get_wall_normal().x
		self._player.velocity.x = self._player.SPEED * wall_normal
		self.transition.emit(self, Type.JUMP)
		return

func get_type() -> Type:
	return Type.ON_WALL
