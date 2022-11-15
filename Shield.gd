extends Area2D

var shield_state
signal shield_unavailable
signal shield_ready
signal shield_active


# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	shield_state = "ready"
	$CollisionShape2D.set_disabled(true)


func _process(_delta):
	if Input.is_action_pressed("activate_shield") and shield_state == "ready":
		$ShieldActivatedSound.play()
		$CollisionShape2D.set_disabled(false)
		show()
		$ShieldActive.start()
		shield_state = "unavailable"
		emit_signal("shield_active")


func _on_ShieldActive_timeout():
	hide()
	$ShieldSleep.start()
	$CollisionShape2D.set_disabled(true)
	emit_signal("shield_unavailable")


func _on_ShieldSleep_timeout():
	# after 10 seconds the shield is ready to use again
	shield_state = "ready"
	emit_signal("shield_ready")
	$ShieldReadySound.play()


func _on_Player_hit():
	$ShieldSleep.stop()
	shield_state = "ready"
