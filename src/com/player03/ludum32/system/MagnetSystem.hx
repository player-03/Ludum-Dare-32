package com.player03.ludum32.system;

import ash.core.Node;
import ash.core.NodeList;
import ash.core.Engine;
import ash.tools.ListIteratingSystem;
import com.player03.ashdisplay.core.Position;
import com.player03.ashdisplay.core.Rotation;
import com.player03.ludum32.component.motion.Force;
import com.player03.ludum32.component.motion.Mass;
import com.player03.ludum32.component.combat.Magnet;
import com.player03.ludum32.component.motion.Velocity;

/**
 * @author Joseph Cloutier
 */
class MagnetSystem extends ListIteratingSystem<MagnetNode> {
	private var secondNodeList:NodeList<MassNode>;
	
	public function new() {
		super(MagnetNode, updateNode);
	}
	
	public override function addToEngine(engine:Engine):Void {
        super.addToEngine(engine);
		secondNodeList = engine.getNodeList(MassNode);
    }

    public override function removeFromEngine(engine:Engine):Void {
		super.removeFromEngine(engine);
		secondNodeList = null;
	}
	
	private function updateNode(node:MagnetNode, time:Float):Void {
		for(secondNode in secondNodeList) {
			updateNodePair(node, secondNode, time);
		}
	}
	
	private inline function updateNodePair(node:MagnetNode,
											secondNode:MassNode, time:Float):Void {
		var xDiff:Float = secondNode.position.x - node.position.x;
		var yDiff:Float = secondNode.position.y - node.position.y;
		if(xDiff * xDiff + yDiff * yDiff <= node.magnet.distance * node.magnet.distance) {
			var angleDiff:Float = Math.atan2(yDiff, xDiff) + Math.PI / 2
				- node.rotation.rotation;
			
			//Account for the situation where the angles are more than
			//360 degrees apart.
			while(angleDiff > Math.PI) {
				angleDiff -= Math.PI * 2;
			}
			while(angleDiff <= -Math.PI) {
				angleDiff += Math.PI * 2;
			}
			
			if(Math.abs(angleDiff) < node.magnet.angle) {
				//Normalize and invert the offset vector so that it points
				//towards the magnet.
				var m:Float = -node.magnet.strength
					/ Math.sqrt(xDiff * xDiff + yDiff * yDiff);
				
				secondNode.force.x = xDiff * m;
				secondNode.force.y = yDiff * m;
			}
		}
	}
}

private class MagnetNode extends Node<MagnetNode> {
	public var magnet:Magnet;
	public var position:Position;
	public var rotation:Rotation;
}

private class MassNode extends Node<MassNode> {
	public var mass:Mass;
	public var force:Force;
	public var position:Position;
}
