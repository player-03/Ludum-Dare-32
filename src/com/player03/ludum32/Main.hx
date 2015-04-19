package com.player03.ludum32;

import ash.core.Engine;
import ash.core.Entity;
import ash.core.System;
import ash.tick.FrameTickProvider;
import com.player03.ashdisplay.core.Canvas;
import com.player03.ashdisplay.core.RenderSystem;
import com.player03.ludum32.system.AccelerationSystem;
import com.player03.ludum32.system.AnimationSystem;
import com.player03.ludum32.system.ControlSystem;
import com.player03.ludum32.system.VelocityAnimationSystem;
import com.player03.ludum32.system.VelocitySystem;
import openfl.display.Shape;
import openfl.display.Sprite;

/**
 * @author Joseph Cloutier
 */
class Main extends Sprite {
	public var engine(default, null):Engine;
	
	public function new() {
		super();
		
		engine = new Engine();
		
		var priority:Int = 0;
		for(system in getSystems()) {
			engine.addSystem(system, priority++);
		}
		
		var canvas:Shape = new Shape();
		addChild(canvas);
		engine.addEntity(new Entity().add(new Canvas(canvas.graphics)));
		
		var tickProvider:FrameTickProvider = new FrameTickProvider(this, 0.4);
		tickProvider.add(engine.update);
		tickProvider.start();
		
		Input.instance;
		
		for(entity in GameScreen.makeScreen()) {
			engine.addEntity(entity);
		}
	}
	
	private static function getSystems():Array<System> {
		return [
			//Movement
			new ControlSystem(),
			new AccelerationSystem(),
			new VelocitySystem(),
			
			//Animation
			new VelocityAnimationSystem(),
			new AnimationSystem(),
			
			//Rendering
			new RenderSystem(Images.instance.tilesheet)
		];
	}
}
