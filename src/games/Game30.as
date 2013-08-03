/**
 * Created with IntelliJ IDEA.
 * User: david
 * Date: 7/21/13
 * Time: 5:34 PM
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

import game30.*;

public class Game30 extends Sprite {
    private var s:start;
    private var g:game;
    private var e:end;

    public function Game30() {
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
        setSelecteds(g.dir1);
        setSelecteds(g.dir2);
        setSelecteds(g.dir3);
        setSelecteds(g.dir4);
        setSelecteds(g.dir5);
        setSelecteds(g.dir6);
        g.left.visible = true;
        g.right.visible = false;
        g.back.visible = false;
        g.ting.visible = false;

        g.resultWrong.visible = g.resultRight.visible = false;

        g.submitBtn.addEventListener(MouseEvent.CLICK, onSubmit);
    }

    private function showWrong():void {
        g.resultWrong.visible = true;
        setTimeout(function ():void {
            g.resultWrong.visible = false;
        }, 1000 * 1);
    }

    private function showRight(callback:Function):void {
        uc(g.dir1);
        uc(g.dir2);
        uc(g.dir3);
        uc(g.dir4);
        uc(g.dir5);
        uc(g.dir6);
        g.resultRight.visible = true;
        setTimeout(function ():void {
            g.resultRight.visible = false;
            callback();
        }, 1000 * 1);
    }

    private function onSubmit(e:MouseEvent):void {
        if (g.left.visible) {
            if (c(g.dir1) && !c(g.dir2) && c(g.dir3) && !c(g.dir4) && !c(g.dir5) && !c(g.dir6)) {
                var cb:Function = function ():void {

                    g.left.visible = false;
                    g.right.visible = true;
                };
                showRight(cb);
            } else {
                showWrong();
            }
        } else if (g.right.visible) {
            if (!c(g.dir1) && c(g.dir2) && !c(g.dir3) && !c(g.dir4) && c(g.dir5) && !c(g.dir6)) {
                var cb:Function = function ():void {

                    g.right.visible = false;
                    g.back.visible = true;
                };
                showRight(cb);
            } else {
                showWrong();
            }
        } else if (g.back.visible) {
            if (!c(g.dir1) && !c(g.dir2) && !c(g.dir3) && !c(g.dir4) && !c(g.dir5) && c(g.dir6)) {
                var cb:Function = function ():void {

                    g.back.visible = false;
                    g.ting.visible = true;
                };
                showRight(cb);
            } else {
                showWrong();
            }
        } else if (g.ting.visible) {
            if (!c(g.dir1) && !c(g.dir2) && !c(g.dir3) && c(g.dir4) && !c(g.dir5) && !c(g.dir6)) {
                var cb:Function = function ():void {

                    showEnd();
                    g.ting.visible = false;
                };
                showRight(cb);
            } else {
                showWrong();
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

    private function uc(mc:MovieClip):void{
        mc.filters=[];
    }
    private function c(mc:MovieClip):Boolean {
        if (mc.filters.length == 1)
            return true;
        else
            return false;
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
