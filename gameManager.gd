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
var roundIndex: int = 0
var shotgunShellCount: int = 8 # some logic based on round index
var maxHP: int = 3 # temporary value
# TODO: create a power variable, where when shot, hp -= power (for handsaw)

# Game Logic functions
func initMatch() -> void:
	roundIndex = 0
	shotgunShellCount = 8

func initRound() -> void:
	currPlayerTurnIndex = 0

func endTurn() -> void:
	currPlayerTurnIndex += 1

func checkWin() -> bool:
  return alivePlayers.size() == 1

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

func useUpgrade(upgradeRef: Upgrade, callerPlayerRef: Player, targetPlayerRef: Player = null) -> void:
	# TODO: verify whether upgrade is in caller's inventory
	
	match upgradeRef.upgrade_type:
		Upgrade.UpgradeType.cigarette:
			useCigarette(callerPlayerRef)
		Upgrade.UpgradeType.beer:
			useBeer(callerPlayerRef)
		Upgrade.UpgradeType.magGlass:
			useMagGlass(callerPlayerRef)
		Upgrade.UpgradeType.handcuff:
			useHandcuff(callerPlayerRef, targetPlayerRef)
		Upgrade.UpgradeType.unoRev:
			useUnoRev(callerPlayerRef, targetPlayerRef)
		Upgrade.UpgradeType.expiredMed:
			useExpiredMed(callerPlayerRef)
		Upgrade.UpgradeType.inverter:
			useInverter(callerPlayerRef)
		Upgrade.UpgradeType.burnerPhone:
			useBurnerPhone(callerPlayerRef)
		Upgrade.UpgradeType.adrenaline:
			useAdrenaline(callerPlayerRef, targetPlayerRef)
		Upgrade.UpgradeType.handSaw:
			useHandSaw(callerPlayerRef)
		
		# TODO: Remove from player inventory

func useCigarette(callerPlayerRef: Player) -> void:
	if callerPlayerRef.hp < maxHP:
		callerPlayerRef.hp += 1

func useBeer(callerPlayerRef: Player) -> void:
	pass

func useMagGlass(callerPlayerRef: Player) -> void:
	print(shotgunShells[0]) # replace with animation 

func useHandcuff(callerPlayerRef: Player, targetPlayerRef: player) -> void:
	pass

func useUnoRev(callerPlayerRef: Player, targetPlayerRef: player) -> void:
	pass

func useExpiredMed(callerPlayerRef: Player) -> void:
	if randi()%2:
		callerPlayerRef.hp += 2
		if callerPlayerRef.hp >= maxHP:
			callerPlayerRef.hp = maxHP
	else:
		callerPlayerRef.hp -= 1

func useInverter(callerPlayerRef: Player) -> void:
	for i in range(shotgunShells.size()):
		if shotgunShells[i] == 0:
			shotgunShells[i] = 1
		else:
			shotgunShells[i] = 0

func useBurnerPhone(callerPlayerRef: Player) -> void:
	pass
	
func useAdrenaline(callerPlayerRef: Player, targetPlayerRef: Player) -> void:
	pass
	
func useHandSaw(callerPlayerRef: Player) -> void:
	pass
