import h2d.Scene;
import seedyrng.Random;
import hxmath.math.Vector2;
import en.Asteroid;

class AsteroidFactory
{
    var spawnTime:Float = 10;
    var currentSpawnTime:Float = 0;

    var game:Game;
    var scene:Scene;
    var random:Random = new Random();

    public function new(_s2d:Scene, _game:Game) 
    {
        game = _game;
        scene = _s2d;
    }

    public function update(elapsed:Float)
    {
        if (currentSpawnTime > 0)
        {
            currentSpawnTime -= elapsed;
        }
        if (currentSpawnTime <= 0)
        {
            var screenCenter:Vector2 = new Vector2(scene.width / 2, scene.height / 2);
            var spawnPosition:Vector2 = new Vector2(SetXSpawnPosition(), SetYSpawnPosition());

            var moveDirection:Vector2 = screenCenter - spawnPosition;

            moveDirection.normalize();

            var asteroid = new Asteroid(scene, game, spawnPosition.x, spawnPosition.y, moveDirection.x, moveDirection.y);

            currentSpawnTime = spawnTime;
        }
    }

    function SetXSpawnPosition():Float
    {
        var xPos:Float = 0;

        while (xPos >= -16 && xPos <= scene.width + 16)
        {
            xPos = random.randomInt(-50, scene.width + 50);
        }

        return xPos;
    }

    function SetYSpawnPosition():Float
    {
        var yPos:Float = random.randomInt(-50, scene.height + 50);

        return yPos;
    }
}