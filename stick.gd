extends CharacterBody2D


var health = 3

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * 600
	move_and_slide()
	rotate(0.015)


func take_damage():
	health -= 1
	if health == 0:
		queue_free()
