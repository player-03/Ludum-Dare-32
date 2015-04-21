package com.player03.ludum32.component.combat;

/**
 * @author Joseph Cloutier
 */
class Health {
	public var health:Float;
	
	public var playerTeam:Bool;
	
	public var mercyInvincibilityLeft:Float = 0;
	public var mercyInvincibilityLength:Float;
	
	public function new(health:Float, playerTeam:Bool, mercyInvincibility:Float = 1) {
		this.health = health;
		this.playerTeam = playerTeam;
		mercyInvincibilityLength = mercyInvincibility;
	}
}
