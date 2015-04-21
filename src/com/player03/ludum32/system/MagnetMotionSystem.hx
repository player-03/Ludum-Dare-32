package com.player03.ludum32.system;

import ash.core.Node;
import ash.tools.ListIteratingSystem;
import com.player03.ashdisplay.core.Position;
import com.player03.ashdisplay.core.Rotation;
import com.player03.ludum32.component.motion.MagnetMotion;
import openfl.Lib;

/**
 * @author Joseph Cloutier
 */
class MagnetMotionSystem extends ListIteratingSystem<AnchorNode> {
	public function new() {
		super(AnchorNode, updateNode);
	}
	
	private function updateNode(node:AnchorNode, time:Float):Void {
		var motion:MagnetMotion = node.motion;
		var anchor:Position = motion.anchor;
		
		//Point at the mouse.
		var rotation:Float = Math.atan2(
			Lib.current.stage.mouseY - anchor.y,
			Lib.current.stage.mouseX - anchor.x);
		//Account for the fact that the image starts out pointed up.
		node.rotation.rotation = rotation + Math.PI / 2;
		
		//Rotate around the anchor.
		node.position.x = anchor.x + motion.offset * Math.cos(rotation);
		node.position.y = anchor.y + motion.offset * Math.sin(rotation);
	}
}

private class AnchorNode extends Node<AnchorNode> {
	public var motion:MagnetMotion;
	public var position:Position;
	public var rotation:Rotation;
}
