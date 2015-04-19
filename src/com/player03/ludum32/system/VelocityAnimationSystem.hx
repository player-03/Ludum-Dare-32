package com.player03.ludum32.system;

import ash.core.Node;
import ash.tools.ListIteratingSystem;
import com.player03.ashdisplay.core.Tile;
import com.player03.ludum32.component.display.Animation;
import com.player03.ludum32.component.display.DirectionalAnimations;
import com.player03.ludum32.component.motion.MaxSpeed;
import com.player03.ludum32.component.motion.Velocity;

/**
 * Animates an entity based on its current speed and direction.
 * @author Joseph Cloutier
 */
class VelocityAnimationSystem extends ListIteratingSystem<VelocityAnimationNode> {
	public static inline var MAX_FPS:Float = 6;
	
	public function new() {
		super(VelocityAnimationNode, updateNode);
	}
	
	private function updateNode(node:VelocityAnimationNode, time:Float):Void {
		var velocity:Velocity = node.velocity;
		var animation:Animation;
		
		if(velocity.x == 0 && velocity.y == 0) {
			animation = node.animations.mostRecentAnimation;
			animation.frame = 0;
		} else {
			if(Math.abs(velocity.x) > Math.abs(velocity.y)) {
				if(velocity.x > 0) {
					animation = node.animations.right;
				} else {
					animation = node.animations.left;
				}
			} else {
				if(velocity.y > 0) {
					animation = node.animations.down;
				} else {
					animation = node.animations.up;
				}
			}
			
			if(node.animations.mostRecentAnimation != animation) {
				animation.frame = node.animations.mostRecentAnimation.frame;
				node.animations.mostRecentAnimation = animation;
			}
			
			var speed:Float = Math.sqrt(velocity.x * velocity.x + velocity.y * velocity.y);
			animation.frame += speed / node.maxSpeed.speed * MAX_FPS * time;
			
			animation.checkFrame();
		}
		
		node.tile.id = animation.tiles[Std.int(animation.frame)];
	}
}

private class VelocityAnimationNode extends Node<VelocityAnimationNode> {
	public var animations:DirectionalAnimations;
	public var velocity:Velocity;
	public var maxSpeed:MaxSpeed;
	public var tile:Tile;
}
