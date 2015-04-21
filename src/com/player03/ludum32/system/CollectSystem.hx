package com.player03.ludum32.system;

import ash.core.Engine;
import ash.core.Node;
import ash.core.NodeList;
import ash.tools.ListIteratingSystem;
import com.player03.ashdisplay.core.Position;
import com.player03.ludum32.component.Collection;
import com.player03.ludum32.component.combat.Hitbox;
import com.player03.ludum32.component.Value;

/**
 * @author Joseph Cloutier
 */
class CollectSystem extends ListIteratingSystem<CollectNode> {
	private var engine:Engine;
	private var secondNodeList:NodeList<CollectableNode>;
	
	public function new() {
		super(CollectNode, updateNode);
	}
	
	public override function addToEngine(engine:Engine):Void {
        super.addToEngine(engine);
		secondNodeList = engine.getNodeList(CollectableNode);
		this.engine = engine;
    }

    public override function removeFromEngine(engine:Engine):Void {
		super.removeFromEngine(engine);
		secondNodeList = null;
		this.engine = null;
	}
	
	private function updateNode(node:CollectNode, time:Float):Void {
		for(secondNode in secondNodeList) {
			updateNodePair(node, secondNode, time);
		}
	}
	
	private inline function updateNodePair(node:CollectNode,
											secondNode:CollectableNode, time:Float):Void {
		if(Hitbox.intersects(node.position, node.hitbox, secondNode.position, secondNode.hitbox)) {
			node.collection.totalValue += secondNode.value.value;
			engine.removeEntity(secondNode.entity);
			
			node.collection.outputText.text = "Score: " + node.collection.totalValue;
		}
	}
}

private class CollectNode extends Node<CollectNode> {
	public var collection:Collection;
	public var position:Position;
	public var hitbox:Hitbox;
}

private class CollectableNode extends Node<CollectableNode> {
	public var value:Value;
	public var position:Position;
	public var hitbox:Hitbox;
}
