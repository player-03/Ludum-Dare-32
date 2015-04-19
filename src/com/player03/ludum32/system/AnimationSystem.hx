package com.player03.ludum32.system;

import ash.core.Node;
import ash.tools.ListIteratingSystem;
import com.player03.ashdisplay.core.Tile;
import com.player03.ludum32.component.display.Animation;

/**
 * @author Joseph Cloutier
 */
class AnimationSystem extends ListIteratingSystem<AnimationNode> {
	public static inline var FPS:Float = 6;
	
	public function new() {
		super(AnimationNode, updateNode);
	}
	
	private function updateNode(node:AnimationNode, time:Float):Void {
		var animation:Animation = node.animation;
		animation.frame += FPS * time;
		animation.checkFrame();
		
		node.tile.id = animation.tiles[Std.int(animation.frame)];
	}
}

private class AnimationNode extends Node<AnimationNode> {
	public var animation:Animation;
	public var tile:Tile;
}
