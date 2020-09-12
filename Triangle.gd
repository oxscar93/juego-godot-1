extends KinematicBody2D

signal onPlayerDefeated

var speed = 75
var currentPlayer = null
# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	$TriangleLifetime.start(rand_range(4, 6)) # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (currentPlayer == null):
		return
			
	var playerPosition = currentPlayer.position	
	if (playerPosition != null):
		var velocity = (playerPosition - position).normalized() * speed
		
		look_at(playerPosition)
		if (playerPosition).length() > 5:
			show()
			move_and_slide(velocity)
			_handleCollision()
			
func setPlayer(player):
	currentPlayer = player

func _handleCollision():
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		
		if (collision.collider.name == "Circle"):
			collision.collider.kill()
			
func _on_TriangleLifetime_timeout():
	queue_free() # Replace with function body.
