/**
 * Created with IntelliJ IDEA.
 * User: david
 * Date: 8/3/13
 * Time: 9:59 PM
 * To change this template use File | Settings | File Templates.
 */
package games {
import fl.text.TLFTextField;

import flash.desktop.NativeApplication;
import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.display.Sprite;

import fg1.*;

import flash.events.MouseEvent;
import flash.filters.BitmapFilter;
import flash.filters.BitmapFilterQuality;
import flash.filters.GlowFilter;
import flash.text.TextField;
import flash.utils.setTimeout;

public class FG1 extends Sprite {
    private var s:start;
    private var g:game;
    private var e:end;
    private var des:Array = [];

    public function FG1() {
        super();
        s=new start();
        addChild(s);
        s.startBtn.addEventListener(MouseEvent.CLICK, onStart);
    }

    private function onStart(e:MouseEvent):void{
        removeChild(s);
        showgame();
    }

    private function showEnd():void{
        removeChild(g);
        e=new end();
        addChild(e);
        e.endBtn.addEventListener(MouseEvent.CLICK, onExit);
    }

    private function onExit(e:MouseEvent):void{
        NativeApplication.nativeApplication.exit();
    }

    private function showgame():void{
        g = new game();
        addChild(g);
        g.resultRight.visible = g.resultWrong.visible = false;
        g.a1.visible = true;
        g.a2.visible = false;
        g.a3.visible = false;
        g.a4.visible = false;
        g.submitBtn.addEventListener(MouseEvent.CLICK, exit);
        setSelecteds(g.a1.i1);
        setSelecteds(g.a1.i2);
        setSelecteds(g.a2.i1);
        setSelecteds(g.a2.i2);
        setSelecteds(g.a3.i1);
        setSelecteds(g.a3.i2);
        setSelecteds(g.a4.i1);
        setSelecteds(g.a4.i2);

        des.push({mc: g.a1, w: "过马路之前，在人行道上你要看清来往车辆。", r: "这个同学已经停止在过马路最安全的地方吗？"});
        des.push({mc: g.a2, w: "过马路前要环顾四周，因为任何方向都可能有车辆驶来。", r: "过马路的时候，你应该怎样查看路面的情况？"});
        des.push({mc: g.a3, w: "过马路时，不要和人聊天、听音乐或接打电话。", r: "看看谁准备好安全过马路了？"});
        des.push({mc: g.a4, w: "过马路时应抓紧时间，不玩耍打闹或者快跑。", r: "过马路时，怎样做是安全的？"});

        TLFTextField(g.panel.title).textColor=0x5BC5BF;
        g.panel.title.text = getCurrentDes().r;
    }

    private function getCurrentDes():Object {
        for each(var item:Object in des) {
            if (item.mc.visible) {
                return item;
            }
        }
        return null;
    }

    private function showWrong():void {
        g.panel.title.textColor=0xfd6b12;
        g.panel.title.text = getCurrentDes().w;
        g.resultWrong.visible = true;
        setTimeout(function ():void {
            TLFTextField(g.panel.title).textColor=0x5BC5BF;
            g.panel.title.text = getCurrentDes().r;
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
                    TLFTextField(g.panel.title).textColor=0x5BC5BF;
                    g.panel.title.text = getCurrentDes().r;
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
                    TLFTextField(g.panel.title).textColor=0x5BC5BF;
                    g.panel.title.text = getCurrentDes().r;
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
                    TLFTextField(g.panel.title).textColor=0x5BC5BF;
                    g.panel.title.text = getCurrentDes().r;
                }, 1000);
            } else
                showWrong();
        } else if (g.a4.visible) {
            if (!c(g.a4.i1) && c(g.a4.i2)) {
                g.resultRight.visible = true;

                setTimeout(function ():void {
                    g.resultRight.visible = false;
                    //NativeApplication.nativeApplication.exit();
                    showEnd();
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
