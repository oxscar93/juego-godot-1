extends Area2D

const PLAYER = "Circle"

var speed = 100
var acceleration = 0.8
var currentPlayer = null
var velocity = Vector2()
var playerPosition = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	$TriangleLifetime.start(rand_range(4, 6)) 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (currentPlayer == null):
		return
		
	if (playerPosition != null):
		var newSpeed = speed
		
		if (playerPosition.y != currentPlayer.position.y and playerPosition.x != currentPlayer.position.x):
			 newSpeed = speed * acceleration
		
		playerPosition = currentPlayer.position				
		velocity = (playerPosition - position).normalized() * newSpeed	
		
		look_at(playerPosition)
		show()		

func _physics_process(delta):			
	position += velocity * delta
	
func setPlayer(player):
	currentPlayer = player
			
func _on_TriangleLifetime_timeout():
	queue_free() # Replace with function body.

func _on_Triangle_area_entered(area):
	if (area.get_name() == PLAYER):
		area.kill()
