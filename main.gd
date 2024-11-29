extends Control

@onready var fruits_grid: GridContainer = $FruitsGrid


@export var fruits_images: Array[Texture]
@export var fruits_random: Array[Texture]
var textures_buttons: Array[TextureButton]
var check_two_images: Array[Texture]
var check_two_indexes: Array[int]
var score := 0

var blank = preload("res://assets/blank.png")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	blank_board()
	add_fruits_to_random_list()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	show_images()
	win()


func blank_board():
	for fruit in range(12):
		var texture_button = TextureButton.new()
		texture_button.stretch_mode = TextureButton.STRETCH_SCALE
		texture_button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		texture_button.size_flags_vertical = Control.SIZE_EXPAND_FILL
		texture_button.set_anchors_preset(Control.PRESET_FULL_RECT)
		fruits_grid.add_child(texture_button)
		texture_button.texture_normal = blank
		textures_buttons.append(texture_button)


func add_double_to_list(target_list, value):
	target_list.append(value)
	target_list.append(value)


func add_fruits_to_random_list():
	for fruits in fruits_images:
		add_double_to_list(fruits_random, fruits)
	randomize()
	fruits_random.shuffle()


func show_images():
	if textures_buttons[0].button_pressed == true:
		textures_buttons[0].texture_normal = fruits_random[0]
		check_images(fruits_random[0], 0)
	if textures_buttons[1].button_pressed == true:
		textures_buttons[1].texture_normal = fruits_random[1]
		check_images(fruits_random[1], 1)
	if textures_buttons[2].button_pressed == true:
		textures_buttons[2].texture_normal = fruits_random[2]
		check_images(fruits_random[2], 2)
	if textures_buttons[3].button_pressed == true:
		textures_buttons[3].texture_normal = fruits_random[3]
		check_images(fruits_random[3], 3)
	if textures_buttons[4].button_pressed == true:
		textures_buttons[4].texture_normal = fruits_random[4]
		check_images(fruits_random[4], 4)
	if textures_buttons[5].button_pressed == true:
		textures_buttons[5].texture_normal = fruits_random[5]
		check_images(fruits_random[5], 5)
	if textures_buttons[6].button_pressed == true:
		textures_buttons[6].texture_normal = fruits_random[6]
		check_images(fruits_random[6], 6)
	if textures_buttons[7].button_pressed == true:
		textures_buttons[7].texture_normal = fruits_random[7]
		check_images(fruits_random[7], 7)
	if textures_buttons[8].button_pressed == true:
		textures_buttons[8].texture_normal = fruits_random[8]
		check_images(fruits_random[8], 8)
	if textures_buttons[9].button_pressed == true:
		textures_buttons[9].texture_normal = fruits_random[9]
		check_images(fruits_random[9], 9)
	if textures_buttons[10].button_pressed == true:
		textures_buttons[10].texture_normal = fruits_random[10]
		check_images(fruits_random[10], 10)
	if textures_buttons[11].button_pressed == true:
		textures_buttons[11].texture_normal = fruits_random[11]
		check_images(fruits_random[11], 11)


func check_images(image: Texture, index: int):
	if check_two_images.size() < 2 and check_two_indexes.size() < 2:
		check_two_images.append(image)
		check_two_indexes.append(index)
		textures_buttons[index].disabled = true
	if check_two_images.size() == 2 and check_two_indexes.size() == 2:
		disable_all_buttons()
		if check_two_images[0] == check_two_images[1]:
			textures_buttons[check_two_indexes[0]].disabled = true
			textures_buttons[check_two_indexes[1]].disabled = true
			check_two_images.clear()
			check_two_indexes.clear()
			score += 1
			enable_all_buttons()
		else:
			disable_all_buttons()
			await get_tree().create_timer(1.5).timeout
			textures_buttons[check_two_indexes[0]].texture_normal = blank
			textures_buttons[check_two_indexes[1]].texture_normal = blank
			textures_buttons[check_two_indexes[0]].disabled = false
			textures_buttons[check_two_indexes[1]].disabled = false
			check_two_images.clear()
			check_two_indexes.clear()
			enable_all_buttons()
			

func disable_all_buttons():
	for child in fruits_grid.get_children():
		if child is TextureButton:
			child.disabled = true

func enable_all_buttons():
	for child in fruits_grid.get_children():
		if child is TextureButton:
			child.disabled = false
			
func win():
	if score == 6:
		disable_all_buttons()
		await get_tree().create_timer(2).timeout
		get_tree().reload_current_scene()
