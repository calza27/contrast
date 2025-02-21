extends Node

func get_node_for_group(group: Constants.Group) -> Node:
	return get_tree().get_first_node_in_group(group_name_for_group(group))
	
func get_player() -> Player:
	return get_node_for_group(Constants.Group.PLAYER) as Player
	
func group_name_for_group(group: Constants.Group) -> String:
	match group:
		Constants.Group.PLAYER:
			return "player"
		Constants.Group.BLACK:
			return "black"
		Constants.Group.WHITE:
			return "white"
		Constants.Group.GREY:
			return "grey"
	return ""
