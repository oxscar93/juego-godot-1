extends Node2D

const DIAMOND_COUNT = 10
const HOLE_COUNT = 5

var target = Vector2()
var velocity = Vector2()
var diamond = preload("res://Diamond.tscn")
var hole = preload("res://Hole.tscn")
var screenSize = Vector2()

func _ready():
	screenSize = get_viewport().get_visible_rect().size
	randomize()
	
func _process(delta):
	pass

func _new_game():
	$StartTimer.start()
	
func game_over():
	$DiamondTimer.stop()	
	$HUD.show_game_over()
	
	_clearGame()
		
func _on_DiamondTimer_timeout():
	_initializeDiamonds()

func _on_TriangleTimer_timeout():	
	_initializeHoles()
	
func _initializePlayer():
	$Circle.start($StartPosition.position)
	
func _initializeDiamonds():
	for i in range(DIAMOND_COUNT):
		var new_diamond = diamond.instance()
	
		new_diamond.global_position = _getRandomPosition()
		new_diamond.connect("onDiamondRecolected", self, "_onDiamond_Recolected")
		
		add_child(new_diamond) 
		
func _initializeHoles():
	for i in range(HOLE_COUNT):
		var new_hole = hole.instance()
	
		new_hole.init($Circle)
		new_hole.global_position = _getRandomPosition()

		add_child(new_hole)
		
func _onDiamond_Recolected():
	$HUD.updateScore() 

func _on_StartTimer_timeout():
	_initializePlayer()
	_initializeDiamonds()
	_initializeHoles() 
	
	$DiamondTimer.start()
	
func _clearGame():
	$Circle.hide()
	
	get_tree().call_group("triangles", "queue_free")
	get_tree().call_group("diamonds", "queue_free")
	get_tree().call_group("holes", "queue_free")
	
func _getRandomPosition():
	return Vector2(rand_range(0, screenSize.x), rand_range(0, screenSize.y))
	
