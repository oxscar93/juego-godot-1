extends KinematicBody2D

signal onPlayerDefeated

enum State {NORMAL, DASH} #Refactorizar a state pattern

export (int) var speed = 100

var target = Vector2()
var velocity = Vector2()
var currentState = State.NORMAL

func _ready():
	hide()
	
func start(pos):
	position = pos
	target = position
	show()
	$CollisionShape2D.disabled = false
	
func _input(event):		
	if event.is_action_pressed('click') and currentState != State.DASH:
		target = get_global_mouse_position()
		
	if event.is_action_pressed('ui_select'):
		currentState = State.DASH
		$DashTimer.start()
	
func _physics_process(delta):
	velocity = (target - position).normalized() * speed
	rotation = velocity.angle()
	
	velocity.rotated(rotation)
	
	if (target - position).length() > 5 and currentState == State.NORMAL:
		move_and_slide(velocity)
	elif (currentState == State.DASH):
		move_and_slide((target - position).normalized() * speed * 3)

func kill():
	emit_signal('onPlayerDefeated')
	hide()
	
func _on_DashTimer_timeout():
	currentState = State.NORMAL


