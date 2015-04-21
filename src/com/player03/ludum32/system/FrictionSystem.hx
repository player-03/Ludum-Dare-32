package com.player03.ludum32.system;

import ash.core.Node;
import ash.tools.ListIteratingSystem;
import com.player03.ludum32.component.motion.Friction;
import com.player03.ludum32.component.motion.Velocity;

/**
 * @author Joseph Cloutier
 */
class FrictionSystem extends ListIteratingSystem<FrictionNode> {
	public function new() {
		super(FrictionNode, updateNode);
	}
	
	private function updateNode(node:FrictionNode, time:Float):Void {
		if(Math.abs(node.velocity.x) < 0.5 && Math.abs(node.velocity.y) < 0.5) {
			node.velocity.x = 0;
			node.velocity.y = 0;
		} else {
			var frictionMultiplier:Float = 1 - time * node.friction.friction;
			node.velocity.x *= frictionMultiplier;
			node.velocity.y *= frictionMultiplier;
		}
	}
}

private class FrictionNode extends Node<FrictionNode> {
	public var friction:Friction;
	public var velocity:Velocity;
}
