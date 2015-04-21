package com.player03.ludum32.system;

import ash.core.Node;
import ash.tools.ListIteratingSystem;
import com.player03.ludum32.component.combat.Health;
import com.player03.ludum32.component.display.Visibility;

/**
 * @author Joseph Cloutier
 */
class MercyInvincibilitySystem extends ListIteratingSystem<MercyInvincibilityNode> {
	public static inline var CYCLE_LENGTH:Float = 0.2;
	public static var TIME_VISIBLE_PER_CYCLE:Float = 0.12;
	
	public function new() {
		super(MercyInvincibilityNode, updateNode);
	}
	
	private function updateNode(node:MercyInvincibilityNode, time:Float):Void {
		if(node.health.mercyInvincibilityLeft > 0) {
			node.health.mercyInvincibilityLeft -= time;
			
			if(node.health.mercyInvincibilityLeft <= 0) {
				node.visibility.visible = true;
			} else {
				node.visibility.visible =
					(node.health.mercyInvincibilityLeft % CYCLE_LENGTH)
					< TIME_VISIBLE_PER_CYCLE;
			}
		}
	}
}

private class MercyInvincibilityNode extends Node<MercyInvincibilityNode> {
	public var health:Health;
	public var visibility:Visibility;
}
