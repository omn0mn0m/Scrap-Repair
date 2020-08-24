extends VBoxContainer

func _on_ResumeButton_pressed():
	get_tree().paused = false
	self.hide()

func _on_TitleScreenButton_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://menus/MainMenu.tscn")

func _on_ResetButton_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()
