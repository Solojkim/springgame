extends CharacterBody2D

var health = 5
var rotation_speed = 0.015
var isDamaged = false
var leftDamaged = false
var rightDamaged = false

signal health_depleted

var is_invincible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * 600
	move_and_slide()
	rotate(rotation_speed)
	
	if isDamaged && !is_invincible:
		start_invincibility()
		health -= 1
		if health == 0:
			health_depleted.emit()
		if leftDamaged:
			knockback(delta, 1) #for rotation direction
			leftDamaged = false
		if rightDamaged:
			knockback(delta, -1)
			rightDamaged = false
		isDamaged = false


func knockback(delta, isLeft):
	var current_rotation_degrees: float = rotation_degrees
	var new_rotation_degrees: float = lerp(current_rotation_degrees, current_rotation_degrees - (isLeft)*35, 105 * delta)
	rotation_degrees=new_rotation_degrees


func reverse_rotation():
	rotation_speed = rotation_speed*-1

func _on_invincibility_timer_timeout():
	is_invincible = false

func start_invincibility():
	is_invincible = true
	%Invincibility_Timer.start()


func _on_left_hurt_box_body_entered(body):
	var layer = body.get_collision_layer_svalue()
	if layer == 2: #is a wall
		isDamaged = true
		leftDamaged = true
	
	elif layer == 3: #is a spring
		reverse_rotation()


func _on_right_hurt_box_body_entered(body):
	var layer = body.get_collision_layer_value()
	if layer == 2: #is a wall
		isDamaged = true
		rightDamaged = true
	
	elif layer == 3: #is a spring
		reverse_rotation()	
