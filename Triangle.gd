extends Area2D

const PLAYER = "Circle"
const ACCELERATION_SPEED = 10
const MAX_SPEED = 110

var currentPlayer
var velocity = Vector2()
var playerPosition = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	$TriangleLifetime.start(rand_range(10, 20)) 
	
func init(player, startPosition):
	global_position = startPosition
	currentPlayer = player

func _physics_process(delta):				
	if (currentPlayer != null):		
		if (currentPlayer.position.distance_to(playerPosition) > ACCELERATION_SPEED):			 
			 velocity += (playerPosition - position).normalized() * ACCELERATION_SPEED	
			
		velocity += (playerPosition - position).normalized()			
		playerPosition = currentPlayer.position						
		
		velocity = velocity.clamped(MAX_SPEED)
		
		look_at(playerPosition)
		show()
					
		position += velocity * delta
	
func setPlayer(player):
	currentPlayer = player
			
func _on_TriangleLifetime_timeout():
	queue_free() # Replace with function body.

func _on_Triangle_area_entered(body):
	if (body.get_name() == PLAYER):
		body.kill()
