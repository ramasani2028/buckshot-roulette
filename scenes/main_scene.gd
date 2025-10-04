extends Node

@export var gameScene: PackedScene

func _ready():
	# Player 1
	var game1 = gameScene.instantiate()
	add_child(game1)
	game1.get_node("Player1/Camera3D").current = true
	
	#Player 2
	var window2 = Window.new()
	window2.size = Vector2(800,800)
	window2.visible = true
	add_child(window2)
	
	var game2 = gameScene.instantiate()
	window2.add_child(game2)
	game2.get_node("Player2/Camera3D").current = true
	window2.get_viewport().world_3d = game1.get_viewport().world_3d
	
