/**
 * Created with IntelliJ IDEA.
 * User: david
 * Date: 13-6-18
 * Time: 下午10:31
 * To change this template use File | Settings | File Templates.
 */
package {
import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;

[SWF(width="1024", height="768")]
public class JiaotongMain extends Sprite {
    public function JiaotongMain() {
        super();
        stage.align = StageAlign.TOP_LEFT;
        stage.scaleMode = StageScaleMode.NO_SCALE;

        var g3:Game3 = new Game3();
        addChild(g3);
    }
}
}
