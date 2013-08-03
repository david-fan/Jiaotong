/**
 * Created with IntelliJ IDEA.
 * User: david
 * Date: 7/23/13
 * Time: 9:45 PM
 * To change this template use File | Settings | File Templates.
 */
package games {
import flash.desktop.NativeApplication;
import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.filters.BitmapFilter;
import flash.filters.BitmapFilterQuality;
import flash.filters.GlowFilter;
import flash.utils.setTimeout;

import game33.*;

public class Game33 extends Sprite {
    private var s:start;
    private var g:game;
    private var e:end;

    private var _w:DisplayObject;
    private var _r:DisplayObject;

    public function Game33() {
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
        setSelecteds(g.leftDoor);
        setSelecteds(g.rightDoor);
        _w = g.resultWrong;
        _r = g.resultRight;
        _r.visible = _w.visible = false;
        g.submitBtn.addEventListener(MouseEvent.CLICK, onSubmit);
    }

    private function onSubmit(e:MouseEvent):void {
        if (g.currentFrame == 1) {
            if (g.leftDoor.filters.length == 1) {
                _w.visible = true;
                _r.visible = false;
                setTimeout(function ():void {
                    _w.visible = false;
                }, 1 * 1000);
            } else if (g.rightDoor.filters.length == 1) {
                _w.visible = false;
                _r.visible = true;

                setTimeout(function ():void {

                    g.gotoAndStop(2);
                    setSelecteds(g.behind);
                    setSelecteds(g.front);

                    _w.visible = false;
                    _r.visible = false;
                }, 1 * 1000);
            }
        } else {
            if (g.front.filters.length == 1) {
                _w.visible = true;
                _r.visible = false;
                setTimeout(function ():void {
                    _w.visible = false;
                }, 1 * 1000);
            } else if (g.behind.filters.length == 1) {
                _w.visible = false;
                _r.visible = true;

                setTimeout(showEnd, 3 * 1000);
            }
        }
    }

    private function showEnd():void {
        this.removeChild(g);
        this.addChild(e);
        e.endBtn.addEventListener(MouseEvent.CLICK, exit);

    }

    private function exit(e:MouseEvent):void {
        NativeApplication.nativeApplication.exit();
    }

    private function getBitmapFilter():BitmapFilter {
        var color:Number = 0x33CCFF;
        var alpha:Number = 0.8;
        var blurX:Number = 10;
        var blurY:Number = 10;
        var strength:Number = 5;
        var inner:Boolean = false;
        var knockout:Boolean = false;
        var quality:Number = BitmapFilterQuality.HIGH;

        return new GlowFilter(color,
                alpha,
                blurX,
                blurY,
                strength,
                quality,
                inner,
                knockout);
    }

    public function setSelecteds(mc:MovieClip):void {
        mc.addEventListener(MouseEvent.CLICK, onItemClick);
        mc.filters = [];
        mc.useHandCursor = true;
        mc.buttonMode = true;
    }

    private function onItemClick(e:MouseEvent):void {
        var glowFilter:BitmapFilter = getBitmapFilter();
        var item:DisplayObject = e.currentTarget as DisplayObject;
        if (item.filters.length == 0)
            item.filters = [glowFilter];
        else
            item.filters = [];
    }
}
}
