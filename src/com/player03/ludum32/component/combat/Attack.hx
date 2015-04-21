package com.player03.ludum32.component.combat;

import ash.core.Entity;
import com.player03.ashdisplay.core.Position;
import openfl.errors.ArgumentError;

/**
 * @author Joseph Cloutier
 */
class Attack {
	public var radius:Float;
	
	public var length:Float;
	public var chargeTimeLeft:Float = 0;
	public var cooldownLeft:Float = 0;
	
	public function new(radius:Float = 160, length:Float = 3) {
		this.radius = radius;
		this.length = length;
	}
}
