package com.player03.ludum32;

import ash.core.Entity;
import com.player03.ashdisplay.core.Position;
import com.player03.ashdisplay.core.Tile;
import com.player03.ludum32.component.motion.Acceleration;
import com.player03.ludum32.component.motion.ControlType;
import com.player03.ludum32.component.motion.Direction;
import com.player03.ludum32.component.motion.MaxSpeed;
import com.player03.ludum32.component.motion.Velocity;
import com.player03.ludum32.component.SpawnScreen;

/**
 * @author Joseph Cloutier
 */
class GameScreen {
	public static var screensMade(default, null):Int = 0;
	
	public static function makeScreen():Array<Entity> {
		var screenID:SpawnScreen = new SpawnScreen(screensMade);
		screensMade++;
		
		var screen:Array<Entity> = [];
		
		var pirate:Entity = new Entity();
		pirate.add(new Position(400, 400));
		pirate.add(new Velocity());
		pirate.add(new MaxSpeed(100));
		pirate.add(new Acceleration(5));
		pirate.add(new Direction());
		pirate.add(ControlType.USER);
		pirate.add(new Tile(0));
		pirate.add(Images.instance.getDirectionalAnimations("Pirate"));
		screen.push(pirate);
		
		for(entity in screen) {
			entity.add(screenID);
		}
		
		return screen;
	}
}
