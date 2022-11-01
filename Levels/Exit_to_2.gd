extends Area2D


func _on_Exit_body_entered(body):
	if body.name == "Player":
		if name == "Exit":
			Global.level = 2
		if name == "Exit2":
			Global.level = 3
		if name == "Exit3":
			Global.level = 4
		if name == "Exit4":
			Global.level = 5
		if Global.level < Global.levels.size():
			get_tree().change_scene(Global.levels[Global.level])
		else:
			get_tree().change_scene("res://Levels/Game_Over.tscn")
