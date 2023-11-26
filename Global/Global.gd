extends Node

var stage_count = 1
var total_player_gold = 0
var player_current_attack = false
var player_health = 8
var bullets = 10

var boots_upgrades = 0
var vest_upgrades = 0
var pick_upgrades = 0
var light_upgrades = 0
var gun_upgrades = 0

var seconds = 5
var minutes = 1
var Dseconds = 0
var DMinutes = 2

var gold_quota = 250
var enemy_attack_damage = 1 * self.stage_count


# Shop items : 
var player_max_health = 8 + 2*self.vest_upgrades
var player_max_speed = 20 + 5*self.boots_upgrades
var player_light_radius = 1 + 0.5*self.líght_upgrades
var player_attack_damage = 2 + self.pick_upgrades
var player_ammo = self.bullets
var player_bullet_damage = 1 + self.gun_upgrades
