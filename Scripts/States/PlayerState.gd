extends Node2D

class_name PlayerState

var change_state
var player
var sprite
var animation_player

func setup(_change_state, _player, _sprite, _animation_player):
	self.change_state = _change_state
	self.player = _player
	self.sprite = _sprite
	self.animation_player = _animation_player

