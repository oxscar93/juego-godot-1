extends Area2D

signal onDiamondRecolected

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_Diamond_body_entered(body):
	if (body.get_name() == "Circle"):
		queue_free()
		$CollisionShape2D.set_deferred("disabled", true)
		
		emit_signal("onDiamondRecolected")

