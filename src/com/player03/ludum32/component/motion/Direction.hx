package com.player03.ludum32.component.motion;

/**
 * The desired direction of motion. This should never be larger than 1; use
 * checkLength() to ensure that the values are suitable.
 * @author Joseph Cloutier
 */
class Direction {
	public var x:Float = 0;
	public var y:Float = 0;
	
	/**
	 * Used by ControlSystem if this entity is AI-controlled.
	 */
	public var aiTimer:Float = 0;
	
	public function new() {
	}
	
	public function checkLength(length:Float = 1):Void {
		if(x * x + y * y > length * length) {
			var m:Float = length / Math.sqrt(x * x + y * y);
			x *= m;
			y *= m;
		}
	}
}
