package com.player03.ludum32.component.display;

/**
 * @author Joseph Cloutier
 */
class SpeedAnimation {
	public var animation:Animation;
	
	/**
	 * Actually the "frames per second per unit of speed," but that's way
	 * too long for a variable name. Anyway, multiply this by speed to get
	 * the current frames per second.
	 */
	public var fpsMultiplier:Float;
	
	public function new(animation:Animation, fpsMultiplier:Float) {
		this.animation = animation;
		this.fpsMultiplier = fpsMultiplier;
	}
}
