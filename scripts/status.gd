extends Node

var status = 0x0

# Addresses
const JUMPING = 0x1

func get_state(address)->bool:
	return (address & self.status) != 0
	
func turn_off_state(address)->void:
	self.status &= ~address
	
func turn_on_state(address)->void:
	self.status |= address