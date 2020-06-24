package;

import h2d.Camera;
import h2d.Scene;
import en.Ship;
import en.Entity;
import en.Asteroid;
import ui.Stats;

class Game extends hxd.App 
{
    public var entities(default, default):Array<Entity> = [];
    public var asteroidFactory(default, null):AsteroidFactory;
    public var stats(default, null):Stats;

    override function init() 
    {
        hxd.Res.initEmbed();

        asteroidFactory = new AsteroidFactory(s2d, this);
        stats = new Stats(s2d, this);

        var ship:Ship = new Ship(s2d, this, s2d.width / 2, s2d.height / 2);
        

        s2d.scaleMode = Zoom(2);
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

    public function GameOver()
    {
        while (entities.length > 0)
        {
            entities[0].dispose();
        }

        var ship:Ship = new Ship(s2d, this, s2d.width / 2, s2d.height / 2);

        asteroidFactory.onGameOver();
        stats.onGameOver();
    }
}