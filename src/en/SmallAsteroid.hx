package en;

import differ.Collision;
import differ.data.ShapeCollision;
import differ.shapes.Circle;
import h2d.Bitmap;
import h2d.Tile;
import h2d.Scene;
import hxmath.math.Vector2;
import seedyrng.Random;

class SmallAsteroid extends Asteroid
{
    public function new(_s2d:Scene, _game:Game, _x:Float, _y:Float, _moveDirectionX:Float, _moveDirectionY:Float) 
    {
        
        isOnScreen = true;

        super(_s2d, _game, _x, _y, _moveDirectionX, _moveDirectionY);

        sprite.remove();  // since super is called it will be set as big asteroid, this will clear it so it can be set properly

        var tile:Tile=hxd.Res.asteroid_small.toTile();
        tile = tile.center();
        
        sprite = new Bitmap(tile, this);

        collisionCircle = new Circle(x, y, tile.width / 2);
    }

    override function Collide()
	{
        for (entity in game.entities) 
        {
            if (entity != this) 
            {
				var collideInfo:ShapeCollision;

                if (Std.is(entity, Laser)) 
                {
					collideInfo = Collision.shapeWithShape(collisionCircle, entity.collisionCircle);

                    if (collideInfo != null) 
                    {
                        game.stats.IncreaseScore(150);

						dispose();
						entity.dispose();
					}
				}
			}
		}
	}
}