extends Node3D

@export var move_speed: float = 10.0
@export var turn_speed: float = 2.0
@export var ground_offset: float = 0.5

@onready var left_center_down: Marker3D = $LeftCenterDown
@onready var left_down: Marker3D = $LeftDown
@onready var left_up: Marker3D = $LeftUp
@onready var right_center_up: Marker3D = $RightCenterUp
@onready var left_center_up: Marker3D = $LeftCenterUp
@onready var right_down: Marker3D = $RightDown
@onready var right_center_down: Marker3D = $RightCenterDown
@onready var right_up: Marker3D = $RightUp

func _process(delta):
	var plane1 = Plane(left_down.global_position, left_up.global_position, right_up.global_position)
	var plane2 = Plane(right_up.global_position, right_down.global_position, left_down.global_position)
	var avg_normal = ((plane1.normal + plane2.normal) / 2).normalized()
	
	var target_basis = _basis_from_normal(avg_normal)
	transform.basis = lerp(transform.basis.orthonormalized(), target_basis.orthonormalized(), move_speed * delta).orthonormalized()
	
	var avg = (left_up.position + right_up.position + left_down.position + right_down.position) /4
	var target_pos = avg + transform.basis.y * ground_offset
	var distance = transform.basis.y.dot(target_pos - position)
	position = lerp(position, position + transform.basis.y * distance, move_speed * delta)
	
	_handle_movement(delta)
	
func _handle_movement(delta):
	var dir = Input.get_axis('ui_down', 'ui_up')
	translate(Vector3(0, 0, -dir) * move_speed * delta)
	
	var a_dir = Input.get_axis('ui_right', 'ui_left')
	rotate_object_local(Vector3.UP, a_dir * turn_speed * delta)
func _basis_from_normal(normal: Vector3) -> Basis:
	var result = Basis()
	result.x = normal.cross(transform.basis.z)
	if result.x.x == 0:
		result.x.x = 0.01
	if result.x.y == 0:
		result.x.y = 0.01
	if result.x.z == 0:
		result.x.z = 0.01
	result.y = normal
	if result.y.x == 0:
		result.y.x = 0.01
	if result.y.y == 0:
		result.y.y = 0.01
	if result.y.z == 0:
		result.y.z = 0.01
	result.z = transform.basis.x.cross(normal)
	if result.z.x == 0:
		result.z.x = 0.01
	if result.z.y == 0:
		result.z.y = 0.01
	if result.z.z == 0:
		result.z.z = 0.01
	if scale.x == 0:
		scale.x = 0.01
	if scale.y == 0:
		scale.y = 0.01
	if scale.z == 0:
		scale.z = 0.01
	result.x *= scale.x
	result.y *= scale.y
	result.z *= scale.z
	
	return result
