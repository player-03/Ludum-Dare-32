package com.player03.ludum32.system;

import ash.core.Node;
import ash.tools.ListIteratingSystem;
import com.player03.ashdisplay.core.Position;
import com.player03.ludum32.component.motion.ControlType;
import com.player03.ludum32.component.motion.Direction;
import com.player03.ludum32.Input;
import openfl.Lib;

/**
 * @author Joseph Cloutier
 */
class ControlSystem extends ListIteratingSystem<ControlSystemNode> {
	private static inline var AI_DECISION_TIME:Float = 1;
	
	private static inline var AI_MIN_EDGE_DISTANCE:Float = 100;
	
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
			
			direction.checkLength();
		} else {
			direction.aiTimer -= time;
			if(direction.aiTimer <= 0) {
				direction.aiTimer = AI_DECISION_TIME;
				
				var position:Position = node.position;
				if(position.x < AI_MIN_EDGE_DISTANCE) {
					direction.x = Math.max(direction.x, 0.1);
				} else if(position.x > Lib.current.stage.stageWidth - AI_MIN_EDGE_DISTANCE) {
					direction.x = Math.min(direction.x, -0.1);
				} else {
					direction.x += Math.random() - 0.5;
				}
				
				if(position.y < AI_MIN_EDGE_DISTANCE) {
					direction.y = Math.max(direction.y, 0.1);
				} else if(position.y > Lib.current.stage.stageHeight - AI_MIN_EDGE_DISTANCE) {
					direction.y = Math.min(direction.y, -0.1);
				} else {
					direction.y += Math.random() - 0.5;
				}
			}
			
			direction.checkLength(0.6);
		}
	}
}

private class ControlSystemNode extends Node<ControlSystemNode> {
	public var type:ControlType;
	public var direction:Direction;
	public var position:Position;
}
