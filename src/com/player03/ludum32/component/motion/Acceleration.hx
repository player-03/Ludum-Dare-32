package com.player03.ludum32.component.motion;

/**
 * User- or AI-controlled acceleration, in pixels per second per second.
 * For regular acceleration, use Force.
 * @author Joseph Cloutier
 */
class Acceleration {
	public var acceleration:Float;
	
	public function new(acceleration:Float) {
		this.acceleration = acceleration;
	}
}
