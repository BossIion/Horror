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
	
