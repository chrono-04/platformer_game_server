extends Node

var score = 0
@onready var score_label = $ScoreLabel

@export var multiplayer_hud : Control

func _ready() -> void:
	if OS.has_feature("dedicated_server"):
		print("Starting dedicated server...")
		MultiplayerManager.become_host()
	multiplayer_hud.visible = false


func add_point():
	score += 1
	score_label.text = "You collected " + str(score) + " coins!"

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("multi_ui"):
		multiplayer_hud.visible = !multiplayer_hud.visible

# multiplayer hud buttons functions
func become_host() -> void:
	print("Become host pressed")
	MultiplayerManager.become_host()
	multiplayer_hud.visible = false

func join_as_player_2() -> void:
	print("Join as player 2")
	MultiplayerManager.join_as_player_2()
	multiplayer_hud.visible = false
