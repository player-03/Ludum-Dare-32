package com.player03.ludum32.component.spawn;

import openfl.geom.Rectangle;

/**
 * @author Joseph Cloutier
 */
class EnemySpawner {
	public var spawnPositions:Rectangle;
	
	public var animations:Array<String>;
	
	public var minCooldown:Float;
	public var maxCooldown:Float;
	public var cooldownLeft:Float = 0;
	
	public function new(spawnPositions:Rectangle, animations:Array<String>,
			minCooldown:Float = 3, maxCooldown:Float = 5) {
		this.spawnPositions = spawnPositions;
		this.animations = animations;
		this.minCooldown = minCooldown;
		this.maxCooldown = maxCooldown;
	}
	
	public inline function randomSpawnX():Float {
		return spawnPositions.x + Math.random() * spawnPositions.width;
	}
	
	public inline function randomSpawnY():Float {
		return spawnPositions.y + Math.random() * spawnPositions.height;
	}
	
	public inline function randomAnimation():String {
		return animations[Std.int(Math.random() * animations.length)];
	}
	
	public inline function randomCooldown():Float {
		return minCooldown + Math.random() * (maxCooldown - minCooldown);
	}
}
