extends Node

var stage_count = 1
var total_player_gold = 9001
var player_current_attack = false
var player_health = 8
var bullets = 10

var bullet_cost = 10
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

var seconds = 5
var minutes = 1
var Dseconds = 0
var DMinutes = 2

var gold_quota = 250
var enemy_attack_damage = 1 * self.stage_count
var recently_in_cave: bool = false

func upgrade_boots():
	if (Global.boots_upgrades >= Global.boots_upgrade_costs.size()-1):
		return
	if total_player_gold > boots_upgrade_costs[boots_upgrades]:
		total_player_gold -= boots_upgrade_costs[boots_upgrades]
		boots_upgrades += 1

func upgrade_vest():
	if (Global.vest_upgrades >= Global.vest_upgrade_costs.size()-1):
		return
	if total_player_gold > vest_upgrade_costs[vest_upgrades]:
		total_player_gold -= vest_upgrade_costs[vest_upgrades]
		vest_upgrades += 1

func upgrade_pick():
	if (Global.pick_upgrades >= Global.pick_upgrade_costs.size()-1):
		return
	if total_player_gold > pick_upgrade_costs[pick_upgrades]:
		total_player_gold -= pick_upgrade_costs[pick_upgrades]
		pick_upgrades += 1

func upgrade_light():
	if (Global.light_upgrades >= Global.light_upgrade_costs.size()-1):
		return
	if total_player_gold > light_upgrade_costs[light_upgrades]:
		total_player_gold -= light_upgrade_costs[light_upgrades]
		light_upgrades += 1

func upgrade_gun():
	if (Global.gun_upgrades >= Global.gun_upgrade_costs.size()-1):
		return
	if total_player_gold > gun_upgrade_costs[gun_upgrades]:
		total_player_gold -= gun_upgrade_costs[gun_upgrades]
		gun_upgrades += 1

func buy_bullets ():
	if total_player_gold > bullet_cost:
		total_player_gold -= bullet_cost
		bullets += 10

# Shop items : 
var player_max_health = 8 + 2*self.vest_upgrades
var player_max_speed = 20 + 5*self.boots_upgrades
var player_light_radius = 1 + 0.5*self.light_upgrades
var player_attack_damage = 2 + self.pick_upgrades
var player_ammo = self.bullets
var player_bullet_damage = 1 + self.gun_upgrades
