extends Node2D

class_name PlayerState

var change_state
var player

func setup(_change_state, _player):
	self.change_state = _change_state
	self.player = _player
