extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var playerPosition = get_parent().get_node("Circle").position
	
	if (playerPosition != null):
		var velocity = (playerPosition - position).normalized() * 100
		
		look_at(playerPosition)
		if (playerPosition).length() > 5:
			move_and_slide(velocity)
			_handleCollision()
	

func _handleCollision():
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		
		if (collision.collider.name == "Circle"):
			collision.collider.hide()
