package com.player03.ludum32;

import com.player03.ludum32.component.display.Animation;
import com.player03.ludum32.component.display.DirectionalAnimations;
import openfl.Assets;
import openfl.display.Tilesheet;
import openfl.geom.Point;
import openfl.geom.Rectangle;

/**
 * @author Joseph Cloutier
 */
class Images implements Singleton {
	/**
	 * Two groups: the tile name ("Copper0", "Gold4", etc.) and all
	 * associated data.
	 */
	private static var TILE_MATCHER:EReg = ~/\.sprite\-(\w+) \{([\w\s:\-\(\);\r\n]+?)\}/;
	/**
	 * Two to three groups: the param name ("width", "height", or
	 * "background-position"), and one or two associated int values.
	 */
	private static var PARAM_MATCHER:EReg = ~/([\w\-]+): ?(\-?\d+)px ?(\-?\d+)?p?x?;/;
	/**
	 * Two groups: the animation name (sans frame number) and the
	 * frame number.
	 */
	private static var ANIMATION_NAME_MATCHER:EReg = ~/(\w+)(\d+)/;
	
	public var tilesheet:Tilesheet;
	public var animations:Map<String, Animation>;
	
	public var invisibleTile(default, null):Int;
	
	private function new() {
		tilesheet = new Tilesheet(Assets.getBitmapData("img/spritesheet.png"));
		animations = new Map<String, Animation>();
		
		var stylesheet:String = Assets.getText("text/stylesheet.css");
		while(TILE_MATCHER.match(stylesheet)) {
			var tileName:String = TILE_MATCHER.matched(1);
			var tileData:String = TILE_MATCHER.matched(2);
			
			var rect:Rectangle = new Rectangle();
			
			while(PARAM_MATCHER.match(tileData)) {
				var paramValue:Int = Std.parseInt(PARAM_MATCHER.matched(2));
				
				switch(PARAM_MATCHER.matched(1)) {
					case "width":
						rect.width = paramValue;
					case "height":
						rect.height = paramValue;
					case "background-position":
						rect.x = -paramValue;
						rect.y = -Std.parseInt(PARAM_MATCHER.matched(3));
					default:
						trace("Unexpected parameter: " + PARAM_MATCHER.matched(1));
				}
				
				tileData = PARAM_MATCHER.matchedRight();
			}
			
			var tileID:Int = tilesheet.addTileRect(rect,
				new Point(rect.width / 2, rect.height / 2));
			
			if(ANIMATION_NAME_MATCHER.match(tileName)) {
				var animation:Animation = animations[ANIMATION_NAME_MATCHER.matched(1)];
				if(animation == null) {
					animation = new Animation([]);
					animations[ANIMATION_NAME_MATCHER.matched(1)] = animation;
				}
				
				//Assuming the frames will be described in order in
				//stylesheet.css...
				animation.tiles.push(tileID);
			}
			
			stylesheet = TILE_MATCHER.matchedRight();
		}
		
		invisibleTile = tilesheet.addTileRect(new Rectangle());
	}
	
	public static function getDirectionalAnimations(name:String):DirectionalAnimations {
		return new DirectionalAnimations(
				instance.animations[name + "L"].clone(),
				instance.animations[name + "R"].clone(),
				instance.animations[name + "U"].clone(),
				instance.animations[name + "D"].clone());
	}
	
	public static inline function getAnimation(name:String):Animation {
		return instance.animations[name].clone();
	}
	
	public static inline function getTileRect(tileID:Int):Rectangle {
		return instance.tilesheet.getTileRect(tileID);
	}
}
