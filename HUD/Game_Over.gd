extends Control

func _ready():
	$Label.text = "Thanks for Playing! Your final score was " + str(Global.score) + " points."



func _on_Load_pressed():
	Global.load_game(0)


func _on_Quit_pressed():
	get_tree().quit()
