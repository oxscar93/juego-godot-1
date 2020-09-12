extends CanvasLayer

signal newGame

var score = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()
	
func updateScore():
	score+= 1
	$Score.text = "Score : " + str(score)
		
func show_game_over():
	show_message("Game Over")
	# Wait until the MessageTimer has counted down.
	yield($MessageTimer, "timeout")

	# Make a one-shot timer and wait for it to finish.
	yield(get_tree().create_timer(1), "timeout")
	show_message("Minion 1")
	$StartButton.show()


func _on_StartButton_pressed():
	score = 0
	$StartButton.hide()
	$Message.hide()
	
	_setScoreText(score)
	emit_signal("newGame") # Replace with function body.
	
func _setScoreText(score):
	$Score.text = "Score : " + str(score)
