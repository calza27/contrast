class_name PlayerState
extends State

var _player: Player

enum Type { NONE, IDLE, MOVE, JUMP, FALL, ON_WALL, DASH, ATTACK, DEAD }

func enter(previousState: State) -> void:
	super.enter(previousState)

func input(_event: InputEvent) -> void:
	pass
	
func get_type() -> Type:
	return Type.NONE

func get_gravity_y() -> float:
	var multi: float = 1
	if abs(self.get_player_velocity_y()) <= self._player.HANG_THRESHOLD:
		multi = self._player.HANG_MULTI
	return self._player.get_gravity().y * multi
	
func set_player(player: Player) -> void:
	self._player = player
	
func get_player_velocity() -> Vector2:
	return self._player.velocity

func get_player_direction_x() -> float:
	var speed_x: float = self.get_player_velocity_x()
	if speed_x == 0:
		return 0
	return (speed_x / abs(speed_x))

func get_player_velocity_x() -> float:
	return self._player.velocity.x
	
func set_player_velocity_x(v: float) -> void:
	self._player.velocity.x = v
	
func get_player_velocity_y() -> float:
	return self._player.velocity.y
	
func set_player_velocity_y(v: float) -> void:
	self._player.velocity.y = v
