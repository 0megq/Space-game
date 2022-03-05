class_name Player
extends KinematicBody2D

var velocity: Vector2 = Vector2.ZERO

#states
export (NodePath) var state_manager_path
onready var state_manager: Node = get_node(state_manager_path)

#gun
export (float) var fire_rate
export (PackedScene) var bullet_scene
export (int) var max_ammo 
onready var current_ammo: int = max_ammo
var can_shoot: bool = true

export (NodePath) var fire_point_path
onready var fire_point: Position2D = get_node(fire_point_path)


#rotation
onready var child_list = get_children()


func _ready() -> void:
	state_manager.init(self)

	
func _unhandled_input(event: InputEvent) -> void:
	state_manager.input(event)


func _physics_process(delta: float) -> void:
	state_manager.physics_process(delta)
	
	gun()
	
	for node in child_list:
		if node is Node2D:
			var angle: float = get_angle_to(get_global_mouse_position())
			var offset: Vector2 = node.position
			var total_angle: float = angle + node.initial_angle
			node.position = Vector2(offset.length()*cos(total_angle), offset.length()*sin(total_angle))
			node.rotation = angle+PI/2
	
	
func _process(delta: float) -> void:
#	print(state_manager.current_state)
	state_manager.process(delta)


func gun() -> void:
	if Input.is_action_just_pressed("shoot") && current_ammo && can_shoot:
		shoot()
	
	
func shoot() -> void:
	can_shoot = false
	var bullet = bullet_scene.instance()
	
	bullet.position = fire_point.global_position
	bullet.rotation = fire_point.global_rotation
	bullet.linear_velocity = bullet.speed * (get_global_mouse_position()-bullet.position).normalized()
	get_parent().add_child(bullet)
	
	
	yield(get_tree().create_timer(fire_rate), "timeout")
	can_shoot = true
