/**
 * Created with IntelliJ IDEA.
 * User: david
 * Date: 13-6-18
 * Time: 下午10:31
 * To change this template use File | Settings | File Templates.
 */
package {
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;

[SWF(width="1024", height="768")]
public class JiaotongMain extends Sprite {
    public function JiaotongMain() {
        super();
        stage.align = StageAlign.TOP_LEFT;
        stage.scaleMode = StageScaleMode.NO_SCALE;

        var games:Array=[Game1,Game2,Game3,Game5];
        var g:Class=games[Math.floor(games.length*Math.random())];
        showGame(g);
    }

    private function showGame(gc:Class):void{
        trace(gc);
        var g1:Object = new gc();
        addChild(g1 as DisplayObject);
    }
}
}
