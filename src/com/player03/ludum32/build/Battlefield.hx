package com.player03.ludum32.build;

import ash.core.Entity;
import com.player03.ashdisplay.core.Position;
import com.player03.ashdisplay.core.Rotation;
import com.player03.ashdisplay.core.Tile;
import com.player03.ludum32.build.Coin.CoinType;
import com.player03.ludum32.component.Collection;
import com.player03.ludum32.component.combat.AttackTarget;
import com.player03.ludum32.component.combat.Magnet;
import com.player03.ludum32.component.display.DirectionalAnimations;
import com.player03.ludum32.component.motion.MagnetMotion;
import com.player03.ludum32.component.spawn.EnemySpawner;
import com.player03.ludum32.Images;
import openfl.geom.Rectangle;
import openfl.Lib;
import openfl.text.TextField;

/**
 * @author Joseph Cloutier
 */
class Battlefield {
	public static function build(scoreText:TextField):Array<Entity> {
		var battlefield:Array<Entity> = [];
		
		var pirate:Entity = Unit.build(100, 300, "Pirate", 90, true);
		pirate.add(new AttackTarget());
		pirate.add(new Collection(scoreText));
		battlefield.push(pirate);
		
		var magnet:Entity = new Entity();
		magnet.add(new Position());
		magnet.add(new Rotation());
		magnet.add(new MagnetMotion(pirate, 40));
		magnet.add(new Magnet(5000, 400, Math.PI / 4));
		magnet.add(Images.getAnimation("Magnet"));
		magnet.add(new Tile());
		battlefield.push(magnet);
		
		var enemyAnimations:Array<String> = ["Archer", "Boss", "Priest", "Princess", "Warrior"];
		battlefield.push(new Entity().add(new EnemySpawner(
			new Rectangle(Lib.current.stage.stageWidth + 20, 0,
				0, Lib.current.stage.stageHeight), enemyAnimations)));
		
		for(i in 0...20) {
			battlefield.push(Coin.build());
		}
		
		return battlefield;
	}
}
