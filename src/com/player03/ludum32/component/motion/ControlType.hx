package com.player03.ludum32.component.motion;

/**
 * Whether the user, as opposed to the AI, controls this entity.
 * @author Joseph Cloutier
 */
class ControlType {
	public static var USER(default, null):ControlType = new ControlType(true);
	public static var AI(default, null):ControlType = new ControlType(false);
	
	public var userControl:Bool;
	
	public function new(userControl:Bool) {
		this.userControl = userControl;
	}
}
