class_name Upgrade extends Node

enum UpgradeType {cigarette, beer, magGlass, handcuff, expiredMed, inverter, 
				  burnerPhone, handSaw, adrenaline, disableUpgrade, unoRev, wildCard}

var upgrade_type: UpgradeType

func _init(type: UpgradeType):
	upgrade_type = type
