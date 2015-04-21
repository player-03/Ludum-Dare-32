package com.player03.ludum32.component.motion;

import ash.core.Entity;
import com.player03.ashdisplay.core.Position;
import openfl.errors.ArgumentError;

/**
 * Controls the motion of the magnet.
 * @author Joseph Cloutier
 */
class MagnetMotion {
	public var anchor:Position;
	
	/**
	 * The magnet's distance from the actual anchor point.
	 */
	public var offset:Float;
	
	public function new(anchor:Entity, offset:Float) {
		this.anchor = anchor.get(Position);
		this.offset = offset;
		
		if(this.anchor == null) {
			throw new ArgumentError("The magnet's anchor must have a position!");
		}
	}
}
