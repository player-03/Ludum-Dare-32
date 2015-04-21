package com.player03.ludum32.component.display;

/**
 * A set of animations to be played based on which way the entity is moving.
 * @author Joseph Cloutier
 */
class DirectionalAnimations {
	public var left:Animation;
	public var right:Animation;
	public var up:Animation;
	public var down:Animation;
	
	public var mostRecentAnimation:Animation;
	
	public function new(left:Animation, right:Animation,
						up:Animation, down:Animation) {
		this.left = left;
		this.right = right;
		this.up = up;
		this.down = down;
		
		mostRecentAnimation =
			switch(Std.int(Math.random() * 4)) {
				case 0:
					left;
				case 1:
					right;
				case 2:
					up;
				default:
					down;
			};
	}
}
