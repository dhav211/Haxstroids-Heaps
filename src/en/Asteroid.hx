package en;

import differ.Collision;
import differ.data.ShapeCollision;
import differ.shapes.Circle;
import h2d.Bitmap;
import h2d.Tile;
import h2d.Scene;
import hxmath.math.Vector2;
import seedyrng.Random;

class Asteroid extends Entity
{
    var xMoveDir:Float = 0;
    var yMoveDir:Float = 0;

    final MOVE_SPEED:Float = 150;

    var isOnScreen:Bool = false;

    public function new(_s2d:Scene, _game:Game, _x:Float, _y:Float, _xMoveDir:Float, _yMoveDir:Float) 
    {
        super(_s2d, _game, _x, _y);

        xMoveDir = _xMoveDir;
        yMoveDir = _yMoveDir;
        
        var tile:Tile=hxd.Res.asteroid_big.toTile();
        tile = tile.center();
        
        sprite = new Bitmap(tile, this);
        collisionCircle = new Circle(x, y, tile.width / 2);
    }

    public override function update(elapsed:Float) 
    {
        super.update(elapsed);

        Move(elapsed);
        Collide();

        if (isOnScreen)
            Warp();
        else
            isOnScreen = SetIsOnScreen();

    }

    function Move(_elapsed:Float)
    {
        x += xMoveDir * MOVE_SPEED * _elapsed;
        y += yMoveDir * MOVE_SPEED * _elapsed;
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
                        SpawnSmallAsteroids();

                        dispose();
                        entity.dispose();
					}
				}
			}
		}
    }

    function SetIsOnScreen():Bool
    {
        if ((x < scene.width && x > 0) && (y < scene.width && y > 0))
            return true;
        
        return false;
    }

    function SpawnSmallAsteroids() 
    {
        var moveDirections:Array<Vector2> = [];
        var random:Random = new Random();

        for (i in 0...3)
        {
            var isMoveDirectionTaken:Bool = true;
            var moveDirection:Vector2 = new Vector2(0,0);

            while (isMoveDirectionTaken)
            {
                moveDirection = new Vector2(random.randomInt(-1, 1), random.randomInt(-1, 1));

                isMoveDirectionTaken = SetIsMoveDirectionTaken(moveDirections, moveDirection);

                if (moveDirection.x == 0 && moveDirection.y == 0)
                    isMoveDirectionTaken = true;
            }

            moveDirections.push(moveDirection);
            var smallAsteroid:SmallAsteroid = new SmallAsteroid(scene, game, x, y, moveDirection.x, moveDirection.y);
        }
    }

    function SetIsMoveDirectionTaken(_moveDirections:Array<Vector2>, _moveDirection:Vector2):Bool
    {
        for (dir in _moveDirections)
		{
            if (dir == _moveDirection)
                return true;
        }
        
        return false;
    }
}