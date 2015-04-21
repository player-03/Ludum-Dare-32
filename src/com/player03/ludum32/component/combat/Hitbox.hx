package com.player03.ludum32.component.combat;

import com.player03.ashdisplay.core.Position;

/**
 * @author Joseph Cloutier
 */
class Hitbox {
	public var radius:Float;
	
	public function new(radius:Float) {
		this.radius = radius;
	}
	
	public static inline function intersects(p1:Position, h1:Hitbox, p2:Position, h2:Hitbox):Bool {
		return (p2.x - p1.x) * (p2.x - p1.x) + (p2.y - p1.y) * (p2.y - p1.y)
			<= (h1.radius + h2.radius) * (h1.radius + h2.radius);
	}
}

