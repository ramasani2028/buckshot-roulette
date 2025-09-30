extends Node

class_name GameState

# Game Manager Entities
var alivePlayers: Array[Player]
var upgradesOnTable: Array[Upgrade]
var players: Array[Player] = []
var currPlayerTurnIndex: int = 0 
var shotgunShells: Array[int] = [] # 0 for blank, 1 for live
var tableUpgrades: Array[Upgrade] = []
var roundIndex: int = 0
var shotgunShellCount: int = 8 # some logic based on round index
var maxHP: int = 3 # temporary value
# TODO: create a power variable, where when shot, hp -= power (for handsaw)

func _init(_alivePlayers: Array[Player], _upgradesOnTable: Array[Upgrade]):
	alivePlayers = _alivePlayers
	upgradesOnTable = _upgradesOnTable
