/**
 * Created with IntelliJ IDEA.
 * User: david
 * Date: 7/21/13
 * Time: 4:13 PM
 * To change this template use File | Settings | File Templates.
 */
package games {
import flash.display.Sprite;

import game11.*;

public class Game11 extends Sprite {
    private var s:start;
    private var g:game;
    private var e:end;
//TODO:拖动排序
    public function Game11() {
        super();

        s = new start();
        g = new game();
        e = new end();
    }
}
}
