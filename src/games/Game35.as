/**
 * Created with IntelliJ IDEA.
 * User: david
 * Date: 8/2/13
 * Time: 8:29 PM
 * To change this template use File | Settings | File Templates.
 */
package games {
import flash.desktop.NativeApplication;
import flash.display.Sprite;
import flash.events.MouseEvent;

import game35.*;

public class Game35 extends Sprite {
    private var s:start;
    private var g:game;
    private var e:end;
    private var _gl:GameLogical;
    public function Game35() {
        super();

        s = new start();
        g = new game();
        e = new end();
        addChild(s);
        var self:Game35 = this;
        s.startBtn.addEventListener(MouseEvent.CLICK, function (e:MouseEvent):void {
            self.addChild(g);
            g.resultRight.visible = g.resultWrong.visible = false;
            g.submitBtn.addEventListener(MouseEvent.CLICK, onSubmit);
        });
    }

    private function onSubmit(e:MouseEvent):void {
        showEnd();
    }

    private function showEnd():void {
        this.removeChild(g);
        this.addChild(e);
        e.endBtn.addEventListener(MouseEvent.CLICK, exit);

    }

    private function exit(e:MouseEvent):void {
        NativeApplication.nativeApplication.exit();
    }
}
}
