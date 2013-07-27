/**
 * Created with IntelliJ IDEA.
 * User: david
 * Date: 7/23/13
 * Time: 8:52 PM
 * To change this template use File | Settings | File Templates.
 */
package games {
import away3d.loaders.Obj;

import com.greensock.TweenLite;

import flash.desktop.NativeApplication;
import flash.display.DisplayObjectContainer;
import flash.display.MovieClip;
import flash.display.MovieClip;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.filters.BitmapFilter;
import flash.filters.BitmapFilterQuality;
import flash.filters.GlowFilter;
import flash.utils.setTimeout;

import game31.*;

import org.osmf.events.DisplayObjectEvent;

public class Game31 extends Sprite {
    private var s:start;
    private var g:game;
    private var e:end;

    private var pairs:Array = [];

    public function Game31() {
        super();
        s = new start();
        g = new game();
        e = new end();

        addChild(s);
        var self:Game31 = this;

        pairs.push({mc: g.m1, order: g.order4});
        pairs.push({mc: g.m2, order: g.order2});
        pairs.push({mc: g.m3, order: g.order1});
        pairs.push({mc: g.m4, order: g.order3});

        s.startBtn.addEventListener(MouseEvent.CLICK, function (e:MouseEvent):void {
            self.addChild(g);
            g.resultRight.visible = g.resultWrong.visible = false;
            g.submitBtn.addEventListener(MouseEvent.CLICK, onSubmit);
            setSelecteds(g.order1);
            setSelecteds(g.order2);
            setSelecteds(g.order3);
            setSelecteds(g.order4);

            layout();
        });

    }

    private function layout():void {
        for each(var item:Object in pairs) {
//            item.order.x = item.mc.x;
//            item.order.y = item.mc.y;
            TweenLite.to(item.order, 0.5, {x: item.mc.x, y: item.mc.y});
        }
    }

    private function findByMC(mc:MovieClip):Object {
        for each(var item:Object in pairs) {
            if (item.mc == mc) {
                return item;
            }
        }
        return null;
    }

    private function findByOrder(order:MovieClip):Object {
        for each(var item:Object in pairs) {
            if (item.order == order) {
                return item;
            }
        }
        return null;
    }

    private function onSubmit(e:MouseEvent):void {
        var result:Boolean = true && findByMC(g.m1) == findByOrder(g.order1);
        result = result && findByMC(g.m2) == findByOrder(g.order2);
        result = result && findByMC(g.m3) == findByOrder(g.order3);
        result = result && findByMC(g.m4) == findByOrder(g.order4);
        if (!result) {
            g.resultWrong.visible = true;
            g.resultRight.visible = false;
            setTimeout(function ():void {
                g.resultWrong.visible = false;
            }, 1 * 1000);
        } else {
            g.resultWrong.visible = false;
            g.resultRight.visible = true;
            setTimeout(showEnd, 3 * 1000);
        }
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

    private function test(e:MouseEvent):void {
        for each(var item:Object in pairs) {
            if (!_current)
                return;
            if (_current == item.order)
                continue;

            if (MovieClip(item.mc).hitTestPoint(this.mouseX, this.mouseY)) {
                var item1:Object = findByOrder(_current);
                var item2:Object = findByMC(item.mc);
                item1.order = item2.order;
                item2.order = _current;
                //_current.filters=[];
                //_current.stopDrag();
                TweenLite.to(item1.order, 1, {x: item1.mc.x, y: item1.mc.y});
                return;
            }
        }
    }

    private var _current:MovieClip;

    public function setSelecteds(mc:MovieClip):void {
        var self:DisplayObjectContainer = this;
        mc.addEventListener(MouseEvent.MOUSE_DOWN, function (e:MouseEvent):void {
            _current = mc;
            var glowFilter:BitmapFilter = getBitmapFilter();
            mc.filters = [glowFilter];
            mc.startDrag();
            self.addEventListener(MouseEvent.MOUSE_MOVE, test);

        });
        mc.addEventListener(MouseEvent.MOUSE_UP, function (e:MouseEvent):void {
            _current = null;
            mc.filters = [];
            mc.stopDrag();
            self.removeEventListener(MouseEvent.MOUSE_MOVE, test);
            layout();
        })
        mc.filters = [];
        mc.useHandCursor = true;
        mc.buttonMode = true;
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
