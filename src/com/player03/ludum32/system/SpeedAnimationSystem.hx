package com.player03.ludum32.system;

import ash.core.Node;
import ash.tools.ListIteratingSystem;
import com.player03.ashdisplay.core.Tile;
import com.player03.ludum32.component.display.Animation;
import com.player03.ludum32.component.display.SpeedAnimation;
import com.player03.ludum32.component.motion.Velocity;

/**
 * Animates entities based only on their current speed, not on their 
 * @author Joseph Cloutier
 */
class SpeedAnimationSystem extends ListIteratingSystem<SpeedAnimationNode> {
	public function new() {
		super(SpeedAnimationNode, updateNode);
	}
	
	private function updateNode(node:SpeedAnimationNode, time:Float):Void {
		var speedAnimation:SpeedAnimation = node.speedAnimation;
		var animation:Animation = speedAnimation.animation;
		
		if(node.velocity.x == 0 && node.velocity.y == 0) {
			node.tile.id = animation.tiles[0];
			return;
		}
		
		var speed:Float = Math.abs(node.velocity.x * node.velocity.x
			+ node.velocity.y * node.velocity.y);
		
		animation.frame += speed * speedAnimation.fpsMultiplier * time;
		animation.checkFrame();
		
		node.tile.id = animation.tiles[Std.int(animation.frame)];
	}
}

private class SpeedAnimationNode extends Node<SpeedAnimationNode> {
	public var speedAnimation:SpeedAnimation;
	public var velocity:Velocity;
	public var tile:Tile;
}
