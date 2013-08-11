/**
 * Created with IntelliJ IDEA.
 * User: david
 * Date: 7/23/13
 * Time: 8:52 PM
 * To change this template use File | Settings | File Templates.
 */
package games {

import com.greensock.TweenLite;

import flash.desktop.NativeApplication;
import flash.display.DisplayObjectContainer;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.filters.BitmapFilter;
import flash.filters.BitmapFilterQuality;
import flash.filters.GlowFilter;
import flash.utils.setTimeout;

import game11.*;


public class Game11 extends Sprite {
    private var s:start;
    private var g:game;
    private var e:end;

    private var pairs:Array = [];

    public function Game11() {
        super();
        s = new start();
        g = new game();
        e = new end();

        addChild(s);
        var self:Game11 = this;

        pairs.push({mc: g.p1, order: g.item4});
        pairs.push({mc: g.p2, order: g.item2});
        pairs.push({mc: g.p3, order: g.item1});
        pairs.push({mc: g.p4, order: g.item3});
        pairs.push({mc: g.p5, order: g.item5});

        s.startBtn.addEventListener(MouseEvent.CLICK, function (e:MouseEvent):void {
            self.addChild(g);
            g.resultRight.visible = g.resultWrong.visible = false;
            g.submitBtn.addEventListener(MouseEvent.CLICK, onSubmit);
            setSelecteds(g.item1);
            setSelecteds(g.item2);
            setSelecteds(g.item3);
            setSelecteds(g.item4);
            setSelecteds(g.item5);

            layout();
        });

    }

    private function layout():void {
        for each(var item:Object in pairs) {
//            item.order.x = item.mc.x;
//            item.order.y = item.mc.y;
            TweenLite.to(item.order, 0.5, {x: item.mc.x, y: item.mc.y- 100});
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
        var result:Boolean = true;
        result = result && findByMC(g.p1) == findByOrder(g.item1);
        result = result && findByMC(g.p2) == findByOrder(g.item2);
        result = result && findByMC(g.p3) == findByOrder(g.item3);
        result = result && findByMC(g.p4) == findByOrder(g.item4);
        result = result && findByMC(g.p5) == findByOrder(g.item5);
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
                TweenLite.to(item1.order, 1, {x: item1.mc.x, y: item1.mc.y - 100});
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
