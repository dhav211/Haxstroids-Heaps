package en;

import h2d.Bitmap;
import h2d.Object;

class Entity extends Bitmap
{
    var game:Game;

    public function new(_s2d:Object, _game:Game, _x:Float, _y:Float) 
    {
        super(_s2d);

        x = _x;
        y = _y;
        game = _game;

        game.entities.push(this);
    }

    public function update(elapsed:Float) {}
}