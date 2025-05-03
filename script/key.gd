extends Area3D

# Variable to hold the player's position relative to the key
var player: Node3D = null
var offset: Vector3 = Vector3(0, 0.5, -1)  # Adjust the offset as necessary

# Called when the node enters the scene tree for the first time
func _ready():
	print("Key script is running")
	body_entered.connect(_on_body_entered)

# Called when a body enters the area
func _on_body_entered(body):
	print("Body entered: ", body.name)  # Debugging: print the body name
	if body.name == "Player":  # Check if the body is the player
		print("Player detected!")
		call_deferred("_pickup_key", body)  # Call deferred function to pickup the key

# Handle the pickup logic
func _pickup_key(body):
	if not body:
		print("No body detected!")  # Debugging
		return

	print("Picking up the key!")  # Debugging
	player = body  # Store the player node so we can track its position

	# Ensure the key is no longer part of the main scene tree
	set_as_top_level(true)  # Remove key from the world scene tree

	# Temporarily remove the key from its parent (world)
	get_parent().remove_child(self)  # Remove from the world scene tree

	# Attach the key to the player (or their item holder if present)
	body.add_child(self)  # Attach the key directly to the player

	# Now, the key is attached, and its position will be updated in the _process function
	print("Key attached to Player")

	# Call the player's pickup_key() method if it exists
	if body.has_method("pickup_key"):
		body.pickup_key()  # Call the method on the player to handle key pickup logic

# Called every frame, this will update the key's position
func _process(_delta):
	if player:
		# Continuously update the key's position relative to the player
		var target_position = player.global_transform.origin + player.global_transform.basis * offset
		global_transform.origin = target_position  # Update the key's position every frame
