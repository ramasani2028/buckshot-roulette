class_name Upgrade extends Node

enum UpgradeType {cigarette, beer, magGlass, handcuff, unoRev, wildCard,
 			   disableUpgrade, expiredMed, inverter, burnerPhone, adrenaline, handSaw}

var upgrade_type: UpgradeType

func _init(type: UpgradeType):
	upgrade_type = type
