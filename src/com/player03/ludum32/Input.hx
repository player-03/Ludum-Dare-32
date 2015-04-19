package com.player03.ludum32;

import com.player03.haxeutils.Key;
import openfl.display.Stage;
import openfl.Lib;
import openfl.ui.Keyboard;

/**
 * @author Joseph Cloutier
 */
class Input implements Singleton {
	public static inline function check(type:InputType):Bool {
		return instance.inputs[type].keyPressed();
	}
	
	private var inputs:Array<KeyGroup>;
	
	public function new() {
		Key.init();
		
		inputs = [for(i in 0...6) null];
		
		//This accounts for the QWERTY, QWERTZ, and Dvorak keyboards,
		//plus allows the arrows as an option for Colemak users like me.
		//(It's a little awkward to use Shift as my action key, but less
		//than switching my keyboard layout every time I start.)
		inputs[InputType.LEFT] = [Keyboard.LEFT, Keyboard.A, Keyboard.Q];
		inputs[InputType.RIGHT] = [Keyboard.RIGHT, Keyboard.D, Keyboard.E];
		inputs[InputType.UP] = [Keyboard.UP, Keyboard.W, Keyboard.Z, Keyboard.COMMA];
		inputs[InputType.DOWN] = [Keyboard.DOWN, Keyboard.S, Keyboard.O];
		inputs[InputType.ACTION] = [Keyboard.SPACE, Keyboard.X, Keyboard.C, Keyboard.V, Keyboard.SHIFT];
		inputs[InputType.PAUSE] = [Keyboard.ESCAPE, Keyboard.P, Keyboard.ENTER, Keyboard.BACKSPACE];
		
		//Basically, I included every key that I think someone, somewhere
		//MIGHT want to use.
	}
}

@:enum abstract InputType(Int) to Int {
	var LEFT = 0;
	var RIGHT = 1;
	var UP = 2;
	var DOWN = 3;
	var ACTION = 4;
	var PAUSE = 5;
}

private abstract KeyGroup(Array<UInt>) from Array<UInt> {
	public function keyPressed():Bool {
		for(key in this) {
			if(Key.isDown(key)) {
				return true;
			}
		}
		return false;
	}
}
