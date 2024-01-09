extends Node2D



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	%HealthBar.value = $Stick.health



func _on_stick_health_depleted():
	%GameOver.visible = true
	%HealthBar.value = $Stick.health	
	get_tree().paused = true
