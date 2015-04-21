package com.player03.ludum32.component.combat;

/**
 * Pulls on ferromagnetic materials.
 * @author Joseph Cloutier
 */
class Magnet {
	/**
	 * This divided by mass equals velocity.
	 */
	public var strength:Float;
	
	/**
	 * The maximum effective distance.
	 */
	public var distance:Float;
	
	/**
	 * The magnet only pulls things that are in the direction that it's
	 * pointing, plus or minus this much. (That means the effective area
	 * covers an angle twice the size of this one, but don't worry - the
	 * constructor divides the given angle in half.)
	 */
	public var angle:Float;
	
	public function new(strength:Float, distance:Float, angle:Float) {
		this.strength = strength;
		this.distance = distance;
		this.angle = angle / 2;
	}
}
