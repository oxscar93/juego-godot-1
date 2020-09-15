extends Area2D

var triangle_template = preload("res://Triangle.tscn")
var currentPlayer

func init(player):
	currentPlayer = player
	
func _ready():
	createTriangle()
	
func createTriangle():
	var triangle = triangle_template.instance()

	triangle.init(currentPlayer, $Sprite/SpritePosition.global_position)
	
	get_parent().add_child(triangle)

func _on_TriangleTimer_timeout():
	createTriangle()

