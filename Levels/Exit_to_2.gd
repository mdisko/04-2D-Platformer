extends Area2D


func _on_Exit_body_entered(body):
	if body.name == "Player":
		if name == "Exit":
			var _target = get_tree().change_scene("res://Levels/Level2.tscn")
		if name == "Exit2":
			var _target = get_tree().change_scene("res://Levels/Level3.tscn")
		if name == "Exit3":
			var _target = get_tree().change_scene("res://Levels/Level4.tscn")
		if name == "Exit4":
			var _target = get_tree().change_scene("res://Levels/Level5.tscn")
		if name == "Exit5":
			var _target = get_tree().change_scene("res://Levels/Game_Over.tscn")
