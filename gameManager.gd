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
var shotgunShells: Array[int] = []
var tableUpgrades: Array[Upgrades] = []
var roundIndex: int = 0
var shotgunShellCount: int = 8 # some logic based on round index

# Game Logic functions
func initMatch() -> void:
	roundIndex = 0
	shotgunShellCount = 8

func initRound() -> void:
	currPlayerTurnIndex = 1

func endTurn() -> void:
	currPlayerTurnIndex += 1

func checkWin() -> bool:
	return alivePlayers.size() == 1

# Below are all functions that are player facing, call these when designing players for player devs
func getGameState() -> void:
	
func getAlivePlayers() -> Array[Player]:
	
func getAllPlayers() -> Array[Player]:
	

# TODO: make upgrade class please
func getUpgradesOnTheTable() -> Array[Upgrade]:
	

func shootPlayer(callerPlayerRef: Player, targetPlayerRef: Player) -> void:
	# logic for shooting
	endTurn()

func pickUpUpgrade(callerPlayerRef: Player, upgradeRef: Upgrade) -> void:
	

func useUpgrade(upgradeRef: Upgrade, callerPlayerRef: Player, targetPlayerRef: Player = null) -> void:
	# verify if its in inventory
	
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
		
		# Remove from player inventory

func useCigarette(callerPlayerRef: Player) -> void:
	callerPlayerRef.hp += 1

func useBeer(callerPlayerRef: Player) -> void:
	pass

func useMagGlass(callerPlayerRef: Player) -> void:
	pass

func useHandcuff(callerPlayerRef: Player, targetPlayerRef: player) -> void:
	pass

func useUnoRev(callerPlayerRef: Player, targetPlayerRef: player) -> void:
	pass

func useExpiredMed(callerPlayerRef: Player) -> void:
	pass

func useInverter(callerPlayerRef: Player) -> void:
	pass

func useBurnerPhone(callerPlayerRef: Player) -> void:
	pass
	
func useAdrenaline(callerPlayerRef: Player, targetPlayerRef: Player) -> void:
	pass
	
func useHandSaw(callerPlayerRef: Player) -> void:
	pass
