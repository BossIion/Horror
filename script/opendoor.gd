
extends Node3D
var animation_player: AnimationPlayer
func _ready():
	animation_player = $DoorSwing
	$DoorArea.area_entered.connect(_on_area_entered)
func _on_area_entered(area):
	if area.name == "Key":
		open_door()
		area.queue_free()
		$DoorArea/CollisionShape3D.queue_free()
func open_door():
	animation_player.play("DoorSwing")
	
var Key_Touched = false
