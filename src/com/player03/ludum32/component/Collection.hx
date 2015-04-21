package com.player03.ludum32.component;

import openfl.text.TextField;

/**
 * Causes the entity to pick up anything with value.
 * @author Joseph Cloutier
 */
class Collection {
	public var totalValue:Int = 0;
	
	public var outputText:TextField;
	
	public function new(outputText:TextField) {
		this.outputText = outputText;
	}
}
