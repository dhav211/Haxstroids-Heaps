package en;

import h2d.Scene;
import hxmath.math.Vector2;
import seedyrng.Random;

class SmallAsteroid extends Asteroid
{
    public function new(_s2d:Scene, _game:Game, _x:Float, _y:Float, _moveDirectionX:Float, _moveDirectionY:Float) 
    {
        
        isOnScreen = true;

        super(_s2d, _game, _x, _y, _moveDirectionX, _moveDirectionY);
    }
}