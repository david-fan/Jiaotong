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

    private var ds:Array = [];

    private var _current:MovieClip;
    private var _currentItem:Object;

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
        setupgGroup(g.group1);
        setupgGroup(g.group2);
        setupgGroup(g.group3);
        g.resultWrong.visible = g.resultRight.visible = false;
        g.submitBtn.addEventListener(MouseEvent.CLICK, onSubmit);
    }

    private function setupgGroup(g:TileList):void {
        g.addEventListener(ListEvent.ITEM_CLICK, clickUserHandler);

    }

    private function clickUserHandler(evt:ListEvent) {
        var g:TileList = e.target as TileList;
        _currentItem = e.item;
        g.dataProvider.removeItem(_currentItem);

        _current = _currentItem.source;
        g.addChild(_current);
//        _current.x = g.mouseX;
//        _current.y = g.mouseY;
//        _current.startDrag();
//        var selectedUser:Object = evt.target.getItemAt(evt.rowIndex).data;
    }

    private function onSubmit(e:MouseEvent):void {

    }

    private function updateLogo(l:MovieClip):void {
        l.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
        l.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
        ds.push({source: l, lable: ""});
    }

    private function test(e:Event):void {
        if (_current.hitTestObject(g.group1) && _currentItem != g.group1) {
//            g.group1.addChild(_current);
            g.group1.dataProvider.addItem({source: _current, from: g.group1});
            onMouseUp(null);
        } else if (_current.hitTestObject(g.group2) && _currentItem != g.group2) {
//            g.group2.addChild(_current);
            g.group2.dataProvider.addItem({source: _current, from: g.group2});
            onMouseUp(null);
        } else if (_current.hitTestObject(g.group3) && _currentItem != g.group3) {
//            g.group3.addChild(_current);
            g.group3.dataProvider.addItem({source: _current, from: g.group3});
            onMouseUp(null);
        }
    }

    private function checkItem(mc:MovieClip):void {

    }

    private function onMouseDown(e:MouseEvent):void {
        _current = MovieClip(e.target);
        _current.startDrag();

        addEventListener(Event.ENTER_FRAME, test);
    }

    private function onMouseUp(e:MouseEvent):void {
        _current.stopDrag();
        _current = null;
        removeEventListener(Event.ENTER_FRAME, test);
    }
}
}
