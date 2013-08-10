/**
 * Created with IntelliJ IDEA.
 * User: david
 * Date: 7/21/13
 * Time: 5:32 PM
 * To change this template use File | Settings | File Templates.
 */
package games {
import fl.controls.TileList;
import fl.events.ListEvent;

import flash.display.DisplayObject;

import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Point;

import game29.*;

public class Game29 extends Sprite {
    private var s:start;
    private var g:game;
    private var e:end;

    private var _current:MovieClip;
    private var _from:TileList;

    //TODO:拖动分类
    public function Game29() {
        super();
        s = new start();
        g = new game();
        e = new end();

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
        setupGroup(g.group1);
        setupGroup(g.group2);
        setupGroup(g.group3);
        g.resultWrong.visible = g.resultRight.visible = false;
        g.submitBtn.addEventListener(MouseEvent.CLICK, onSubmit);
    }

    private function setupGroup(g:TileList):void {
        g.addEventListener(ListEvent.ITEM_CLICK, clickUserHandler);
    }

    private function clickUserHandler(evt:ListEvent) {
        _from = evt.target as TileList;
        _from.dataProvider.removeItem(evt.item);

        _current = evt.item.source;
        g.addChildAt(_current, g.numChildren - 1);
        _current.x = g.mouseX - _current.width / 2;
        _current.y = g.mouseY - _current.height / 2;
        _current.startDrag();
        addEventListener(Event.ENTER_FRAME, test);
    }

    private function onSubmit(e:MouseEvent):void {

    }

    private function updateLogo(l:MovieClip):void {
        l.addEventListener(MouseEvent.CLICK, onLogoClick);
    }

    private function test(e:Event):void {
        if (_current.hitTestObject(g.group1)) {
            if (_from == g.group1)
                return;
            g.group1.dataProvider.addItem({source: _current});
            onMouseUp();
        } else if (_current.hitTestObject(g.group2)) {
            if (_from == g.group2)
                return;
            g.group2.dataProvider.addItem({source: _current});
            onMouseUp();
        } else if (_current.hitTestObject(g.group3)) {
            if (_from == g.group3)
                return;
            g.group3.dataProvider.addItem({source: _current});
            onMouseUp();
        }
    }

    private function onLogoClick(e:MouseEvent):void {
        if (_current) {
            onMouseUp();
        } else {
            _current = MovieClip(e.target);
            g.addChildAt(_current, g.numChildren - 1);
            _current.x = g.mouseX - _current.width / 2;
            _current.y = g.mouseY - _current.height / 2;
            _current.startDrag();
            _from = null;
            addEventListener(Event.ENTER_FRAME, test);
        }
    }

    private function onMouseUp():void {
        _current.stopDrag();
        _current = null;
        removeEventListener(Event.ENTER_FRAME, test);
    }
}
}
