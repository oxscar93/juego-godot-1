extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_Diamond_body_entered(body):
	queue_free()# Replace with function body.
	$CollisionShape2D.set_deferred("disabled", true)

