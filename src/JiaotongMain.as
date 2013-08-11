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
import flash.media.Sound;
import flash.net.URLRequest;

import games.*;

[SWF(width="1024", height="768")]
public class JiaotongMain extends Sprite {
    public function JiaotongMain() {
        super();
        stage.align = StageAlign.TOP_LEFT;
        stage.scaleMode = StageScaleMode.NO_SCALE;

//        var gs:Array = [Game1, Game2, Game2a,Game3, Game5, Game9, Game11,
//            Game12, Game13, Game15, Game18, Game25, Game26, Game27,
//            Game28, Game29, Game30, Game31, Game32, Game33, Game34, Game35,
//            Game36, FlvGame1, FlvGame2, FG1, FG2,JTAQ,MemoryGame,NG1];
        var gs:Array = [MemoryGame];
        var g:Class = gs[Math.floor(gs.length * Math.random())];
        showGame(g);

        var u:String = "/asset/" + (Math.floor(Math.random() * 3) + 1) + ".mp3";
        var s:Sound = new Sound(new URLRequest(u));
        s.play(0, 999);
    }

    private function showGame(gc:Class):void {
        trace(gc);
        var g1:Object = new gc();
        addChild(g1 as DisplayObject);



    }
}
}
