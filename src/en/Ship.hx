package en;

import h2d.Scene;
import hxd.Math;
import hxd.res.DefaultFont;
import hxd.Key;
import h2d.Bitmap;
import hxd.Res;
import h2d.Object;


class Ship extends Entity
{
    final MAX_SPEED:Float = 500;
    final ACCLERATION_TIME:Float = 100;

    var currentSpeed:Float = 0;
    var scene:Scene;

    public function new(_s2d:Scene, _game:Game, _x:Float, _y:Float) 
    {
        super(_s2d, _game, _x,_y);
        scene = _s2d;
        tile=hxd.Res.ship.toTile();
        tile = tile.center();
        
        set_tile(tile);
    }

    public override function update(elapsed:Float) 
    {
        var up:Bool = Key.isDown(Key.UP);
        var down:Bool = Key.isDown(Key.DOWN);
        var right:Bool = Key.isDown(Key.RIGHT);
        var left:Bool = Key.isDown(Key.LEFT);

        if (up && down)
            up = down = false;
        if (left && right)
            right = left = false;

        SetCurrentSpeed(up);

        move(currentSpeed * elapsed, currentSpeed * elapsed);

        Warp();
        
        if (right)
        {
            rotate(5 * elapsed);
        }
        if (left)
        {
            rotate(-5 * elapsed);
        }
    }

    function SetCurrentSpeed(_up:Bool)
    {
        if (_up)
        {
            if (currentSpeed < MAX_SPEED)
                currentSpeed += GetAccleration();
        }
        else
        {
            if (currentSpeed > 0)
                currentSpeed -= GetAccleration();
            if (currentSpeed < 0)
                currentSpeed = 0;
        }
    }

    function GetAccleration():Float
    {
        return MAX_SPEED / ACCLERATION_TIME;
    }

    function Warp()
    {
        var radius:Float = 8;

        if (x > scene.width + radius)
            x = -radius;

        if (x < -radius)
            x = scene.width + radius;

        if (y > scene.height + radius)
            y = -radius;

        if (y < -radius)
            y = scene.height + radius;
    }
}