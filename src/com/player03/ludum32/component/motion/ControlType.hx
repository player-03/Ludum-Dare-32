package com.player03.ludum32.component.motion;

/**
 * Whether the user, as opposed to the AI, controls this entity.
 * @author Joseph Cloutier
 */
class ControlType {
	public var userControl:Bool;
	
	public function new(userControl:Bool) {
		this.userControl = userControl;
	}
}
