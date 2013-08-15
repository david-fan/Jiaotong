/**
 * Created with IntelliJ IDEA.
 * User: david
 * Date: 7/21/13
 * Time: 5:32 PM
 * To change this template use File | Settings | File Templates.
 */
package games {

import flash.desktop.NativeApplication;


import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.utils.setTimeout;

import game29.*;

import org.david.ui.MDirection;

import org.david.ui.MTile;

public class Game29 extends Sprite {
    private var s:start;
    private var g:game;
    private var e:end;

    private var _current:MovieClip;

    private var _g0:MTile;
    private var _g1:MTile;
    private var _g2:MTile;
    private var _g3:MTile;

    //TODO:拖动分类
    public function Game29() {
        super();
        s = new start();
        g = new game();
        e = new end();

        _g0 = new MTile(MDirection.Horizon, 12, 5);

        _g1 = new MTile(MDirection.Horizon, 3, 2);
        _g2 = new MTile(MDirection.Horizon, 3, 2);
        _g3 = new MTile(MDirection.Horizon, 3, 2);

        g.addChild(_g0);
        _g0.x = 130+5;
        _g0.y = 150+5;

        g.addChild(_g1);
        _g1.x = 289.85+5;
        _g1.y = 433.85+5;

        g.addChild(_g2);
        _g2.x = 505.45+5;
        _g2.y = 434.5+5;

        g.addChild(_g3);
        _g3.x = 715.7+5;
        _g3.y = 432.5+5;

        g.addChild(g.resultRight);
        g.addChild(g.resultWrong);

        g.g1.alpha = g.g2.alpha = g.g3.alpha = 0;
        addChild(s);
        s.startBtn.addEventListener(MouseEvent.CLICK, onStart);
    }

    private function onStart(e:MouseEvent):void {
        addChild(g);
        g.gotoAndStop(1);

        var ls:Array = [g.logo1, g.logo2, g.logo3, g.logo4, g.logo5, g.logo6, g.logo7, g.logo8, g.logo9, g.logo10, g.logo11, g.logo12];
        for (var i:int = 0; i < ls.length; i++) {
            updateLogo(ls[i]);
        }

        g.resultWrong.visible = g.resultRight.visible = false;
        g.submitBtn.addEventListener(MouseEvent.CLICK, onSubmit);
    }

    private function onSubmit(e:MouseEvent):void {
        var g1:Boolean = checkItemInGroup([g.logo4, g.logo5, g.logo7, g.logo12], _g1);
        var g2:Boolean = checkItemInGroup([g.logo2, g.logo6, g.logo9, g.logo11], _g2);
        var g3:Boolean = checkItemInGroup([g.logo1, g.logo3, g.logo8, g.logo10], _g3);

        if (g1 && g2 && g3) {
        g.resultRight.visible = true;
            setTimeout(function ():void {
                NativeApplication.nativeApplication.exit();
            }, 1000);
        }else{
            showWrong();
        }
    }

    private function showWrong():void {
        g.resultWrong.visible = true;
        setTimeout(function ():void {
            g.resultWrong.visible = false;
        }, 1000);
    }

    private function checkItemInGroup(objects:Array, group:MTile):Boolean {
        if (group.numChildren != 4)
            return false;

        for (var i:int = 0; i < group.numChildren; i++) {
            var item:Object = group.getChildAt(i);
            if (objects.indexOf(item) < 0)
                return false;
        }
        return true;
    }

    private function updateLogo(l:MovieClip):void {
        _g0.addChild(l);
        l.scaleX = l.scaleY = 0.5;
        l.addEventListener(MouseEvent.MOUSE_DOWN, onLogoMouseDown);
        l.addEventListener(MouseEvent.MOUSE_UP, onLogoMouseUp)
    }

    private function onLogoMouseDown(e:MouseEvent):void {
        _current = MovieClip(e.target);
        _current.parent.removeChild(_current);
        g.addChild(_current);
        addEventListener(Event.ENTER_FRAME, test);
    }

    private function onLogoMouseUp(e:MouseEvent):void {
        if (_current.hitTestObject(g.g1)) {
            _g1.addChild(_current);
            onMouseUp();
        } else if (_current.hitTestObject(g.g2)) {
            _g2.addChild(_current);
            onMouseUp();
        } else if (_current.hitTestObject(g.g3)) {
            _g3.addChild(_current);
            onMouseUp();
        } else {
            _g0.addChild(_current);
            onMouseUp();
        }
    }

    private function test(e:Event):void {
        _current.x = g.mouseX - _current.width / 2;
        _current.y = g.mouseY - _current.height / 2;
    }

    private function onMouseUp():void {
        _current = null;
        removeEventListener(Event.ENTER_FRAME, test);
    }
}
}
