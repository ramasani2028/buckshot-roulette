extends Node3D

class_name Player

# Player properties
var hp: int
var inventory: Array = []
var power: int = 1
var isHandcuffed: bool = false
var current_target_index: int = 0
var targets: Array = []
var is_my_turn: bool = false
var game_state: GameState = null
 
func _init(_name: String = "Player", _hp: int = 3):
	name = _name
	hp = _hp
	inventory = []

func _process(delta):
	if is_my_turn:
		if Input.is_action_just_pressed("ui_left"):
			current_target_index = (current_target_index - 1 + targets.size()) % targets.size()
			update_target()
		elif Input.is_action_just_pressed("ui_right"):
			current_target_index = (current_target_index + 1) % targets.size()
			update_target()

func update_target():
	if targets.size() > 0:
		var target = targets[current_target_index]
		if target is Player:
			look_at(target.global_transform.origin)
		elif target is Upgrade:
			look_at(target.pos)

func onTurnEnd(new_game_state: GameState, current_player_index: int):
	game_state = new_game_state
	is_my_turn = (game_state.alivePlayers[current_player_index] == self)
	if is_my_turn:
		if game_state.isUpgradeRound:
			targets = game_state.upgradesOnTable
		else:
			targets = game_state.alivePlayers.filter(func(p): return p != self)
		current_target_index = 0
		update_target()

# Inventory management
func addInventory(upgrade: Upgrade) -> void:
	inventory.append(upgrade)

func removeInventory(upgrade: Upgrade) -> bool:
	if upgrade in inventory:
		inventory.erase(upgrade)
		return true
	return false

# Check if player has a specific upgrade
func hasUpgrade(upgrade: Upgrade) -> bool:
	return upgrade in inventory

# Apply damage to the player
func takeDamage(amount: int) -> void:
	hp -= amount
	if hp < 0:
		hp = 0

# Heal the player
func heal(amount: int, max_hp: int) -> void:
	hp += amount
	if hp > max_hp:
		hp = max_hp

# Optional: check if player is alive
func isAlive() -> bool:
	return hp > 0
