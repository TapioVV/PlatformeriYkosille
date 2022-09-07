extends Node2D

class_name PlayerState

var change_state
var player
var sprite

func setup(_change_state, _player, _sprite):
	self.change_state = _change_state
	self.player = _player
	self.sprite = _sprite

