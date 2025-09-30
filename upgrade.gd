class_name Upgrade extends Node

enum upgradeType {cigarette, beer, magGlass, handcuff, unoRev, wildCard,
 			   disableUpgrade, expiredMed, inverter, burnerPhone, adrenaline, handSaw}

var upgrade_type: upgradeType

func _init(type: upgradeType):
	upgrade_type = type
