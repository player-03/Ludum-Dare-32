package com.player03.ludum32.build;

import ash.core.Entity;
import com.player03.ashdisplay.core.Position;
import com.player03.ashdisplay.core.Rotation;
import com.player03.ashdisplay.core.Tile;
import com.player03.ludum32.component.motion.Force;
import com.player03.ludum32.component.motion.Mass;
import com.player03.ludum32.component.combat.Hitbox;
import com.player03.ludum32.component.combat.Projectile;
import com.player03.ludum32.component.display.Animation;
import com.player03.ludum32.component.display.SpeedAnimation;
import com.player03.ludum32.component.motion.Friction;
import com.player03.ludum32.component.motion.Velocity;
import com.player03.ludum32.component.Value;
import openfl.Lib;

/**
 * @author Joseph Cloutier
 */
class Coin {
	private static var types:Array<CoinType> =
			[CoinType.COPPER, CoinType.COPPER, CoinType.COPPER,
			CoinType.SILVER, CoinType.SILVER,
			CoinType.GOLD];
	
	public static function build(?type:CoinType, ?x:Float, ?y:Float):Entity {
		if(type == null) {
			type = types[Std.int(Math.random() * types.length)];
		}
		if(x == null) {
			x = Math.random() * Lib.current.stage.stageWidth;
		}
		if(y == null) {
			y = Math.random() * Lib.current.stage.stageHeight;
		}
		
		var coin:Entity = new Entity();
		coin.add(new Position(x, y));
		coin.add(new Rotation());
		coin.add(new Velocity());
		coin.add(new Friction(2));
		coin.add(new Mass(type));
		coin.add(new Force());
		coin.add(new Projectile(Math.round(type), true));
		coin.add(new Hitbox(20));
		coin.add(new Tile());
		
		coin.add(new Value(switch(type) {
				case COPPER:
					1;
				case SILVER:
					2;
				default:
					3;
			}));
		
		var animation:Animation =
			Images.getAnimation(switch(type) {
				case COPPER:
					"Copper";
				case SILVER:
					"Silver";
				default:
					"Gold";
			});
		animation.frame = Std.int(Math.random() * animation.tiles.length);
		coin.add(animation);
		
		return coin;
	}
}

@:enum abstract CoinType(Float) to Float {
	//These numbers are the materials' densities, in g/cm^3. And we'll say
	//that the coins are huge (1 liter each), so these numbers are also
	//their weight in kilograms.
	var COPPER = 8.96;
	var SILVER = 10.49;
	var GOLD = 19.3;
}
