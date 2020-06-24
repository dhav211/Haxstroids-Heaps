package ui;

import hxd.res.DefaultFont;
import h2d.Text;
import h2d.Scene;

class Stats
{
    var score:Int = 0;

    var scoreAmount:Text;

    var scene:Scene;
    var game:Game;
    
    public function new (_s2d:Scene, _game:Game)
    {
        scene = _s2d;
        game = _game;

        scoreAmount = new Text(DefaultFont.get(), scene);
        scoreAmount.text = "" + score;
    }

    public function IncreaseScore(_value:Int)
    {
        score += _value;
        scoreAmount.text = "" + score;
    }

    public function onGameOver()
	{
        score = 0;
        scoreAmount.text = "" + score;
	}
}