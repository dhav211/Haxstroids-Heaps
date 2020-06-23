package;

import en.Ship;
import en.Entity;
import en.Asteroid;

class Game extends hxd.App 
{
    public var entities(default, default):Array<Entity> = [];
    public var asteroidFactory(default, null):AsteroidFactory;

    override function init() 
    {
        hxd.Res.initEmbed();

        asteroidFactory = new AsteroidFactory(s2d, this);

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

        asteroidFactory.update(elapsed);
    }
}