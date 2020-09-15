extends Area2D

signal onPlayerDefeated

enum State {NORMAL, DASH} #Refactorizar a state pattern

const SPEED = 100
const MIN_MOUSE_DISTANCE = 50
const MIN_DISTANCE = 5

var target = Vector2()
var velocity = Vector2()
var currentState = State.NORMAL

func _ready():
	hide()
	
func start(pos):
	position = pos
	target = position
	show()
	
func _input(event):				
	if currentState != State.DASH:
		target = get_global_mouse_position()
		
	if event.is_action_pressed('ui_select'):
		_executeDash()
	
func _physics_process(delta):	
	var distance = target.distance_to(position)
	var nextPosition = (target - position).normalized()
	
	if (distance < MIN_DISTANCE):
		return 
			
	if (currentState == State.NORMAL):
		velocity = nextPosition * _getSpeed()		
	elif (currentState == State.DASH):
		velocity = nextPosition *_getDashSpeed()
	
	rotation = velocity.angle()
	position += velocity * delta
	
	
func kill():
	emit_signal('onPlayerDefeated')
	hide()
	
func _executeDash():
	var mousePosition = get_global_mouse_position()
	
	if (position.distance_to(mousePosition) > MIN_MOUSE_DISTANCE):
		target = mousePosition
		currentState = State.DASH
		$DashTimer.start()
		
func _getSpeed():
	return SPEED
	
func _getDashSpeed():
	return SPEED * 3
	
func _on_DashTimer_timeout():
	currentState = State.NORMAL
