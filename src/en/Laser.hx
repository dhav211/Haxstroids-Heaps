package en;

import h2d.Bitmap;
import h2d.Tile;
import h2d.Scene;

class Laser extends Entity
{
    final MOVE_SPEED:Float = 550;

    public function new(_s2d:Scene, _game:Game, _x:Float, _y:Float, _rotation:Float) 
    {
        super(_s2d, _game, _x, _y);

        rotation = _rotation;

        var tile:Tile=hxd.Res.laser.toTile();
        tile = tile.center();
        
        sprite = new Bitmap(tile, this);
    }

    public override function update(elapsed:Float) 
    {
        move(MOVE_SPEED * elapsed, MOVE_SPEED * elapsed);

        if (IsOutOfBounds())
            dispose();
    }

    function IsOutOfBounds():Bool
    {
        var radius:Float = 2;

        if (x > scene.width + radius)
            return true;

        if (x < -radius)
            return true;

        if (y > scene.height + radius)
            return true;

        if (y < -radius)
            return true;

        return false;
    }
}