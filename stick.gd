extends CharacterBody2D


var health = 1
signal health_depleted
var is_invincible = false
var lerp_speed : float = 0.5
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * 600
	move_and_slide()
	rotate(0.015)

	
	var damage_contact_left = %HurtBoxLeft.get_overlapping_bodies()
	var damage_contact_right = %HurtBoxRight.get_overlapping_bodies()
	
	if (damage_contact_left.size() > 0 || damage_contact_right.size() > 0) && is_invincible == false: 
		health -= 10000
		knockback(delta)
		if health == 0:
			health_depleted.emit()


func knockback(delta):
	var current_rotation_degrees: float = rotation_degrees
	var new_rotation_degrees: float = lerp(current_rotation_degrees, current_rotation_degrees - 35, 105 * delta)
	rotation_degrees=new_rotation_degrees
	start_invincibility()

func _on_invincibility_timer_timeout():
	is_invincible = false

func start_invincibility():
	is_invincible = true
	%Invincibility_Timer.start()
