class_name PlayerDash
extends PlayerState

const DASH_TIME: float = 0.25
var timer: float = 0

func enter(previousState: State) -> void:
	super.enter(previousState)
	self.timer = DASH_TIME
	self.set_player_velocity_y(0)
	var speed: float = self._player.DASH_SPEED
	if self.get_player_velocity_x() < 0:
		speed *= -1
	self.set_player_velocity_x(speed)
	
func exit() -> void:
	var speed: float = self._player.SPEED
	if self.get_player_velocity_x() < 0:
		speed *= -1
	self.set_player_velocity_x(speed)

func physics_update(delta: float) -> void:
	self.timer -= delta
	if self.timer <= 0:
		self.transition.emit(self, Type.MOVE)

func input(event: InputEvent) -> void:
	if event.is_action_pressed("attack"):
		self.transition.emit(self, Type.ATTACK)
	pass
				
func get_type() -> Type:
	return Type.DASH
