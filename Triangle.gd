extends KinematicBody2D

var speed = 75

# Called when the node enters the scene tree for the first time.
func _ready():
	$TriangleLifetime.start(rand_range(4, 6)) # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var playerPosition = get_parent().get_node("Circle").position
	
	if (playerPosition != null):
		var velocity = (playerPosition - position).normalized() * speed
		
		look_at(playerPosition)
		if (playerPosition).length() > 5:
			move_and_slide(velocity)
			_handleCollision()
	

func _handleCollision():
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		
		if (collision.collider.name == "Circle"):
			collision.collider.hide()


func _on_TriangleLifetime_timeout():
	queue_free() # Replace with function body.
