package com.player03.ludum32.component.motion;

/**
 * Any object with mass will be attracted to the magnet, and can be picked
 * up by the player character.
 * @author Joseph Cloutier
 */
class Mass {
	public var mass:Float;
	
	public function new(mass:Float) {
		this.mass = mass;
	}
}
