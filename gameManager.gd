extends Node

# Initializing the game state
var gameState: GameState = GameState.new([], [])

# Game Logic functions
func initMatch() -> void:
	gameState.roundIndex = 0
	gameState.shotgunShellCount = 8

func initRound() -> void:
	gameState.currPlayerTurnIndex = 0

func endTurn() -> void:
	gameState.currPlayerTurnIndex += 1

func checkWin() -> bool:
	return gameState.alivePlayers.size() == 1

func generateRandomBullets():
	gameState.shotgunShells.clear()
	for i in range(gameState.shotgunShellCount):
		var shell = randi() % 2  
		gameState.shotgunShells[i] = shell

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
func pickUpUpgrade(callerPlayerRef: Player, upgradeRef: Upgrade) -> bool:
	# im guessing i need to include logic in the scene to actually add and remove upgrades from the table visually
	var gotUpgrade: bool = false
	var upIndex: int = -1
	for i in gameState.tableUpgrades.size():
		if upgradeRef == gameState.tableUpgrades[i]:
			gotUpgrade = true
			upIndex = i
	if gotUpgrade:
		callerPlayerRef.addInventory(upgradeRef)
		gameState.tableUpgrades.pop_at(upIndex)
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
	if callerPlayerRef.hp < gameState.maxHP:
		callerPlayerRef.hp += 1

func useBeer(callerPlayerRef: Player) -> void:
	pass

func useMagGlass(callerPlayerRef: Player) -> void:
	print(gameState.shotgunShells[0]) # replace with animation 

func useHandcuff(callerPlayerRef: Player, targetPlayerRef: Player) -> void:
	pass

func useUnoRev(callerPlayerRef: Player, targetPlayerRef: Player) -> void:
	pass

func useExpiredMed(callerPlayerRef: Player) -> void:
	if randi()%2:
		callerPlayerRef.hp += 2
		if callerPlayerRef.hp >= gameState.maxHP:
			callerPlayerRef.hp = gameState.maxHP
	else:
		callerPlayerRef.hp -= 1

func useInverter(callerPlayerRef: Player) -> void:
	for i in range(gameState.shotgunShells.size()):
		if gameState.shotgunShells[i] == 0:
			gameState.shotgunShells[i] = 1
		else:
			gameState.shotgunShells[i] = 0

func useBurnerPhone(callerPlayerRef: Player) -> void:
	pass
	
func useAdrenaline(callerPlayerRef: Player, targetPlayerRef: Player) -> void:
	pass
	
func useHandSaw(callerPlayerRef: Player) -> void:
	pass
