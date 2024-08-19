extends Node

@onready var poinst_label: Label = %PoinstLabel

var points=0
func add_point():
	points+=1
	poinst_label.text = "Points: " + str(points)
	print(points)
