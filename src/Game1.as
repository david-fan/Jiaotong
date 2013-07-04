/**
 * Created with IntelliJ IDEA.
 * User: david
 * Date: 6/28/13
 * Time: 9:35 PM
 * To change this template use File | Settings | File Templates.
 */
package {
import flash.display.Sprite;

import game1.end;
import game1.game;
import game1.start;

public class Game1 extends Sprite {
    private var s:start;
    private var g:game;
    private var e:end;

    private var _gl:GameLogical;

    public function Game1() {
        super();

        s = new start();
        g = new game();
        e = new end();

        _gl = new GameLogical(this);
        _gl.setMC(s, g, e);
        _gl.setBtns(s.startBtn, g.endBtn, e.endBtn, g.resultRight, g.resultWrong);
        var items:Array = new Array();
        items.push(new SelectItem(g.person1, false));
        items.push(new SelectItem(g.person2, true));
        items.push(new SelectItem(g.person3, false));
        items.push(new SelectItem(g.person4, false));
        items.push(new SelectItem(g.person5, true));
        _gl.setSelecteds(items);
    }
}
}
