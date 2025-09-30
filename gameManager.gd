extends Node

class GameState:
	var alivePlayers: Array[Player]
	var upgradesOnTable: Array[Upgrade]

	func _init(_alivePlayers: Array, _upgradesOnTable: Array):
		alivePlayers = _alivePlayers
		upgradesOnTable = _upgradesOnTable
		
# TODO: make the Player class please and Upgrade too
var gameState: GameState = GameState.new([], [])
var players: Array[Player] = []
var currPlayerTurnIndex: int = 0 
var shotgunShells: Array[int] = [] # 0 for blank, 1 for live
var tableUpgrades: Array[Upgrades] = []
var roundIndex: int = 0;
var shotgunShellCount: int = 8; # some logic based on round index

# Game Logic functions
func initMatch() -> void:
	roundIndex = 0
	shotgunShellCount = 8;

func initRound() -> void:
	currPlayerTurnIndex = 0

func endTurn() -> void:
	currPlayerTurnIndex += 1

func checkWin() -> bool:
	return alivePlayers.size() == 1;

func generateRandomBullets():
	shotgunShells.clear()
	for i in range(shotgunShellCount):
		var shell = randi() % 2  
		shotgunShells[i] = shell

# Below are all functions that are player facing, call these when designing players for player devs
func endGame() -> void:
	return
func getGameState() -> GameState:
	return gameState

func shootPlayer(callerPlayerRef: Player, targetPlayerRef: Player) -> void:
	# logic for shooting
	if checkWin():
		endGame()
	endTurn()

# call this when you want to pick an upgrade off of the upgrade table
# returns true if succesffuly picked up
# otherwise returns false
func pickUpUpgrade(callerPlayerRef: Player, upgradeRef: Upgrade) -> boolean:
	# im guessing i need to include logic in the scene to actually add and remove upgrades from the table visually
	var gotUpgrade: bool = false
	var upIndex: int = -1
	for i in tableUpgrades.size():
		if upgradeRef == tableUpgrades[i]:
			gotUpgrade = true
			upIndex = i
	if gotUpgrade:
		callerPlayerRef.addInventory(upgradeRef)
		tableUpgrades.pop_at(i)
	else:
		return false
	return true

func useUpgrade(upgradeRef: Upgrade, callerPlayerRef: Player, targetPlayerRef: Player) -> void:
	

# Upgrade devs fill out the space below with your upgrade logics
