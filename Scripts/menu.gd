extends Control


@onready var start_button: Button = $"VBoxContainer/Start Button"
@onready var level_button: Button = $"VBoxContainer/Level Button"
@onready var quit_button: Button = $"VBoxContainer/Quit Button"

@onready var v_box_container: VBoxContainer = $VBoxContainer
@onready var level_menu_container: VBoxContainer = $LevelMenuContainer

func _ready() -> void:
	v_box_container.visible = true
	level_menu_container.visible = false

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Levels/level_1.tscn")


func _on_level_button_pressed() -> void:
	v_box_container.visible = false
	level_menu_container.visible = true


func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_option_button_item_selected(index: int) -> void:
	match index:
		1:
			get_tree().change_scene_to_file("res://Scenes/Levels/level_1.tscn")
		2:
			get_tree().change_scene_to_file("res://Scenes/Levels/level_2.tscn")
