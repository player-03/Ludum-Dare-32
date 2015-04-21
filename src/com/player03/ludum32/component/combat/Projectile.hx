package com.player03.ludum32.component.combat;

/**
 * @author Joseph Cloutier
 */
class Projectile {
	public var damage:Int;
	
	public var playerTeam:Bool;
	
	public function new(damage:Int, playerTeam:Bool) {
		this.damage = damage;
		this.playerTeam = playerTeam;
	}
}
