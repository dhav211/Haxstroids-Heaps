package en;

import differ.data.ShapeCollision;
import h2d.Tile;
import h2d.Scene;
import hxd.Math;
import hxd.res.DefaultFont;
import hxd.Key;
import h2d.Bitmap;
import hxd.Res;
import h2d.Object;
import differ.shapes.Circle;
import differ.Collision;


class Ship extends Entity
{
    final MAX_SPEED:Float = 500;
    final ACCLERATION_TIME:Float = 100;

    var currentSpeed:Float = 0;

    public function new(_s2d:Scene, _game:Game, _x:Float, _y:Float) 
    {
        super(_s2d, _game, _x,_y);
        
        var tile:Tile=hxd.Res.ship.toTile();
        tile = tile.center();
        
        sprite = new Bitmap(tile, this);
        collisionCircle = new Circle(x, y, tile.width / 2);
    }

    public override function update(elapsed:Float) 
    {
        super.update(elapsed);

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

        FireLaser();

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

    function FireLaser() 
    {
        var firePressed:Bool = Key.isPressed(Key.SPACE);

        if (firePressed)
        {
            var laser:Laser = new Laser(scene, game, x, y, rotation);
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

    function Collide()
    {
        for (entity in game.entities)
		{
            if (entity != this) 
            {
				var collideInfo:ShapeCollision;

                if (Std.is(entity, Asteroid)) 
                {
					collideInfo = Collision.shapeWithShape(collisionCircle, entity.collisionCircle);

                    if (collideInfo != null) 
                    {
						// PLAYER DEATH FUNCTION
					}
				}
			}
		}
    }
}