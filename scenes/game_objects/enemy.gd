extends RigidBody2D
@onready var game_manager: Node = %GameManager

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "CharacterBody2D":
		var y_delta=position.y-body.position.y
		var x_delta=body.position.x-position.x
		print("x delta value: ",x_delta)
		if y_delta>47:
			print("Destroy Enemy ",y_delta)
			queue_free()
			body.jump()
		else:
			print("Health Decrease ",y_delta)
			#body.queue_free()
			game_manager.decrease_health()
			if x_delta>0:
				body.jump_side(500)
			else:
				body.jump_side(-500)
