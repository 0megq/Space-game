class_name Enemy
extends KinematicBody2D

var velocity: Vector2 = Vector2.ZERO

onready var player = get_tree().get_root().get_child(0).get_player()

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
var look_direction: Vector2 = Vector2.ZERO
var target: Vector2 = Vector2.ZERO
var detected: bool = false

func _ready() -> void:
	state_manager.init(self)

func _physics_process(delta: float) -> void:
	state_manager.physics_process(delta)
	
	if detected:
		target = player.position
		look_direction = target
	else:
		target = Vector2.ZERO
	
	for node in child_list:
		if node is Node2D:
			var angle: float = get_angle_to(look_direction)
			var offset: Vector2 = node.position
			var total_angle: float = angle + node.initial_angle
			node.position = Vector2(offset.length()*cos(total_angle), offset.length()*sin(total_angle))
			node.rotation = angle+PI/2
	
	
func _process(delta: float) -> void:
#	print(state_manager.current_state)
	state_manager.process(delta)


func _on_Detection_body_entered(body: Node) -> void:
	if body is Player:
		detected = true


func _on_Detection_body_exited(body: Node) -> void:
	if body is Player:
		detected = false
	
