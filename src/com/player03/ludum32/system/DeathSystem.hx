package com.player03.ludum32.system;

import ash.core.Engine;
import ash.core.Node;
import ash.tools.ListIteratingSystem;
import com.player03.ashdisplay.core.Position;
import com.player03.ludum32.build.Coin;
import com.player03.ludum32.component.combat.Health;

/**
 * @author Joseph Cloutier
 */
class DeathSystem extends ListIteratingSystem<DeathNode> {
	private var engine:Engine;
	
	public function new() {
		super(DeathNode, updateNode);
	}
	
	public override function addToEngine(engine:Engine):Void {
		super.addToEngine(engine);
		this.engine = engine;
	}
	
	public override function removeFromEngine(engine:Engine):Void {
		super.removeFromEngine(engine);
		this.engine = null;
	}
	
	private function updateNode(node:DeathNode, time:Float):Void {
		if(node.health.health <= 0) {
			engine.removeEntity(node.entity);
			
			engine.addEntity(Coin.build(null, node.position.x - 4, node.position.y - 4));
			engine.addEntity(Coin.build(null, node.position.x + 4, node.position.y + 4));
		}
	}
}

//           "DeathNote"
private class DeathNode extends Node<DeathNode> {
	public var health:Health;
	public var position:Position;
}
