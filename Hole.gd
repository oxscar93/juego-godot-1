extends Area2D

var triangle_template = preload("res://Triangle.tscn")

func _ready():
	pass
	
func createTriangle():
	var player = get_parent().get_node("Circle")
	var triangle:KinematicBody2D = triangle_template.instance()
	
	triangle.global_position = $Sprite/SpritePosition.global_position
	triangle.setPlayer(player)
	
	get_parent().add_child(triangle)

func _on_TriangleTimer_timeout():
	createTriangle()
