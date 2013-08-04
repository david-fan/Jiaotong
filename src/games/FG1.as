/**
 * Created with IntelliJ IDEA.
 * User: david
 * Date: 8/3/13
 * Time: 9:59 PM
 * To change this template use File | Settings | File Templates.
 */
package games {
import flash.desktop.NativeApplication;
import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.display.Sprite;

import fg1.*;

import flash.events.MouseEvent;
import flash.filters.BitmapFilter;
import flash.filters.BitmapFilterQuality;
import flash.filters.GlowFilter;
import flash.utils.setTimeout;

public class FG1 extends Sprite {
    private var g:game;

    public function FG1() {

        super();
        g = new game();
        addChild(g);
        g.resultRight.visible = g.resultWrong.visible = false;
        g.a1.visible = true;
        g.a2.visible = false;
        g.a3.visible = false;
        g.a4.visible = false;
        g.endBtn.addEventListener(MouseEvent.CLICK, exit);
        setSelecteds(g.a1.i1);
        setSelecteds(g.a1.i2);
        setSelecteds(g.a2.i1);
        setSelecteds(g.a2.i2);
        setSelecteds(g.a3.i1);
        setSelecteds(g.a3.i2);
        setSelecteds(g.a4.i1);
        setSelecteds(g.a4.i2);
    }

    private function showWrong():void {

        g.resultWrong.visible = true;
        setTimeout(function ():void {
            g.resultWrong.visible = false;
        }, 1000);
    }

    private function exit(e:MouseEvent):void {
        if (g.a1.visible) {
            if (c(g.a1.i1) && !c(g.a1.i2)) {
                g.resultRight.visible = true;
                setTimeout(function ():void {
                    g.resultRight.visible = false;
                    g.a1.visible = false;
                    g.a2.visible = true;
                }, 1000);
            } else
                showWrong();
        } else if (g.a2.visible) {
            if (c(g.a2.i1) && !c(g.a2.i2)) {
                g.resultRight.visible = true;
                setTimeout(function ():void {
                    g.resultRight.visible = false;
                    g.a2.visible = false;
                    g.a3.visible = true;
                }, 1000);
            } else
                showWrong();
        } else if (g.a3.visible) {
            if (!c(g.a3.i1) && c(g.a3.i2)) {
                g.resultRight.visible = true;
                setTimeout(function ():void {
                    g.resultRight.visible = false;
                    g.a3.visible = false;
                    g.a4.visible = true;
                }, 1000);
            } else
                showWrong();
        } else if (g.a4.visible) {
            if (!c(g.a4.i1) && c(g.a4.i2)) {
                g.resultRight.visible = true;
                setTimeout(function ():void {
                    g.resultRight.visible = false;
                    NativeApplication.nativeApplication.exit();
                }, 1000);
            } else
                showWrong();

        }
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
