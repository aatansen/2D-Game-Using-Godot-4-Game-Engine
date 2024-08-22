extends RigidBody2D


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "CharacterBody2D":
		var y_delta=position.y-body.position.y
		if y_delta>47:
			print("Destroy Enemy ",y_delta)
			queue_free()
			body.jump()
		else:
			print("Health Decrease ",y_delta)
			#body.queue_free()
