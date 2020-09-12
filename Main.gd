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
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _new_game():
	$StartTimer.start()
	
func game_over():
	$TriangleTimer.stop()
	$DiamondTimer.stop()	
	$HUD.show_game_over()
	
	_clearGame()
		
func _on_DiamondTimer_timeout():
	_initializeDiamonds()

func _on_TriangleTimer_timeout():	
	_initializeEnemies()
	
func _initializePlayer():
	$Circle.start($StartPosition.position)
	
func _initializeDiamonds():
	for i in range(diamondCount):
		var new_diamond = diamond.instance()
	
		new_diamond.global_position.x = rand_range(0, 1000)
		new_diamond.global_position.y = rand_range(0, 600)

		new_diamond.connect("onDiamondRecolected", self, "_onDiamond_Recolected")
		
		add_child(new_diamond) 
		
func _initializeEnemies():
	for i in range(triangleCount):
		var new_triangle = triangle.instance()
	
		new_triangle.global_position.x = rand_range(0, 1000)
		new_triangle.global_position.y = rand_range(0, 600)

		new_triangle.connect("onPlayerDefeated", self, "game_over")
		add_child(new_triangle) 

func _onDiamond_Recolected():
	$HUD.updateScore() 

func _on_StartTimer_timeout():
	_initializePlayer()
	_initializeDiamonds()
	#$DiamondTimer.start() implementar bonus de diamonds
	
	#Setear un tiempo de espera antes de iniciar los enemigos
	yield(get_tree().create_timer(1), "timeout")
	
	_initializeEnemies() 
	$TriangleTimer.start()
	
func _clearGame():
	$Circle.hidePlayer()
	get_tree().call_group("triangles", "queue_free")
	get_tree().call_group("diamonds", "queue_free")
