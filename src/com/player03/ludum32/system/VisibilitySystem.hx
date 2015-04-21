package com.player03.ludum32.system;

import ash.core.Node;
import ash.tools.ListIteratingSystem;
import com.player03.ashdisplay.core.Tile;
import com.player03.ludum32.component.display.Visibility;
import com.player03.ludum32.Images;

/**
 * @author Joseph Cloutier
 */
class VisibilitySystem extends ListIteratingSystem<VisibilityNode> {
	public function new() {
		super(VisibilityNode, updateNode);
	}
	
	private function updateNode(node:VisibilityNode, time:Float):Void {
		if(node.visibility.visible) {
			if(node.tile.id == Images.instance.invisibleTile) {
				node.tile.id = node.visibility.oldFrame;
			}
		} else {
			if(node.tile.id != Images.instance.invisibleTile) {
				node.visibility.oldFrame = node.tile.id;
				node.tile.id = Images.instance.invisibleTile;
			}
		}
	}
}

private class VisibilityNode extends Node<VisibilityNode> {
	public var visibility:Visibility;
	public var tile:Tile;
}
