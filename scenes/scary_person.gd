extends Node3D

var enemySpeed = 100

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
func _on_scary_body_entered(body: CharacterBody3D) -> void:
	die(body)
func follow_player(delta):
	var player: CharacterBody3D = $"../Player"
	$Scary3.look_at(player.global_position)
	$Scary3.rotation[0] = 0
	var dirVector = (player.global_position - $Scary3.global_position).normalized()
	print(dirVector)
	dirVector[1] = 0
	$Scary3.global_position = $Scary3.global_position + (dirVector * enemySpeed/10000)
func _ready() -> void:
	pass 

func _process(delta: float) -> void:
	follow_player(delta)
