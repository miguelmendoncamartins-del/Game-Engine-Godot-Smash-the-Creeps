extends CharacterBody3D

# Minimum speed of the mob in meters per second.
@export var min_speed = 10
# Maximum speed of the mob in meters per second.
@export var max_speed = 18

# Emitted when the player jumped on the mob.
signal squashed


func _physics_process(_delta):
	move_and_slide()


# This function will be called from the Main scene.
func initialize(start_position, player_position):
	# Position and rotate towards player
	look_at_from_position(start_position, player_position, Vector3.UP)

	# Random rotation
	rotate_y(randf_range(-PI / 4, PI / 4))

	# Random speed
	var random_speed = randi_range(min_speed, max_speed)

	# Forward velocity
	velocity = Vector3.FORWARD * random_speed

	# Rotate velocity to match direction
	velocity = velocity.rotated(Vector3.UP, rotation.y)


func _on_visible_on_screen_notifier_3d_screen_exited():
	queue_free()


func squash():
	squashed.emit()
	queue_free()
