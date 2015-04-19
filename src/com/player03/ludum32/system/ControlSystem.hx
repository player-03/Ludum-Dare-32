package com.player03.ludum32.system;

import ash.core.Node;
import ash.tools.ListIteratingSystem;
import com.player03.ludum32.component.motion.ControlType;
import com.player03.ludum32.component.motion.Direction;
import com.player03.ludum32.Input;

/**
 * @author Joseph Cloutier
 */
class ControlSystem extends ListIteratingSystem<ControlSystemNode> {
	public function new() {
		super(ControlSystemNode, updateNode);
	}
	
	private function updateNode(node:ControlSystemNode, time:Float):Void {
		var direction:Direction = node.direction;
		
		if(node.type.userControl) {
			direction.x = 0;
			direction.y = 0;
			
			if(Input.check(LEFT)) {
				direction.x -= 1;
			}
			if(Input.check(RIGHT)) {
				direction.x += 1;
			}
			if(Input.check(UP)) {
				direction.y -= 1;
			}
			if(Input.check(DOWN)) {
				direction.y += 1;
			}
		} else {
			direction.x = addRandom(direction.x);
			direction.y = addRandom(direction.y);
		}
		
		direction.checkLength();
	}
	
	private inline function addRandom(value:Float):Float {
		//The larger the value already is, the more it should vary.
		return value + (Math.random() - 0.5) * (value * 0.2 + 0.1);
	}
}

private class ControlSystemNode extends Node<ControlSystemNode> {
	public var type:ControlType;
	public var direction:Direction;
}
