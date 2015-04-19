package com.player03.ludum32.system;

import ash.core.Node;
import ash.tools.ListIteratingSystem;
import com.player03.ashdisplay.core.Position;
import com.player03.ludum32.component.motion.Velocity;

/**
 * @author Joseph Cloutier
 */
class VelocitySystem extends ListIteratingSystem<VelocityNode> {
	public function new() {
		super(VelocityNode, updateNode);
	}
	
	private function updateNode(node:VelocityNode, time:Float):Void {
		node.position.x += node.velocity.x * time;
		node.position.y += node.velocity.y * time;
	}
}

private class VelocityNode extends Node<VelocityNode> {
	public var velocity:Velocity;
	public var position:Position;
}
