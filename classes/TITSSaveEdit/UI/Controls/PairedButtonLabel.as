package classes.TITSSaveEdit.UI.Controls 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import classes.UIComponents.UIStyleSettings;
	
	/**
	 * ...
	 * @author Gedan
	 */
	public class PairedButtonLabel extends Sprite
	{
		private var _minNum:int;
		private var _maxNum:int;
		
		private var _labelNum:int;
		private var _labelText:String;
		
		private var _label:TextField;
		private var _buttonRem:MiniButton;
		private var _buttonAdd:MiniButton;
		
		private var _onAdd:Function;
		private var _onRem:Function;
		
		public function get labelText():String { return _labelText; }
		public function set labelText(v:String):void { _labelText = v; updateLabel(); }
		
		public function get labelNum():int { return _labelNum; }
		public function set labelNum(v:int):void { _labelNum = v; updateLabel(); }
		
		public function set onAdd(v:Function):void { _onAdd = v; }
		public function set onRem(v:Function):void { _onRem = v; }
		
		public function get minNum():int { return _minNum; }
		public function set minNum(v:int):void { _minNum = v; updateLabel(); }
		
		public function get maxNum():int { return _maxNum; }
		public function set maxNum(v:int):void { _maxNum = v; updateLabel(); }
		
		public function PairedButtonLabel() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			Build();
		}
		
		private function Build():void
		{
			_buttonRem = new MiniButton();
			this.addChild(_buttonRem);
			_buttonRem.addEventListener(MouseEvent.CLICK, buttonHandler);
			_buttonRem.disable();
			_buttonRem.setRem();
			
			_buttonAdd = new MiniButton();
			this.addChild(_buttonAdd);
			_buttonAdd.x = 400 - (_buttonAdd.width + 4);
			_buttonAdd.addEventListener(MouseEvent.CLICK, buttonHandler);
			_buttonAdd.disable();
			_buttonAdd.setAdd();
			
			_label = new TextField();
			UIStyleSettings.cfgLabel(_label);
			_label.x = _buttonRem.width + 4;
			_label.width = 400 - ((_buttonRem.width + 4 ) * 2);
			_label.text = "LABEL";
		}
		
		private function updateLabel():void
		{
			updateButtonStates();
			
			_label.text = _labelText + " " + String(_labelNum);
		}
		
		private function updateButtonStates():void
		{
			if (_labelNum <= _minNum) _buttonRem.disable();
			else _buttonRem.enable();
			
			if (_labelNum >= _maxNum) _buttonAdd.disable();
			else _buttonAdd.enable();
		}
		
		private function buttonHandler(e:MouseEvent):void
		{
			if (e.currentTarget = _buttonRem)
			{
				if (_labelNum > _minNum) _labelNum--;
				if (_onRem != null) _onRem(_labelNum);
			}
			else if (e.currentTarget = _buttonAdd)
			{
				if (_labelNum < _maxNum) _labelNum++;
				if (_onAdd != null) _onAdd(_labelNum);
			}
			
			updateLabel();
		}
	}

}