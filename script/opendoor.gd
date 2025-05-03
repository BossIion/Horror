extends Node3D
func _on_body_entered(body):
	print("Body entered: ", body.name)  # Debugging: print the body name
	if body.name == "Key":  # Check if the body is the player
		queue_free()
