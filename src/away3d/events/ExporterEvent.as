﻿package away3d.events{	import flash.events.Event;			public class ExporterEvent extends Event {		/**		* Defines the value of the type property of a complete event object.		*/		public static const COMPLETE:String = "complete";				/**		* A reference to the string generated by an exporter		*/		public var data:String;				function ExporterEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false){			super(type, bubbles, cancelable);		}			}} 