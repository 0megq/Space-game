extends BaseState

export (float) var deacc
export (NodePath) var fuel_node

onready var fuel_state: BaseState = get_node(fuel_node)

#func enter() -> void:
#	print("idle")

func input(event: InputEvent) -> BaseState:
	var direction = Vector2.ZERO
	#code
	
	if direction != Vector2.ZERO:
		return fuel_state
	
	return null

func physics_process(delta: float) -> BaseState:
	host.velocity = lerp(host.velocity, Vector2.ZERO, deacc)
	host.move_and_slide(host.velocity)
	return null
	
