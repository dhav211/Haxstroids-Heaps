package en;

import h2d.Scene;
import h2d.Bitmap;
import h2d.Object;
import differ.shapes.Circle;

class Entity extends Object
{
    var game:Game;
    var scene:Scene;
    var sprite:Bitmap;
    public var collisionCircle:Circle;

    public function new(_s2d:Scene, _game:Game, _x:Float, _y:Float) 
    {
        super(_s2d);

        x = _x;
        y = _y;
        game = _game;
        scene = _s2d;

        game.entities.push(this);
    }

    public function update(elapsed:Float) 
    {
        collisionCircle.x = x;
        collisionCircle.y = y;
    }

    public function dispose()
    {
        game.entities.remove(this);
        remove();
    }
}