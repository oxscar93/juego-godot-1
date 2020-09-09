extends Node2D

var target = Vector2()
var velocity = Vector2()
var diamond = preload("res://Diamond.tscn")
var triangle = preload("res://Triangle.tscn")
var diamondCount = 20
var triangleCount = 5
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	_initializeEnemies() # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_DiamondTimer_timeout():
	_initializeDiamonds()

func _on_TriangleTimer_timeout():	
	_initializeEnemies()
	
func _initializeDiamonds():
	for i in range(diamondCount):
		var new_diamond = diamond.instance()
	
		new_diamond.global_position.x = rand_range(0, 1000)
		new_diamond.global_position.y = rand_range(0, 600)

		new_diamond.connect("onDiamondRecolected", self, "_on_Circle_onDiamondRecolected")
		
		add_child(new_diamond) 
		
func _initializeEnemies():
	for i in range(triangleCount):
		var new_triangle = triangle.instance()
	
		new_triangle.global_position.x = rand_range(0, 1000)
		new_triangle.global_position.y = rand_range(0, 600)

		add_child(new_triangle) 


func _on_Circle_onDiamondRecolected():
	$HUD.updateScore() 
