extends Node

# Initializing the game state
var gameState: GameState = GameState.new([], [])
var players: Array[Player] = []
var currPlayerTurnIndex: int = 0 
var shotgunShells: Array[int] = [] # 0 for blank, 1 for live
var roundIndex: int = 0
var shotgunShellCount: int = 8 # some logic based on round index
var maxHP: int = 3 # temporary value

# Game Logic functions
func initMatch() -> void:
	roundIndex = 0
	shotgunShellCount = 8

func initRound() -> void:
	currPlayerTurnIndex = 0

func endTurn() -> void:
	currPlayerTurnIndex += 1

func checkWin() -> bool:
	return gameState.alivePlayers.size() == 1

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
	# reset callerPlayerRef power to 1 after each shot (handSaw might have been used)
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
	for i in gameState.upgradesOnTable.size():
		if upgradeRef == gameState.upgradesOnTable[i]:
			gotUpgrade = true
			upIndex = i
	if gotUpgrade:
		callerPlayerRef.addInventory(upgradeRef)
		gameState.upgradesOnTable.pop_at(upIndex)
	else:
		return false
	return true
# TODO: disableUpgrade, handcuff, unoRev and wildCard logic 
func useUpgrade(upgradeRef: Upgrade, callerPlayerRef: Player, targetPlayerRef: Player = null) -> void:
	if upgradeRef not in callerPlayerRef.inventory:
		return
	
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
		#Upgrade.UpgradeType.wildCard:
		# need to generate upgrade object with random upgrade type (excluding wildCard and unoRev), and call useUpgrade recursively.	
		
	callerPlayerRef.inventory.erase(upgradeRef)

func useCigarette(callerPlayerRef: Player) -> void:
	if callerPlayerRef.hp < maxHP:
		callerPlayerRef.hp += 1

func useBeer(callerPlayerRef: Player) -> void:
	var popped = shotgunShells.pop_front()
	# Play animation of popped bullet being ejected
	# also, discuss whether player should still be allowed to shoot if the gun is now empty, knowing
	# nothing will happen

func useMagGlass(callerPlayerRef: Player) -> void:
	print(shotgunShells[0]) # replace with animation for callerPlayerRef

func useHandcuff(callerPlayerRef: Player, targetPlayerRef: Player) -> void:
	pass

func useUnoRev(callerPlayerRef: Player, targetPlayerRef: Player) -> void:
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
		shotgunShells[i] ^= 1
	# callerPlayerRef isn't needed for the logic, but will need to play animation.

func useBurnerPhone(callerPlayerRef: Player) -> void:
	if shotgunShells.size() >= 1:
		print(shotgunShells[1]) # replace with animation for callerPlayerRef
	else:
		print(0) # play animation showing empty shell 
	
func useAdrenaline(callerPlayerRef: Player, targetPlayerRef: Player) -> void:
	pass
	
func useHandSaw(callerPlayerRef: Player) -> void:
	callerPlayerRef.power = 2 # reset to 1 after shooting please
