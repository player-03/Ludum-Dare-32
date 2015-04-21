package com.player03.ludum32.system;

import ash.core.Node;
import ash.tools.ListIteratingSystem;
import com.player03.ludum32.component.motion.Force;
import com.player03.ludum32.component.motion.Mass;
import com.player03.ludum32.component.motion.Velocity;

/**
 * @author Joseph Cloutier
 */
class ForceSystem extends ListIteratingSystem<ForceNode> {
	public function new() {
		super(ForceNode, updateNode);
	}
	
	private function updateNode(node:ForceNode, time:Float):Void {
		node.velocity.x += node.force.x / node.mass.mass * time;
		node.velocity.y += node.force.y / node.mass.mass * time;
		node.force.x = 0;
		node.force.y = 0;
	}
}

private class ForceNode extends Node<ForceNode> {
	public var force:Force;
	public var mass:Mass;
	public var velocity:Velocity;
}
