package com.player03.ludum32.system;

import ash.core.Node;
import ash.tools.ListIteratingSystem;
import com.player03.ludum32.component.motion.Acceleration;
import com.player03.ludum32.component.motion.Direction;
import com.player03.ludum32.component.motion.MaxSpeed;
import com.player03.ludum32.component.motion.Velocity;

/**
 * @author Joseph Cloutier
 */
class AccelerationSystem extends ListIteratingSystem<AccelerationNode> {
	/**
	 * Temporary variable.
	 */
	private var targetVel:Velocity;
	
	public function new() {
		super(AccelerationNode, updateNode);
		
		targetVel = new Velocity();
	}
	
	private function updateNode(node:AccelerationNode, time:Float):Void {
		targetVel.x = node.direction.x * node.maxSpeed.speed;
		targetVel.y = node.direction.y * node.maxSpeed.speed;
		if(targetVel.x * targetVel.x + targetVel.y * targetVel.y
				> node.maxSpeed.speed * node.maxSpeed.speed) {
			var m:Float = node.maxSpeed.speed
				/ Math.sqrt(targetVel.x * targetVel.x + targetVel.y * targetVel.y);
			targetVel.x *= m;
			targetVel.y *= m;
		}
		
		var fraction:Float = time * node.acceleration.acceleration;
		if(fraction > 0.2) {
			fraction = 0.2;
		}
		if(targetVel.x == 0 && targetVel.y == 0) {
			//Deceleration boost!
			fraction *= 2;
			
			//Come to a complete stop.
			if(Math.abs(node.velocity.x) < 0.5 && Math.abs(node.velocity.y) < 0.5) {
				node.velocity.x = 0;
				node.velocity.y = 0;
			}
		}
		node.velocity.x += (targetVel.x - node.velocity.x) * fraction;
		node.velocity.y += (targetVel.y - node.velocity.y) * fraction;
	}
}

private class AccelerationNode extends Node<AccelerationNode> {
	public var direction:Direction;
	public var acceleration:Acceleration;
	public var velocity:Velocity;
	public var maxSpeed:MaxSpeed;
}
