package com.player03.ludum32.system;

import ash.core.Engine;
import ash.core.Node;
import ash.core.NodeList;
import ash.tools.ListIteratingSystem;
import com.player03.ashdisplay.core.Position;
import com.player03.ludum32.component.combat.Health;
import com.player03.ludum32.component.combat.Hitbox;
import com.player03.ludum32.component.combat.Projectile;
import com.player03.ludum32.component.motion.Velocity;

/**
 * @author Joseph Cloutier
 */
class ProjectileDamageSystem extends ListIteratingSystem<UnitNode> {
	private var secondNodeList:NodeList<ProjectileNode>;
	
	public function new() {
		super(UnitNode, updateNode);
	}
	
	public override function addToEngine(engine:Engine):Void {
        super.addToEngine(engine);
		secondNodeList = engine.getNodeList(ProjectileNode);
    }

    public override function removeFromEngine(engine:Engine):Void {
		super.removeFromEngine(engine);
		secondNodeList = null;
	}
	
	private function updateNode(node:UnitNode, time:Float):Void {
		if(node.health.mercyInvincibilityLeft <= 0) {
			for(secondNode in secondNodeList) {
				if(node.health.playerTeam != secondNode.projectile.playerTeam
						&& secondNode.velocity.x != 0
						&& secondNode.velocity.y != 0
						&& Hitbox.intersects(node.position, node.hitbox,
									secondNode.position, secondNode.hitbox)) {
					node.health.health -= secondNode.projectile.damage;
					
					//Bounce off
					secondNode.velocity.x = -secondNode.velocity.x;
					secondNode.velocity.y = -secondNode.velocity.y;
					
					if(node.health.mercyInvincibilityLength > 0) {
						node.health.mercyInvincibilityLeft = node.health.mercyInvincibilityLength;
						break;
					}
				}
			}
		}
	}
}

private class UnitNode extends Node<UnitNode> {
	public var health:Health;
	public var position:Position;
	public var hitbox:Hitbox;
}

private class ProjectileNode extends Node<ProjectileNode> {
	public var projectile:Projectile;
	public var position:Position;
	public var velocity:Velocity;
	public var hitbox:Hitbox;
}