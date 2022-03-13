extends BaseState

export (float) var max_speed
export (float) var acc
export (NodePath) var idle_node

onready var idle_state: BaseState = get_node(idle_node)

#func enter() -> void:
#	print("fuel")

func physics_process(delta: float) -> BaseState:
	var direction = get_move_input()
	
	if direction == Vector2.ZERO:
		return idle_state

	host.velocity = lerp(host.velocity, max_speed * direction.normalized(), acc)

	host.move_and_slide(host.velocity)
	return null

func get_move_input() -> Vector2:
	var direction = Vector2.ZERO
	if Input.is_action_pressed("move_left"):
		direction.x += -1
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_up"):
		direction.y += -1
	if Input.is_action_pressed("move_down"):
		direction.y += 1
	return direction
