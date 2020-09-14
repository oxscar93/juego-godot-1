extends Area2D

const PLAYER = "Circle"
signal onDiamondRecolected

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_Diamond_area_entered(area):
	if (area.get_name() == PLAYER):
		queue_free()
		$CollisionShape2D.set_deferred("disabled", true)
		
		emit_signal("onDiamondRecolected")
