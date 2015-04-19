package com.player03.ludum32.component.motion;

/**
 * The desired direction of motion. This should never be larger than 1; use
 * checkLength() to ensure that the values are suitable.
 * @author Joseph Cloutier
 */
class Direction {
	public var x:Float = 0;
	public var y:Float = 0;
	
	public function new() {
	}
	
	public function checkLength():Void {
		if(x * x + y * y > 1) {
			var m:Float = 1 / Math.sqrt(x * x + y * y);
			x *= m;
			y *= m;
		}
	}
}
