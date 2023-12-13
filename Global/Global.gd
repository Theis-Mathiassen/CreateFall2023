extends Node

var stage_count = 1
var total_player_gold = 300
var player_current_attack = false
var player_health = 8
var bullets = 10

var bat_killed = false
var start_gold_count = 100
var whiskey_drunk = false

var bullet_cost = 50
var boots_upgrades = 0
var boots_upgrade_costs = [300, 500, 800]
var vest_upgrades = 0
var vest_upgrade_costs = [300, 500, 800]
var pick_upgrades = 0
var pick_upgrade_costs = [300, 500, 800]
var light_upgrades = 0
var light_upgrade_costs = [300, 500, 800]
var gun_upgrades = 0
var gun_upgrade_costs = [300, 500, 800]

var Dseconds = 0
var DMinutes = 3
var seconds = Dseconds
var minutes = DMinutes

var collected_since_quota = 0
var gold_quota = 250
var enemy_attack_damage = 1 * self.stage_count


enum difficulty {beginner, normal, hard, nightmare}
var selected_difficulty = difficulty.normal

enum position {shop, town, entrance, cave, start}
var player_position = position.entrance



func quota_end():
	if Global.collected_since_quota < Global.gold_quota:
		get_tree().change_scene_to_file("res://World/GameOver.tscn")
	else:
		Global.player_health = Global.player_max_health
		Global.collected_since_quota = 0
		Global.gold_quota *= 1.2
		Global.stage_count += 1
		var new_seconds = (Global.DMinutes * 60 + Global.Dseconds) + (Global.DMinutes * 60 + Global.Dseconds) * 0.2 * Global.stage_count
		print(new_seconds)
		Global.minutes = floor(new_seconds/60)
		Global.seconds = int(floor(new_seconds)) % 60



func is_tutorial_complete():
	return true if bat_killed && start_gold_count == 0 && whiskey_drunk else false

func collect_gold(amount):
	collected_since_quota += amount
	total_player_gold += amount

func upgrade_boots():
	if (Global.boots_upgrades >= Global.boots_upgrade_costs.size()-1):
		return
	if total_player_gold > boots_upgrade_costs[boots_upgrades]:
		total_player_gold -= boots_upgrade_costs[boots_upgrades]
		boots_upgrades += 1
	player_max_speed = 35 + 10*self.boots_upgrades

func upgrade_vest():
	if (Global.vest_upgrades >= Global.vest_upgrade_costs.size()-1):
		return
	if total_player_gold > vest_upgrade_costs[vest_upgrades]:
		total_player_gold -= vest_upgrade_costs[vest_upgrades]
		vest_upgrades += 1
	player_max_health = 8 + 3*self.vest_upgrades

func upgrade_pick():
	if (Global.pick_upgrades >= Global.pick_upgrade_costs.size()-1):
		return
	if total_player_gold > pick_upgrade_costs[pick_upgrades]:
		total_player_gold -= pick_upgrade_costs[pick_upgrades]
		pick_upgrades += 1
	player_attack_damage = 2 + self.pick_upgrades

func upgrade_light():
	if (Global.light_upgrades >= Global.light_upgrade_costs.size()-1):
		return
	if total_player_gold > light_upgrade_costs[light_upgrades]:
		total_player_gold -= light_upgrade_costs[light_upgrades]
		light_upgrades += 1
	player_light_radius = 1 + 0.5*self.light_upgrades

func upgrade_gun():
	if (Global.gun_upgrades >= Global.gun_upgrade_costs.size()-1):
		return
	if total_player_gold > gun_upgrade_costs[gun_upgrades]:
		total_player_gold -= gun_upgrade_costs[gun_upgrades]
		gun_upgrades += 1
	player_bullet_damage = 1 + self.gun_upgrades

func buy_bullets ():
	if total_player_gold > bullet_cost:
		total_player_gold -= bullet_cost
		player_ammo += 10

# Shop items : 
var player_max_health = 8 + 2*self.vest_upgrades
var player_max_speed = 40 + 40*self.boots_upgrades
var player_light_radius = 1 + 0.5*self.light_upgrades
var player_attack_damage = 2 + self.pick_upgrades
var player_ammo = self.bullets
var player_bullet_damage = 1 + self.gun_upgrades
