package com.player03.ludum32.component;

/**
 * Metals are attracted to magnets. Yes, I know that gold and silver aren't
 * magnetic, and copper is only weakly magnetic.
 * @author Joseph Cloutier
 */
class Metal {
	public static var COPPER:Metal = new Metal(8.96);
	public static var SILVER:Metal = new Metal(10.49);
	public static var GOLD:Metal = new Metal(19.3);
	
	/**
	 * In grams per cubic centimeter, around room temperature.
	 */
	public var mass:Float;
	
	public function new(mass:Float) {
		this.mass = mass;
	}
}
