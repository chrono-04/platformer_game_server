extends Node

# server IP and port
const SERVER_PORT : int = 8080
const SERVER_IP : String = "127.0.0.1"

var multiplayer_scene = preload("res://Multiplayer-player/multiplayer_player.tscn")

var _player_spawn_node
var host_mode_enabled : bool = false
var multiplayer_mode_enabled : bool = false
var respawn_point = Vector2(30, 10)



# multiplayer hud buttons functions
func become_host() -> void:
	print("Starting Host")
	
	_player_spawn_node = get_tree().get_current_scene().get_node("Players")
	
	multiplayer_mode_enabled = true
	host_mode_enabled = true
	
	var server_peer = ENetMultiplayerPeer.new()
	server_peer.create_server(SERVER_PORT)
	
	# establish instance as a server
	multiplayer.multiplayer_peer = server_peer
	
	# CONNECTION LIFE CYCLE SIGNALS
	# lifecylce callbacks to manage the connection of players
	multiplayer.peer_connected.connect(_add_player_to_game)
	
	# handle when a player disconnects to clean up
	# and remove them from the game
	multiplayer.peer_disconnected.connect(_del_player)
	
	# remove single player mode
	_remove_single_player()
	
	if not OS.has_feature("dedicated_server"):
		_add_player_to_game(1)

func join_as_player_2() -> void:
	
	# client peer
	multiplayer_mode_enabled = true
	var client_peer = ENetMultiplayerPeer.new()
	client_peer.create_client(SERVER_IP, SERVER_PORT)
	
	# establish the client
	multiplayer.multiplayer_peer = client_peer
	
	# remove single player mode
	_remove_single_player()


func _add_player_to_game(id: int) -> void:
	print("Player %s joined the game!" % id)
	
	var player_to_add = multiplayer_scene.instantiate()
	player_to_add.player_id = id
	player_to_add.name = str(id)
	
	# add the player to the actual game scene
	_player_spawn_node.add_child(player_to_add, true)

func _del_player(id: int) -> void:
	print("Player %s left the game." % id)
	if not _player_spawn_node.has_node(str(id)):
		return
	_player_spawn_node.get_node(str(id)).queue_free()

func _remove_single_player() -> void:
	print("Remove single player")
	var player_to_remove = get_tree().get_current_scene().get_node("Player")
	player_to_remove.queue_free()
