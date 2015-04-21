package com.player03.ludum32.system;

import ash.core.Engine;
import ash.core.Entity;
import ash.core.Node;
import ash.tools.ListIteratingSystem;
import com.player03.ludum32.build.Unit;
import com.player03.ludum32.component.spawn.EnemySpawner;

/**
 * @author Joseph Cloutier
 */
class SpawnEnemySystem extends ListIteratingSystem<SpawnEnemyNode> {
	private var engine:Engine;
	
	public function new() {
		super(SpawnEnemyNode, updateNode);
	}
	
	public override function addToEngine(engine:Engine):Void {
		super.addToEngine(engine);
		this.engine = engine;
	}
	
	public override function removeFromEngine(engine:Engine):Void {
		super.removeFromEngine(engine);
		this.engine = null;
	}
	
	private function updateNode(node:SpawnEnemyNode, time:Float):Void {
		var spawner:EnemySpawner = node.spawner;
		spawner.cooldownLeft -= time;
		
		if(spawner.cooldownLeft <= 0) {
			spawner.cooldownLeft = spawner.randomCooldown();
			
			engine.addEntity(Unit.build(
				spawner.randomSpawnX(), spawner.randomSpawnY(),
				spawner.randomAnimation()));
		}
	}
}

private class SpawnEnemyNode extends Node<SpawnEnemyNode> {
	public var spawner:EnemySpawner;
}
