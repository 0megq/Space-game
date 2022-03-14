extends BaseState

export (float) var max_speed
export (float) var acc
export (NodePath) var idle_node

onready var idle_state: BaseState = get_node(idle_node)

#func enter() -> void:
#	print("fuel")

func physics_process(delta: float) -> BaseState:
	if host.target == Vector2.ZERO:
		return idle_state
	
	var direction = (host.target - host.position).normalized()

	host.velocity = lerp(host.velocity, max_speed * direction.normalized(), acc)

	host.move_and_slide(host.velocity)
	return null

