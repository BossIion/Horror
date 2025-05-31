extends Node3D
func die(body):
	if body.name == "Player":
		var root = get_tree().get_root()
		var screen = $"../Death_Screen"

		screen.visible = true

func _on_scary_body_entered(body: Node3D) -> void:
	die(body)
