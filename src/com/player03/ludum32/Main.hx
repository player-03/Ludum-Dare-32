package com.player03.ludum32;

import ash.core.Engine;
import ash.core.Entity;
import ash.core.System;
import ash.tick.FrameTickProvider;
import com.player03.ashdisplay.core.Canvas;
import com.player03.ashdisplay.core.RenderSystem;
import com.player03.ludum32.build.Battlefield;
import com.player03.ludum32.system.AccelerationSystem;
import com.player03.ludum32.system.AnimationSystem;
import com.player03.ludum32.system.AttackSystem;
import com.player03.ludum32.system.CollectSystem;
import com.player03.ludum32.system.ControlSystem;
import com.player03.ludum32.system.DeathSystem;
import com.player03.ludum32.system.ForceSystem;
import com.player03.ludum32.system.FrictionSystem;
import com.player03.ludum32.system.MagnetMotionSystem;
import com.player03.ludum32.system.MagnetSystem;
import com.player03.ludum32.system.MercyInvincibilitySystem;
import com.player03.ludum32.system.ProjectileDamageSystem;
import com.player03.ludum32.system.SpawnEnemySystem;
import com.player03.ludum32.system.SpeedAnimationSystem;
import com.player03.ludum32.system.VelocityAnimationSystem;
import com.player03.ludum32.system.VelocitySystem;
import com.player03.ludum32.system.VisibilitySystem;
import openfl.display.Shape;
import openfl.display.Sprite;
import openfl.text.TextField;

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
		
		var score:TextField = new TextField();
		score.mouseEnabled = false;
		addChild(score);
		
		var tickProvider:FrameTickProvider = new FrameTickProvider(this, 0.4);
		tickProvider.add(engine.update);
		tickProvider.start();
		
		Input.instance;
		
		for(entity in Battlefield.build(score)) {
			engine.addEntity(entity);
		}
	}
	
	private static function getSystems():Array<System> {
		return [
			//Spawning
			new SpawnEnemySystem(),
			
			//Input and AI
			new ControlSystem(),
			new AttackSystem(),
			
			//Magnetism
			new MagnetSystem(),
			
			//Movement
			new ForceSystem(),
			new AccelerationSystem(),
			new FrictionSystem(),
			new VelocitySystem(),
			new MagnetMotionSystem(),
			
			//Collisions
			new CollectSystem(),
			new ProjectileDamageSystem(),
			new DeathSystem(),
			
			//Animation
			new MercyInvincibilitySystem(),
			new VelocityAnimationSystem(),
			new SpeedAnimationSystem(),
			new AnimationSystem(),
			new VisibilitySystem(),
			
			//Rendering
			new RenderSystem(Images.instance.tilesheet, true, false, true)
		];
	}
}
