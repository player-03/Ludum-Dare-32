package com.player03.ludum32.build;

import ash.core.Entity;
import com.player03.ashdisplay.core.Position;
import com.player03.ashdisplay.core.Rotation;
import com.player03.ashdisplay.core.Tile;
import com.player03.ludum32.component.combat.Attack;
import com.player03.ludum32.component.combat.Health;
import com.player03.ludum32.component.combat.Hitbox;
import com.player03.ludum32.component.combat.Projectile;
import com.player03.ludum32.component.display.Visibility;
import com.player03.ludum32.component.motion.Acceleration;
import com.player03.ludum32.component.motion.ControlType;
import com.player03.ludum32.component.motion.Direction;
import com.player03.ludum32.component.motion.MaxSpeed;
import com.player03.ludum32.component.motion.Velocity;
import com.player03.ludum32.Images;

/**
 * @author Joseph Cloutier
 */
class Unit {
	public static function build(x:Float, y:Float, animation:String, ?speed:Float = 100, ?userControlled:Bool = false, ?health:Float = 20):Entity {
		var entity:Entity = new Entity();
		
		entity.add(new Position(x, y));
		entity.add(new Velocity());
		entity.add(new MaxSpeed(speed));
		entity.add(new Rotation());
		entity.add(new Acceleration(5));
		entity.add(new Direction());
		
		entity.add(new ControlType(userControlled));
		if(!userControlled) {
			entity.add(new Attack());
			entity.add(new Projectile(1, false));
		}
		
		entity.add(new Hitbox(15));
		if(health > 0) {
			entity.add(new Health(health, userControlled));
		}
		entity.add(new Visibility());
		
		entity.add(new Tile());
		entity.add(Images.getDirectionalAnimations(animation));
		
		return entity;
	}
}
