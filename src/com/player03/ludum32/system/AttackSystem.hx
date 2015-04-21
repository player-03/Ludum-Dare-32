package com.player03.ludum32.system;

import ash.core.Node;
import ash.core.NodeList;
import ash.core.Engine;
import ash.tools.ListIteratingSystem;
import com.player03.ashdisplay.core.Position;
import com.player03.ludum32.component.combat.Attack;
import com.player03.ludum32.component.combat.AttackTarget;
import com.player03.ludum32.component.combat.Health;
import com.player03.ludum32.component.motion.Direction;
import com.player03.ludum32.component.motion.Velocity;

/**
 * @author Joseph Cloutier
 */
class AttackSystem extends ListIteratingSystem<AttackNode> {
	private static inline var COOLDOWN_MULTIPLIER:Float = 2;
	
	private var targetNodeList:NodeList<AttackTargetNode>;
	
	public function new() {
		super(AttackNode, updateNode);
	}
	
	public override function addToEngine(engine:Engine):Void {
        super.addToEngine(engine);
		targetNodeList = engine.getNodeList(AttackTargetNode);
    }

    public override function removeFromEngine(engine:Engine):Void {
		super.removeFromEngine(engine);
		targetNodeList = null;
	}
	
	private function updateNode(node:AttackNode, time:Float):Void {
		if(node.attack.cooldownLeft > 0) {
			node.attack.cooldownLeft -= time;
			return;
		}
		
		//If the unit got hit, cancel the attack and start a cooldown.
		if(node.health.mercyInvincibilityLeft > 0) {
			node.attack.chargeTimeLeft = 0;
			node.attack.cooldownLeft = node.attack.length * COOLDOWN_MULTIPLIER;
			return;
		}
		
		for(targetNode in targetNodeList) {
			if(updateNodePair(node, targetNode, time)) {
				if(node.attack.chargeTimeLeft <= 0) {
					node.attack.chargeTimeLeft = node.attack.length;
				} else {
					node.attack.chargeTimeLeft -= time;
					if(node.attack.chargeTimeLeft <= 0) {
						node.attack.cooldownLeft = node.attack.length * COOLDOWN_MULTIPLIER;
					}
				}
				
				return;
			}
		}
		
		//No target found; reset the timer.
		node.attack.chargeTimeLeft = 0;
	}
	
	private inline function updateNodePair(node:AttackNode,
											targetNode:AttackTargetNode, time:Float):Bool {
		var xDiff:Float = targetNode.position.x - node.position.x;
		var yDiff:Float = targetNode.position.y - node.position.y;
		
		if(xDiff * xDiff + yDiff * yDiff <= node.attack.radius * node.attack.radius
				//Ignore targets in the opposite direction.
				&& xDiff * node.direction.x + yDiff * node.direction.y > 0) {
			var m:Float = 1 / Math.sqrt(xDiff * xDiff + yDiff * yDiff);
			xDiff *= m;
			yDiff *= m;
			
			node.direction.x = xDiff * 0.6 + node.direction.x * 0.4;
			node.direction.y = yDiff * 0.6 + node.direction.y * 0.4;
			
			node.direction.checkLength();
			
			return true;
		} else {
			return false;
		}
	}
}

private class AttackNode extends Node<AttackNode> {
	public var attack:Attack;
	public var health:Health;
	public var direction:Direction;
	public var position:Position;
}

private class AttackTargetNode extends Node<AttackTargetNode> {
	public var flag:AttackTarget;
	public var position:Position;
}
