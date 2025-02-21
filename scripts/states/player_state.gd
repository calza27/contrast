class_name PlayerState
extends State

var _player: Player

enum Type { NONE, IDLE, MOVE, JUMP, FALL, ON_WALL, DEAD }

func enter(previousState: State) -> void:
	super.enter(previousState)

func input(event: InputEvent) -> void:
	pass
	
func get_type() -> Type:
	return Type.NONE

func set_player(player: Player) -> void:
	self._player = player
