extends Node

const MENU = 0
const EXPLORE = 1
const TRANSITION = 2
const WAITING = -1

var mode setget setMode, getMode
var mode_stack = [0]

signal imp_mode_changed(m)

func setMode(v:int):
	mode_stack[-1] = v
	emit_signal("imp_mode_changed", v)
	
func getMode()->int:
	return mode_stack[-1]

func push(val:int):
	mode_stack.append(val)
	emit_signal("imp_mode_changed", val)
func pop()->int:
	var rv = mode_stack[-1]
	if mode_stack.size()>1: mode_stack.pop_back()
	emit_signal("imp_mode_changed", rv)
	return rv
