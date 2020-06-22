package;

import en.Ship;
import en.Entity;

class Game extends hxd.App 
{
    public var entities(default, default):Array<Entity> = [];

    override function init() 
    {
        hxd.Res.initEmbed();

        var ship:Ship = new Ship(s2d, this, 100, 100);
    }

    static function main() 
    {
        new Game();
    }

    public override function update(elapsed:Float) 
	{
        for (entity in entities) 
        {
			entity.update(elapsed);
		}
	}
}