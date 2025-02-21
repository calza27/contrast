class_name PlayerAttack
extends PlayerState

var COMBO_WINDOW_MILLIS: float = 500
var _max_chain: int = 0
var _combo_type: Type
var _curr_chain: int = 0
var _exit_time: int = 0
var debug_mode: bool = false

func enter(previousState: State) -> void:
	super.enter(previousState)
	self._curr_chain += 1
	if !self._within_combo_window() || self._curr_chain == self._max_chain || previousState.get_type() != self._combo_type:
		self._curr_chain = 0
	self._combo_type = previousState.get_type()
	match self._combo_type:
		Type.MOVE || Type.IDLE:
			self._max_chain = 3
		Type.DASH:
			self._max_chain = 1
		Type.FALL:
			self._max_chain = 2
			
	
func exit() -> void:
	self._exit_time = Time.get_ticks_msec()

func physics_update(_delta: float) -> void:
	if debug_mode: print(self._debug())
	var transition_state = self._previous_state.get_type()
	if transition_state == Type.DASH:
		transition_state = Type.MOVE
	self.transition.emit(self, transition_state)
				
func get_type() -> Type:
	return Type.ATTACK

func _within_combo_window() -> bool:
	var curr_time: int = Time.get_ticks_msec()
	var diff: int = curr_time - self._exit_time
	return diff <= self.COMBO_WINDOW_MILLIS

func _debug() -> String:
	return str("Type: ", Type.find_key(self._combo_type), ", _curr_chain: ", self._curr_chain)
