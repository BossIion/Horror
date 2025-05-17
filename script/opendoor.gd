
extends Node3D
var animation_player: AnimationPlayer
func _ready():
	animation_player = $DoorSwing
	$DoorArea.area_entered.connect(_on_area_entered)
func _on_area_entered(area):
	if area.name == "Key":
		print("Key detected at door!")
		open_door()
func open_door():
	animation_player.play("DoorSwing")
	
var Key_Touched = false
func _on_body_entered(body):	
	print("Body entered: ", body.name)  # Debugging: print the body name
	if body.name == "Player":  # Check if the body is the player
		for i in range(0,91):
			$PivotPoin.rotation = Vector3(0, -deg_to_rad(i),0)
			$CollisionShape3D.rotation = $PivotPoint/CSGBox3D.rotation
			$CollisionShape3D.global.position = $PivotPoint/CSGBox3D.global.position
			await get_tree().create_timer(0.1).timeout
		$PivotPoin.rotation = Vector3(0, -deg_to_rad(-90),0)
		$CollisionShape3D.rotation = $PivotPoint/CSGBox3D.rotation
		$CollisionShape3D.global.position = $PivotPoint/CSGBox3D.global.position

		
