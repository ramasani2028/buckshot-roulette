extends Node 

class_name GameState

# Game Manager Entities
var alivePlayers: Array[Player]
var upgradesOnTable: Array[Upgrade]
var isUpgradeRound: bool

func _init(_alivePlayers: Array[Player], _upgradesOnTable: Array[Upgrade], _isUpgradeRound: bool):
	alivePlayers = _alivePlayers
	upgradesOnTable = _upgradesOnTable
	isUpgradeRound = _isUpgradeRound
