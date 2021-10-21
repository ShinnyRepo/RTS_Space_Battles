class_name Network

var Host_IP_Address:String
var IP_Address:String
var Port:int

var traffic:Array = []

func get_local_ip_address()->String:
	var addresses = IP.get_local_addresses()
	var address:String
	
	for ad in addresses:
		var local:String = ad
		if local.left(3) == "192":
			address = local

	return address

func get_default_port()->String:
	return "10864"

func process_actions()->bool:
	return true

func send_action(action, units, option)->void:
	var action_set:Array = [action, units, option]
	traffic.append(action_set)

func get_action()->Array:
	return traffic.pop_front()
