package en;

import differ.Collision;
import differ.data.ShapeCollision;
import differ.shapes.Circle;
import h2d.Bitmap;
import h2d.Tile;
import h2d.Scene;

class Asteroid extends Entity
{
    public function new(_s2d:Scene, _game:Game, _x:Float, _y:Float) 
    {
        super(_s2d, _game, _x, _y);
        
        var tile:Tile=hxd.Res.asteroid_big.toTile();
        tile = tile.center();
        
        sprite = new Bitmap(tile, this);
        collisionCircle = new Circle(x, y, tile.width / 2);
    }

    public override function update(elapsed:Float) 
    {
        super.update(elapsed);
        Collide();
    }

    function Collide()
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
                        // TURN INTO SMALLER ASTEROIDS
                        dispose();
                        entity.dispose();
					}
				}
			}
		}
    }
}