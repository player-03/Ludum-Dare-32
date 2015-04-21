package com.player03.ludum32.component.display;

/**
 * @author Joseph Cloutier
 */
class Animation {
	/**
	 * The current frame being displayed. Round this down.
	 */
	public var frame:Float = 0;
	/**
	 * The tile id of each frame.
	 */
	public var tiles:Array<Int>;
	
	public function new(tiles:Array<Int>) {
		this.tiles = tiles;
	}
	
	public inline function checkFrame():Void {
		while(frame >= tiles.length) {
			frame -= tiles.length;
		}
	}
	
	public inline function clone():Animation {
		return new Animation(tiles);
	}
}
