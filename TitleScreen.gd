extends Control

#changing scenes using button
func _on_start_btn_pressed(): #function when the button is pressed
	get_tree().change_scene_to_file("res://Scenes/game.tscn")
	print("Scene changed successfully")
	
