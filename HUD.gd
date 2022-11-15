extends CanvasLayer

signal start_game

func _ready():
	$ScoreLabel.hide()

func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()


func show_game_over():
	show_message("Τέλος")
	yield($MessageTimer, "timeout")
	$Message.text = "Απέφυγε τα σκόρδα"
	$Message.show()
	yield(get_tree().create_timer(1), "timeout")
	$StartButton.show()


func update_score(score):
	$ScoreLabel.text = "Σκορ: " + str(score)


func _on_StartButton_pressed():
	$ScoreLabel.show()
	$StartButton.hide()
	emit_signal("start_game")


func _on_MessageTimer_timeout():
	$Message.hide()
