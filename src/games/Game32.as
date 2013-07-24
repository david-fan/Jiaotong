/**
 * Created with IntelliJ IDEA.
 * User: david
 * Date: 7/23/13
 * Time: 9:41 PM
 * To change this template use File | Settings | File Templates.
 */
package games {
import flash.display.Sprite;
import game32.*;

public class Game32 extends Sprite {
    private var s:start;
    private var g:game;
    private var e:end;
    private var _gl:GameLogical;
    public function Game32() {
        super();
        s = new start();
        g = new game();
        e = new end();

        _gl = new GameLogical(this);
        _gl.setMC(s, g, e);
        _gl.setBtns(s.startBtn, g.submitBtn, e.endBtn, g.resultRight, g.resultWrong);
        var items:Array = new Array();
        items.push(new SelectItem(g.clip1, true));
        items.push(new SelectItem(g.clip2, false));
        items.push(new SelectItem(g.clip3, false));
        items.push(new SelectItem(g.clip4, true));
        items.push(new SelectItem(g.clip5, true));
        _gl.setSelecteds(items);
    }
}
}
