extends BaseState

export (float) var deacc
export (NodePath) var fuel_node

onready var fuel_state: BaseState = get_node(fuel_node)

func physics_process(delta: float) -> BaseState:
	host.velocity = lerp(host.velocity, Vector2.ZERO, deacc)
	host.move_and_slide(host.velocity)
	if host.target != Vector2.ZERO:
		return fuel_state
	
	return null
	
