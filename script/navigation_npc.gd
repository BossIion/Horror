extends CharacterBody3D

@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D
var speed = 1.0

func _physics_process(delta: float) -> void:
	$".".look_at($"../Player".global_position)
	$".".rotation[0] = 0
	navigation_agent_3d.set_target_position($"../Player".position)
	var destination = navigation_agent_3d.get_next_path_position()
	var local_destination = destination - global_position
	var direction = local_destination.normalized()
	
	velocity = direction * speed
	move_and_slide()
	
func die(body):
	if body.name == "Player":
		var root = get_tree().get_root()
		var screen = $"../Death_Screen"
		screen.visible = true
		$AudioStreamPlayer3D.play()
		await get_tree().create_timer(2).timeout
		screen.visible = false
		get_tree().reload_current_scene()
		if Input.is_anything_pressed() == true:
			pass


func _on_area_3d_body_entered(body: Node3D) -> void:
	die(body)
