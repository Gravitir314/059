//com.company.assembleegameclient.game.MapUserInput

package com.company.assembleegameclient.game
{
	import com.company.assembleegameclient.game.events.ReconnectEvent;
	import com.company.assembleegameclient.map.Square;
	import com.company.assembleegameclient.objects.GameObject;
	import com.company.assembleegameclient.objects.ObjectLibrary;
	import com.company.assembleegameclient.objects.ObjectProperties;
	import com.company.assembleegameclient.objects.Player;
	import com.company.assembleegameclient.objects.Portal;
	import com.company.assembleegameclient.parameters.Parameters;
	import com.company.assembleegameclient.tutorial.Tutorial;
	import com.company.assembleegameclient.tutorial.doneAction;
	import com.company.assembleegameclient.ui.options.Options;
	import com.company.assembleegameclient.util.TextureRedrawer;
	import com.company.assembleegameclient.util.redrawers.GlowRedrawer;
	import com.company.util.KeyCodes;
	import com.company.util.PointUtil;

	import flash.display.Stage;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Matrix3D;
	import flash.geom.Point;
	import flash.geom.Vector3D;
	import flash.system.Capabilities;
	import flash.ui.GameInputDevice;
	import flash.utils.getTimer;

	import io.decagames.rotmg.social.SocialPopupView;
	import io.decagames.rotmg.ui.popups.signals.CloseAllPopupsSignal;
	import io.decagames.rotmg.ui.popups.signals.ClosePopupByClassSignal;
	import io.decagames.rotmg.ui.popups.signals.ShowPopupSignal;

	import kabam.rotmg.application.api.ApplicationSetup;
	import kabam.rotmg.chat.control.ParseChatMessageSignal;
	import kabam.rotmg.chat.model.ChatMessage;
	import kabam.rotmg.constants.GeneralConstants;
	import kabam.rotmg.constants.UseType;
	import kabam.rotmg.core.StaticInjectorContext;
	import kabam.rotmg.core.view.Layers;
	import kabam.rotmg.dialogs.control.CloseDialogsSignal;
	import kabam.rotmg.dialogs.control.OpenDialogSignal;
	import kabam.rotmg.game.model.PotionInventoryModel;
	import kabam.rotmg.game.model.UseBuyPotionVO;
	import kabam.rotmg.game.signals.AddTextLineSignal;
	import kabam.rotmg.game.signals.ExitGameSignal;
	import kabam.rotmg.game.signals.GiftStatusUpdateSignal;
	import kabam.rotmg.game.signals.SetTextBoxVisibilitySignal;
	import kabam.rotmg.game.signals.UseBuyPotionSignal;
	import kabam.rotmg.game.view.components.StatsTabHotKeyInputSignal;
	import kabam.rotmg.messaging.impl.GameServerConnection;
	import kabam.rotmg.minimap.control.MiniMapZoomSignal;
	import kabam.rotmg.ui.UIUtils;
	import kabam.rotmg.ui.model.HUDModel;
	import kabam.rotmg.ui.model.TabStripModel;
	import kabam.rotmg.ui.signals.ToggleRealmQuestsDisplaySignal;

	import net.hires.debug.Stats;

	import org.swiftsuspenders.Injector;

	import zfn.xinput.ControllerEvent;
	import zfn.xinput.ControllerHandler;

	public class MapUserInput
	{

		private static var stats_:Stats = new Stats();
		private static const MOUSE_DOWN_WAIT_PERIOD:uint = 175;
		private static var arrowWarning_:Boolean = false;

		public var autofire_:Boolean = false;
		public var mouseDown_:Boolean = false;
		public var gs_:GameSprite;
		private var moveLeft_:Boolean = false;
		private var moveRight_:Boolean = false;
		private var moveUp_:Boolean = false;
		private var moveDown_:Boolean = false;
		private var rotateLeft_:Boolean = false;
		private var rotateRight_:Boolean = false;
		private var currentString:String = "";
		private var specialKeyDown_:Boolean = false;
		private var enablePlayerInput_:Boolean = true;
		private var giftStatusUpdateSignal:GiftStatusUpdateSignal;
		private var addTextLine:AddTextLineSignal;
		private var setTextBoxVisibility:SetTextBoxVisibilitySignal;
		private var statsTabHotKeyInputSignal:StatsTabHotKeyInputSignal;
		private var toggleRealmQuestsDisplaySignal:ToggleRealmQuestsDisplaySignal;
		private var miniMapZoom:MiniMapZoomSignal;
		public var useBuyPotionSignal:UseBuyPotionSignal;
		private var potionInventoryModel:PotionInventoryModel;
		private var openDialogSignal:OpenDialogSignal;
		private var closeDialogSignal:CloseDialogsSignal;
		private var closePopupByClassSignal:ClosePopupByClassSignal;
		private var tabStripModel:TabStripModel;
		private var layers:Layers;
		private var exitGame:ExitGameSignal;
		private var areFKeysAvailable:Boolean;
		private var isFriendsListOpen:Boolean;

		private var ch_:ControllerHandler;
		private var rightStickVec:Vector3D;
		private var rightStickAngle:Number = 0;
		public var held:Boolean = false;
		public var heldX:int = 0;
		public var heldY:int = 0;
		public var heldAngle:Number = 0;
		public var pcmc:ParseChatMessageSignal;
		public var hudModel:HUDModel;

		public function MapUserInput(_arg_1:GameSprite)
		{
			this.gs_ = _arg_1;
			this.gs_.addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
			this.gs_.addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
			var _local_2:Injector = StaticInjectorContext.getInjector();
			this.giftStatusUpdateSignal = _local_2.getInstance(GiftStatusUpdateSignal);
			this.addTextLine = _local_2.getInstance(AddTextLineSignal);
			this.setTextBoxVisibility = _local_2.getInstance(SetTextBoxVisibilitySignal);
			this.miniMapZoom = _local_2.getInstance(MiniMapZoomSignal);
			this.useBuyPotionSignal = _local_2.getInstance(UseBuyPotionSignal);
			this.potionInventoryModel = _local_2.getInstance(PotionInventoryModel);
			this.tabStripModel = _local_2.getInstance(TabStripModel);
			this.layers = _local_2.getInstance(Layers);
			this.statsTabHotKeyInputSignal = _local_2.getInstance(StatsTabHotKeyInputSignal);
			this.toggleRealmQuestsDisplaySignal = _local_2.getInstance(ToggleRealmQuestsDisplaySignal);
			this.exitGame = _local_2.getInstance(ExitGameSignal);
			this.openDialogSignal = _local_2.getInstance(OpenDialogSignal);
			this.closeDialogSignal = _local_2.getInstance(CloseDialogsSignal);
			this.closePopupByClassSignal = _local_2.getInstance(ClosePopupByClassSignal);
			var _local_3:ApplicationSetup = _local_2.getInstance(ApplicationSetup);
			this.areFKeysAvailable = _local_3.areDeveloperHotkeysEnabled();
			this.gs_.map.signalRenderSwitch.add(this.onRenderSwitch);
			this.pcmc = _local_2.getInstance(ParseChatMessageSignal);
			this.hudModel = _local_2.getInstance(HUDModel);
			if (Parameters.data_.allowController)
			{
				setController();
			}
		}

		public static function addIgnore(_arg_1:int):String
		{
			for each (var _local_3:int in Parameters.data_.AAIgnore)
			{
				if (_local_3 == _arg_1)
				{
					return (_arg_1 + " already exists in Ignore list");
				}
			}
			if (_arg_1 in ObjectLibrary.propsLibrary_)
			{
				Parameters.data_.AAIgnore.push(_arg_1);
				var _local_2:ObjectProperties = ObjectLibrary.propsLibrary_[_arg_1];
				_local_2.ignored = true;
				return ("Successfully added " + _arg_1 + " to Ignore list");
			}
			return ("Failed to add " + _arg_1 + " to Ignore list (no known object with this itemType)");
		}

		public static function remIgnore(_arg_1:int):String
		{
			var _local_4:uint = Parameters.data_.AAIgnore.length;
			var _local_3:int;
			while (_local_3 < _local_4)
			{
				if (Parameters.data_.AAIgnore[_local_3] == _arg_1)
				{
					Parameters.data_.AAIgnore.splice(_local_3, 1);
					if (_arg_1 in ObjectLibrary.propsLibrary_)
					{
						var _local_2:ObjectProperties = ObjectLibrary.propsLibrary_[_arg_1];
						_local_2.ignored = false;
					}
					return ("Successfully removed " + _arg_1 + " from Ignore list");
				}
				_local_3++;
			}
			return (_arg_1 + " not found in Ignore list");
		}

		public static function addException(_arg_1:int):String
		{
			for each (var _local_2:int in Parameters.data_.AAException)
			{
				if (_local_2 == _arg_1)
				{
					return (_arg_1 + " already exists in Exception list");
				}
			}
			if (_arg_1 in ObjectLibrary.propsLibrary_)
			{
				Parameters.data_.AAException.push(_arg_1);
				var _local_3:ObjectProperties = ObjectLibrary.propsLibrary_[_arg_1];
				_local_3.excepted = true;
				return ("Successfully added " + _arg_1 + " to Exception list");
			}
			return ("Failed to add " + _arg_1 + " to Exception list (no known object with this itemType)");
		}

		public static function remException(_arg_1:int):String
		{
			var _local_2:uint;
			var _local_3:uint = Parameters.data_.AAException.length;
			_local_2 = 0;
			while (_local_2 < _local_3)
			{
				if (Parameters.data_.AAException[_local_2] == _arg_1)
				{
					Parameters.data_.AAException.splice(_local_2, 1);
					if (_arg_1 in ObjectLibrary.propsLibrary_)
					{
						var _local_4:ObjectProperties = ObjectLibrary.propsLibrary_[_arg_1];
						_local_4.excepted = false;
					}
					return ("Successfully removed " + _arg_1 + " from Exception list");
				}
				_local_2++;
			}
			return (_arg_1 + " not found in Exception list");
		}

		public function setController():void
		{
			if (ControllerHandler.instance)
			{
				ch_ = ControllerHandler.instance;
			}
		}

		public function onRenderSwitch(_arg_1:Boolean):void
		{
			if (_arg_1)
			{
				this.gs_.stage.removeEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
				this.gs_.stage.removeEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
				this.gs_.map.addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
				this.gs_.map.addEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
			} else
			{
				this.gs_.map.removeEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
				this.gs_.map.removeEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
				this.gs_.stage.addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
				this.gs_.stage.addEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
			}
		}

		public function clearInput():void
		{
			this.moveLeft_ = false;
			this.moveRight_ = false;
			this.moveUp_ = false;
			this.moveDown_ = false;
			this.rotateLeft_ = false;
			this.rotateRight_ = false;
			this.mouseDown_ = false;
			this.autofire_ = false;
			if (gs_.map.player_ != null)
			{
				gs_.map.player_.setControllerMovementXY(0, 0);
			}
			this.setPlayerMovement();
		}

		public function setEnablePlayerInput(_arg_1:Boolean):void
		{
			if (this.enablePlayerInput_ != _arg_1)
			{
				this.enablePlayerInput_ = _arg_1;
				this.clearInput();
			}
		}

		private function onAddedToStage(_arg_1:Event):void
		{
			var _local_2:Stage = this.gs_.stage;
			_local_2.addEventListener(Event.ACTIVATE, this.onActivate);
			_local_2.addEventListener(Event.DEACTIVATE, this.onDeactivate);
			_local_2.addEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
			_local_2.addEventListener(KeyboardEvent.KEY_UP, this.onKeyUp);
			_local_2.addEventListener(MouseEvent.MOUSE_WHEEL, this.onMouseWheel);
			if (Parameters.isGpuRender())
			{
				_local_2.addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
				_local_2.addEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
			} else
			{
				this.gs_.map.addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
				this.gs_.map.addEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
				this.gs_.map.addEventListener(MouseEvent.RIGHT_MOUSE_DOWN, this.onRightMouseDown_forWorld);
				this.gs_.map.addEventListener(MouseEvent.RIGHT_MOUSE_UP, this.onRightMouseUp_forWorld);
			}
			_local_2.addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
			_local_2.addEventListener(MouseEvent.RIGHT_MOUSE_DOWN, this.onRightMouseDown);
			_local_2.addEventListener(MouseEvent.RIGHT_MOUSE_UP, this.onRightMouseUp);
			if (Parameters.data_.allowController)
			{
				_local_2.addEventListener(ControllerEvent.BUTTON_DOWN, this.onControllerInput);
			}
		}

		public function onRightMouseDown_forWorld(_arg_1:MouseEvent):void
		{
			if (Parameters.data_.rightClickOption == "Quest")
			{
				Parameters.questFollow = true;
			} else
			{
				if (Parameters.data_.rightClickOption == "Ability")
				{
					this.gs_.map.player_.sbAssist(this.gs_.map.mouseX, this.gs_.map.mouseY);
				} else
				{
					if (Parameters.data_.rightClickOption == "Camera")
					{
						held = true;
						heldX = ROTMG.STAGE.mouseX;
						heldY = ROTMG.STAGE.mouseY;
						heldAngle = Parameters.data_.cameraAngle;
					}
				}
			}
		}

		public function onRightMouseUp_forWorld(_arg_1:MouseEvent):void
		{
			Parameters.questFollow = false;
			held = false;
		}

		public function onRightMouseDown(_arg_1:MouseEvent):void
		{
		}

		public function onRightMouseUp(_arg_1:MouseEvent):void
		{
		}

		private function onRemovedFromStage(_arg_1:Event):void
		{
			var _local_2:Stage = this.gs_.stage;
			_local_2.removeEventListener(Event.ACTIVATE, this.onActivate);
			_local_2.removeEventListener(Event.DEACTIVATE, this.onDeactivate);
			_local_2.removeEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
			_local_2.removeEventListener(KeyboardEvent.KEY_UP, this.onKeyUp);
			_local_2.removeEventListener(MouseEvent.MOUSE_WHEEL, this.onMouseWheel);
			if (Parameters.isGpuRender())
			{
				_local_2.removeEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
				_local_2.removeEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
			} else
			{
				this.gs_.map.removeEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
				this.gs_.map.removeEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
				this.gs_.map.removeEventListener(MouseEvent.RIGHT_MOUSE_DOWN, this.onRightMouseDown_forWorld);
				this.gs_.map.removeEventListener(MouseEvent.RIGHT_MOUSE_UP, this.onRightMouseUp_forWorld);
			}
			_local_2.removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
			_local_2.removeEventListener(MouseEvent.RIGHT_MOUSE_DOWN, this.onRightMouseDown);
			_local_2.removeEventListener(MouseEvent.RIGHT_MOUSE_UP, this.onRightMouseUp);
			if (Parameters.data_.allowController)
			{
				_local_2.removeEventListener(ControllerEvent.BUTTON_DOWN, this.onControllerInput);
			}
		}

		public function onMiddleClick(_arg_1:MouseEvent):void
		{
			var _local_2:Point;
			var _local_5:Number;
			var _local_4:Number;
			var _local_6:GameObject;
			if (this.gs_.map != null)
			{
				_local_2 = this.gs_.map.player_.sToW(this.gs_.map.mouseX, this.gs_.map.mouseY);
				_local_5 = Number.MAX_VALUE;
				for each (var _local_3:GameObject in this.gs_.map.goDict_)
				{
					if (_local_3.props_.isEnemy_)
					{
						_local_4 = PointUtil.distanceSquaredXY(_local_3.x_, _local_3.y_, _local_2.x, _local_2.y);
						if (_local_4 < _local_5)
						{
							_local_5 = _local_4;
							_local_6 = _local_3;
						}
					}
				}
				if (_local_6 != null)
				{
					this.gs_.map.quest_.setObject(_local_6.objectId_);
				}
			}
		}

		private function onActivate(_arg_1:Event):void
		{
		}

		private function onDeactivate(_arg_1:Event):void
		{
			this.clearInput();
		}

		public function onMouseDown(_arg_1:MouseEvent):void
		{
			var _local_3:Number;
			var _local_4:int;
			var _local_5:XML;
			var _local_6:Number;
			var _local_7:Number;
			var _local_2:Player = this.gs_.map.player_;
			this.mouseDown_ = true;
			if (_local_2 == null)
			{
				return;
			}
			if (!this.enablePlayerInput_)
			{
				return;
			}
			if (_arg_1.shiftKey)
			{
				_local_4 = _local_2.equipment_[1];
				if (_local_4 == -1)
				{
					return;
				}
				_local_5 = ObjectLibrary.xmlLibrary_[_local_4];
				if (((_local_5 == null) || (_local_5.hasOwnProperty("EndMpCost"))))
				{
					return;
				}
				if (_local_2.isUnstable)
				{
					_local_6 = ((Math.random() * 600) - this.gs_.map.x);
					_local_7 = ((Math.random() * 600) - this.gs_.map.y);
				} else
				{
					_local_6 = this.gs_.map.mouseX;
					_local_7 = this.gs_.map.mouseY;
				}
				if (Parameters.isGpuRender())
				{
					if ((((_arg_1.currentTarget == _arg_1.target) || (_arg_1.target == this.gs_.map)) || (_arg_1.target == this.gs_.map)))
					{
						_local_2.useAltWeapon(_local_6, _local_7, UseType.START_USE);
					}
				} else
				{
					_local_2.useAltWeapon(_local_6, _local_7, UseType.START_USE);
				}
				return;
			}
			if (Parameters.isGpuRender())
			{
				if (_arg_1.currentTarget == _arg_1.target || _arg_1.target == this.gs_.map || _arg_1.target == this.gs_ || _arg_1.currentTarget == this.gs_.chatBox_.list || _arg_1.currentTarget == this.gs_.map)
				{
					_local_3 = Math.atan2(this.gs_.map.mouseY, this.gs_.map.mouseX);
				} else
				{
					return;
				}
			} else
			{
				_local_3 = Math.atan2(this.gs_.map.mouseY, this.gs_.map.mouseX);
			}
			doneAction(this.gs_, Tutorial.ATTACK_ACTION);
			if (_local_2.isUnstable)
			{
				_local_2.attemptAttackAngle((Math.random() * (Math.PI * 2)));
			} else
			{
				_local_2.attemptAttackAngle(_local_3);
			}
		}

		public function onMouseUp(_arg_1:MouseEvent):void
		{
			this.mouseDown_ = false;
			var _local_2:Player = this.gs_.map.player_;
			if (_local_2 == null)
			{
				return;
			}
			_local_2.isShooting = false;
		}

		private function onMouseWheel(_arg_1:MouseEvent):void
		{
			if (_arg_1.delta > 0)
			{
				this.miniMapZoom.dispatch(MiniMapZoomSignal.IN);
			} else
			{
				this.miniMapZoom.dispatch(MiniMapZoomSignal.OUT);
			}
		}

		private function onEnterFrame(_arg_1:Event):void
		{
			var _local_2:Number;
			var _local_3:Player = this.gs_.map.player_;
			if (_local_3)
			{
				_local_3.mousePos_.x = this.gs_.map.mouseX;
				_local_3.mousePos_.y = this.gs_.map.mouseY;
				if (this.enablePlayerInput_)
				{
					if (this.mouseDown_)
					{
						if (!_local_3.isUnstable)
						{
							_local_2 = Math.atan2(this.gs_.map.mouseY, this.gs_.map.mouseX);
							_local_3.attemptAttackAngle(_local_2);
							_local_3.attemptAutoAbility(_local_2);
						} else
						{
							_local_2 = (Math.random() * (Math.PI * 2));
							_local_3.attemptAttackAngle(_local_2);
							_local_3.attemptAutoAbility(_local_2);
						}
					} else
					{
						if (Parameters.data_.AAOn || this.autofire_ || Parameters.data_.AutoAbilityOn)
						{
							if (!_local_3.isUnstable)
							{
								_local_2 = Math.atan2(this.gs_.map.mouseY, this.gs_.map.mouseX);
								_local_3.attemptAutoAim(_local_2);
							} else
							{
								_local_3.attemptAutoAim((Math.random() * (Math.PI * 2)));
							}
						}
					}
				}
				if (ROTMG.focus && _local_3.conMoveVec)
				{
					controller(_local_3);
				}
			}
		}

		private function fixJoystick(_arg_1:Vector3D):Vector3D
		{
			var _local_2:Number = _arg_1.length;
			if (_local_2 < 0.2)
			{
				_arg_1.x = 0;
				_arg_1.y = 0;
			} else
			{
				_arg_1.normalize();
				_arg_1.scaleBy(((_local_2 - 0.2) / (1 - 0.2)));
			}
			return (_arg_1);
		}

		private function controller(_arg_1:Player):void
		{
			var _local_6:GameInputDevice;
			var _local_2:int;
			var _local_5:Vector.<Number>;
			var _local_7:Number;
			var _local_4:Number;
			if (_arg_1 && _arg_1.relMoveVec_ && ch_ && ch_.controller)
			{
				_local_6 = ch_.controller;
				_local_2 = _local_6.numControls;
				_local_5 = new Vector.<Number>(_local_2, true);
				_local_2--;
				while (_local_2 <= 4)
				{
					_local_7 = _local_6.getControlAt(_local_2).value;
					_local_5[_local_2] = _local_7;
					if (_local_7 != ch_.controls[_local_2])
					{
						ch_.inputEvent(_local_2, _local_7);
					}
					_local_5.push(_local_7);
					_local_2++;
				}
				var _local_3:Vector3D = fixJoystick(new Vector3D(_local_5[0], _local_5[1]));
				_arg_1.setControllerMovementV3D(_local_3);
				_local_3 = fixJoystick(new Vector3D(_local_5[2], _local_5[3]));
				if (_local_3.x != 0 && _local_3.y != 0)
				{
					_local_4 = Math.atan2(-(_local_3.y), _local_3.x);
					_arg_1.attemptAttackAngle(_local_4);
					rightStickAngle = _local_4;
				}
				rightStickVec = _local_3;
				ch_.controls = _local_5;
			}
		}

		private function onControllerInput(_arg_1:ControllerEvent):void
		{
			var _local_2:int;
			if (_arg_1.inputValue == 1)
			{
				_local_2 = _arg_1.inputCode;
				var player:Player = this.gs_.map.player_;
				if (_local_2 == Parameters.data_.ctrlEnterPortal)
				{
					_local_2 = this.gs_.mapModel.currentInteractiveTargetObjectId;
					if (_local_2 != -1)
					{
						var _local_3:GameObject = this.gs_.map.goDict_[_local_2];
						if (_local_3 != null)
						{
							if (_local_3 is Portal)
							{
								this.gs_.gsc_.usePortal(_local_2);
							}
						}
					}
				} else
				{
					if (_local_2 == Parameters.data_.ctrlTeleQuest)
					{
						if (player)
						{
							teleQuest(player);
						}
					} else
					{
						if (_local_2 == Parameters.data_.ctrlNexus)
						{
							if (player != null)
							{
								this.gs_.gsc_.escape();
								this.gs_.dispatchEvent(Parameters.reconNexus);
							}
							Parameters.data_.needsRandomRealm = false;
							Parameters.save();
						} else
						{
							if (_local_2 == Parameters.data_.ctrlAbility)
							{
								if (player != null)
								{
									rightStickVec.scaleBy(7.5);
									player.useAltWeapon((player.x_ + (Math.cos(rightStickAngle) * Number.abs(rightStickVec.x))), (player.y_ + (Math.sin(rightStickAngle) * Number.abs(rightStickVec.y))), 1, -1, true);
								}
							} else
							{
								if (_local_2 == Parameters.data_.ctrlHpPot)
								{
									useHPPot(player);
								} else
								{
									if (_local_2 == Parameters.data_.ctrlMpPot)
									{
										useMPPot(player);
									}
								}
							}
						}
					}
				}
			}
		}

		private function onKeyDown(_arg_1:KeyboardEvent):void
		{
			var _local_4:CloseAllPopupsSignal;
			var _local_5:AddTextLineSignal;
			var _local_6:ChatMessage;
			var _local_7:GameObject;
			var _local_8:Number;
			var _local_9:Number;
			var _local_10:Boolean;
			var _local_11:ShowPopupSignal;
			var _local_12:OpenDialogSignal;
			var _local_13:Square;
			var _local_14:int;
			var _local_2:Stage = this.gs_.stage;
			var player:Player = this.gs_.map.player_;
			var object:GameObject;
			var object2:GameObject;
			var counter:int;
			this.currentString = (this.currentString + String.fromCharCode(_arg_1.keyCode).toLowerCase());
			if (this.currentString == UIUtils.EXPERIMENTAL_MENU_PASSWORD.slice(0, this.currentString.length))
			{
				if (this.currentString.length == UIUtils.EXPERIMENTAL_MENU_PASSWORD.length)
				{
					_local_5 = StaticInjectorContext.getInjector().getInstance(AddTextLineSignal);
					_local_6 = new ChatMessage();
					_local_6.name = Parameters.SERVER_CHAT_NAME;
					this.currentString = "";
					UIUtils.SHOW_EXPERIMENTAL_MENU = (!(UIUtils.SHOW_EXPERIMENTAL_MENU));
					_local_6.text = ((UIUtils.SHOW_EXPERIMENTAL_MENU) ? "Experimental menu activated" : "Experimental menu deactivated");
					_local_5.dispatch(_local_6);
				}
			} else
			{
				this.currentString = "";
			}
			switch (_arg_1.keyCode)
			{
				case KeyCodes.F1:
				case KeyCodes.F2:
				case KeyCodes.F3:
				case KeyCodes.F4:
				case KeyCodes.F5:
				case KeyCodes.F6:
				case KeyCodes.F7:
				case KeyCodes.F8:
				case KeyCodes.F9:
				case KeyCodes.F10:
				case KeyCodes.F11:
				case KeyCodes.F12:
				case KeyCodes.INSERT:
				case KeyCodes.ALTERNATE:
					break;
				default:
					if (_local_2.focus != null)
					{
						return;
					}
			}
			var _local_3:Player = this.gs_.map.player_;
			switch (_arg_1.keyCode)
			{
				case Parameters.data_.moveUp:
					doneAction(this.gs_, Tutorial.MOVE_FORWARD_ACTION);
					this.moveUp_ = true;
					break;
				case Parameters.data_.moveDown:
					doneAction(this.gs_, Tutorial.MOVE_BACKWARD_ACTION);
					this.moveDown_ = true;
					break;
				case Parameters.data_.moveLeft:
					doneAction(this.gs_, Tutorial.MOVE_LEFT_ACTION);
					this.moveLeft_ = true;
					break;
				case Parameters.data_.moveRight:
					doneAction(this.gs_, Tutorial.MOVE_RIGHT_ACTION);
					this.moveRight_ = true;
					break;
				case Parameters.data_.rotateLeft:
					if (!Parameters.data_.allowRotation)
					{
						break;
					}
					doneAction(this.gs_, Tutorial.ROTATE_LEFT_ACTION);
					this.rotateLeft_ = true;
					break;
				case Parameters.data_.rotateRight:
					if (!Parameters.data_.allowRotation)
					{
						break;
					}
					doneAction(this.gs_, Tutorial.ROTATE_RIGHT_ACTION);
					this.rotateRight_ = true;
					break;
				case Parameters.data_.resetToDefaultCameraAngle:
					Parameters.data_.cameraAngle = Parameters.data_.defaultCameraAngle;
					Parameters.save();
					this.gs_.camera_.nonPPMatrix_ = new Matrix3D();
					this.gs_.camera_.nonPPMatrix_.appendScale(50, 50, 50);
					break;
				case Parameters.data_.useSpecial:
					_local_7 = this.gs_.map.player_;
					if (_local_7 == null)
					{
						break;
					}
					if (!this.specialKeyDown_)
					{
						if (_local_3.isUnstable)
						{
							_local_8 = ((Math.random() * 600) - 300);
							_local_9 = ((Math.random() * 600) - 325);
						} else
						{
							_local_8 = this.gs_.map.mouseX;
							_local_9 = this.gs_.map.mouseY;
						}
						_local_10 = _local_3.useAltWeapon(_local_8, _local_9, UseType.START_USE);
						if (_local_10)
						{
							this.specialKeyDown_ = true;
						}
					}
					break;
				case Parameters.data_.autofireToggle:
					this.gs_.map.player_.isShooting = (this.autofire_ = !this.autofire_);
					break;
				case Parameters.data_.toggleHPBar:
					Parameters.data_.HPBar = ((Parameters.data_.HPBar != 0) ? 0 : 1);
					break;
				case Parameters.data_.toggleProjectiles:
					Parameters.data_.disableAllyShoot = ((Parameters.data_.disableAllyShoot != 0) ? 0 : 1);
					break;
				case Parameters.data_.toggleMasterParticles:
					Parameters.data_.noParticlesMaster = (!(Parameters.data_.noParticlesMaster));
					break;
				case Parameters.data_.useInvSlot1:
					this.useItem(4);
					break;
				case Parameters.data_.useInvSlot2:
					this.useItem(5);
					break;
				case Parameters.data_.useInvSlot3:
					this.useItem(6);
					break;
				case Parameters.data_.useInvSlot4:
					this.useItem(7);
					break;
				case Parameters.data_.useInvSlot5:
					this.useItem(8);
					break;
				case Parameters.data_.useInvSlot6:
					this.useItem(9);
					break;
				case Parameters.data_.useInvSlot7:
					this.useItem(10);
					break;
				case Parameters.data_.useInvSlot8:
					this.useItem(11);
					break;
				case Parameters.data_.useHealthPotion:
					if (this.potionInventoryModel.getPotionModel(PotionInventoryModel.HEALTH_POTION_ID).available)
					{
						this.useBuyPotionSignal.dispatch(new UseBuyPotionVO(PotionInventoryModel.HEALTH_POTION_ID, UseBuyPotionVO.CONTEXTBUY));
					}
					break;
				case Parameters.data_.GPURenderToggle:
					Parameters.data_.GPURender = (!(Parameters.data_.GPURender));
					break;
				case Parameters.data_.useMagicPotion:
					if (this.potionInventoryModel.getPotionModel(PotionInventoryModel.MAGIC_POTION_ID).available)
					{
						this.useBuyPotionSignal.dispatch(new UseBuyPotionVO(PotionInventoryModel.MAGIC_POTION_ID, UseBuyPotionVO.CONTEXTBUY));
					}
					break;
				case Parameters.data_.miniMapZoomOut:
					this.miniMapZoom.dispatch(MiniMapZoomSignal.OUT);
					break;
				case Parameters.data_.miniMapZoomIn:
					this.miniMapZoom.dispatch(MiniMapZoomSignal.IN);
					break;
				case Parameters.data_.togglePerformanceStats:
					this.togglePerformanceStats();
					break;
				case Parameters.data_.escapeToNexus:
				case Parameters.data_.escapeToNexus2:
					_local_4 = StaticInjectorContext.getInjector().getInstance(CloseAllPopupsSignal);
					_local_4.dispatch();
					this.gs_.dispatchEvent(Parameters.reconNexus);
					this.exitGame.dispatch();
					Parameters.data_.needsRandomRealm = false;
					Parameters.save();
					break;
				case Parameters.data_.friendList:
					this.isFriendsListOpen = !this.isFriendsListOpen;
					if (this.isFriendsListOpen)
					{
						_local_11 = StaticInjectorContext.getInjector().getInstance(ShowPopupSignal);
						_local_11.dispatch(new SocialPopupView());
					} else
					{
						this.closeDialogSignal.dispatch();
						this.closePopupByClassSignal.dispatch(SocialPopupView);
					}
					break;
				case KeyCodes.O:
				case Parameters.data_.options:
					_local_4 = StaticInjectorContext.getInjector().getInstance(CloseAllPopupsSignal);
					_local_4.dispatch();
					this.clearInput();
					this.layers.overlay.addChild(new Options(this.gs_));
					break;
				case Parameters.data_.toggleCentering:
					Parameters.data_.centerOnPlayer = (!(Parameters.data_.centerOnPlayer));
					Parameters.save();
					break;
				case Parameters.data_.toggleFullscreen:
					if (Capabilities.playerType == "Desktop")
					{
						Parameters.data_.fullscreenMode = (!(Parameters.data_.fullscreenMode));
						Parameters.save();
						_local_2.displayState = ((Parameters.data_.fullscreenMode) ? "fullScreenInteractive" : StageDisplayState.NORMAL);
					}
					break;
				case Parameters.data_.switchTabs:
					_local_4 = StaticInjectorContext.getInjector().getInstance(CloseAllPopupsSignal);
					_local_4.dispatch();
					this.statsTabHotKeyInputSignal.dispatch();
					this.gs_.hudView.mainView = !this.gs_.hudView.mainView;
					this.gs_.hudView.toggleUI();
					break;
				case Parameters.data_.interact:
					_local_4 = StaticInjectorContext.getInjector().getInstance(CloseAllPopupsSignal);
					_local_4.dispatch();
					break;
				case Parameters.data_.testOne:
					break;
				case Parameters.data_.toggleRealmQuestDisplay:
					this.toggleRealmQuestsDisplaySignal.dispatch();
					break;
				case Parameters.data_.TombCycleKey: // TODO unused
					switch (Parameters.data_.TombCycleBoss)
					{
						case 3368:
						default:
							addIgnore(3366);
							addIgnore(3367);
							remIgnore(3368);
							player.textNotification("Bes", 16771743, 1500, true);
							Parameters.data_.TombCycleBoss = 3366;
							break;
						case 3366:
							addIgnore(3367);
							addIgnore(3368);
							remIgnore(3366);
							player.textNotification("Nut", 10481407, 1500, true);
							Parameters.data_.TombCycleBoss = 3367;
							break;
						case 3367:
							addIgnore(3368);
							addIgnore(3366);
							remIgnore(3367);
							player.textNotification("Geb", 11665311, 1500, true);
							Parameters.data_.TombCycleBoss = 3368;
					}
					Parameters.save();
					break;
				case Parameters.data_.anchorTeleport:
					if (Parameters.data_.anchorName != "")
					{
						this.gs_.gsc_.playerText("/teleport " + Parameters.data_.anchorName);
					} else
					{
						player.textNotification("Anchored player not found.", 0xFFFFFF, 2000, false);
					}
					break;
				case Parameters.data_.AutoAbilityHotkey:
					Parameters.data_.AutoAbilityOn = !Parameters.data_.AutoAbilityOn;
					player.textNotification(((Parameters.data_.AutoAbilityOn) ? "AutoAbility enabled" : "AutoAbility disabled"), 0xFFFFFF, 2000, false);
					break;
				case Parameters.data_.AAHotkey:
					Parameters.data_.AAOn = !Parameters.data_.AAOn;
					player.textNotification(((Parameters.data_.AAOn) ? "AutoAim enabled" : "AutoAim disabled"), 0xFFFFFF, 2000, false);
					break;
				case Parameters.data_.AAModeHotkey:
					this.selectAimMode();
					break;
				case Parameters.data_.AutoLootHotkey:
					Parameters.data_.AutoLootOn = !Parameters.data_.AutoLootOn;
					player.textNotification(((Parameters.data_.AutoLootOn) ? "AutoLoot enabled" : "AutoLoot disabled"), 0xFFFFFF, 2000, false);
					break;
				case Parameters.data_.Cam45DegInc:
					Parameters.data_.cameraAngle -= (Math.PI / 4);
					Parameters.save();
					break;
				case Parameters.data_.Cam45DegDec:
					Parameters.data_.cameraAngle += (Math.PI / 4);
					Parameters.save();
					break;
				case Parameters.data_.resetClientHP:
					player.clientHp = player.hp_;
					break;
				case Parameters.data_.QuestTeleport:
					if (player != null)
					{
						teleQuest(player);
					}
					break;
				case Parameters.data_.addMoveRecPoint:
					Parameters.VHSRecord.push(new Point(player.x_, player.y_));
					Parameters.VHSRecordLength = Parameters.VHSRecord.length;
					player.textNotification(((("Saved " + player.x_) + ",") + player.y_), 0xB00000, 800);
					break;
				case Parameters.data_.SelfTPHotkey:
					this.gs_.gsc_.teleport(player.objectId_);
					break;
				case Parameters.data_.TogglePlayerFollow:
					Parameters.followingName = !Parameters.followingName;
					player.textNotification(((Parameters.followingName) ? "Following: on" : "Following: off"), 0xFFFF00);
					break;
				case Parameters.data_.PassesCoverHotkey:
					Parameters.data_.PassesCover = !Parameters.data_.PassesCover;
					player.textNotification(((Parameters.data_.PassesCover) ? "Projectile Noclip on" : "Projectile Noclip off"));
					break;
				case Parameters.data_.LowCPUModeHotKey:
					Parameters.lowCPUMode = !Parameters.lowCPUMode;
					player.textNotification(((Parameters.lowCPUMode) ? "Low CPU on" : "Low CPU off"));
					break;
				case Parameters.data_.ReconRealm:
					if (Parameters.reconRealm != null)
					{
						Parameters.reconRealm.charId_ = this.gs_.gsc_.charId_;
					} else
					{
						Parameters.reconRealm = new ReconnectEvent(this.gs_.gsc_.server_, Parameters.RANDOM_REALM_GAMEID, false, this.gs_.gsc_.charId_, 0, null, false);
					}
					this.gs_.dispatchEvent(Parameters.reconRealm);
					break;
				case Parameters.data_.ReconVault:
					if (Parameters.reconVault != null)
					{
						Parameters.reconVault.charId_ = this.gs_.gsc_.charId_;
					} else
					{
						Parameters.reconVault = new ReconnectEvent(this.gs_.gsc_.server_, Parameters.VAULT_GAMEID, false, this.gs_.gsc_.charId_, 0, null, false);
					}
					this.gs_.dispatchEvent(Parameters.reconVault);
					break;
				case Parameters.data_.ReconDaily:
					if (Parameters.reconDaily != null)
					{
						Parameters.reconDaily.charId_ = this.gs_.gsc_.charId_;
					} else
					{
						Parameters.reconDaily = new ReconnectEvent(this.gs_.gsc_.server_, Parameters.DAILYQUESTROOM_GAMEID, false, this.gs_.gsc_.charId_, 0, null, false);
					}
					this.gs_.dispatchEvent(Parameters.reconVault);
					break;
				case Parameters.data_.RandomRealm:
					this.gs_.dispatchEvent(new ReconnectEvent(Parameters.reconNexus.server_, Parameters.RANDOM_REALM_GAMEID, false, this.gs_.gsc_.charId_, 0, null, false));
					break;
				case Parameters.data_.DrinkAllHotkey: // TODO unused
					object = player.getClosestBag(true);
					if (object != null)
					{
						counter = 0;
						while (counter < 8)
						{
							if (object.equipment_[counter] != -1)
							{
								gs_.gsc_.useItem(getTimer(), object.objectId_, counter, object.equipment_[_local_4], player.x_, player.y_, 1);
							}
							counter++;
						}
					}
					break;
				case Parameters.data_.tradeNearestPlayerKey: // TODO unused
					_local_14 = Number.MAX_VALUE;
					for each (object in this.gs_.map.goDict_)
					{
						if (object is Player && (object as Player).nameChosen_ && player != object)
						{
							_local_8 = PointUtil.distanceSquaredXY(player.x_, player.y_, object.x_, object.y_);
							if (_local_8 < _local_14)
							{
								object2 = object;
								_local_14 = _local_8;
							}
						}
					}
					if (object2 != null)
					{
						this.gs_.gsc_.requestTrade(object2.name_);
					}
					break;
				case Parameters.data_.famebotToggleHotkey:
					Parameters.fameBotWatchingPortal = false;
					Parameters.fameBot = !Parameters.fameBot;
					if (Parameters.fameBot)
					{
						if (Parameters.fpmStart == -1)
						{
							Parameters.fpmStart = getTimer();
							Parameters.fpmGain = 0;
						}
						player.textNotification("Famebot On", 0xFFB000);
					} else
					{
						player.textNotification("Famebot Off", 0xFFB000);
					}
					break;
				case Parameters.data_.sskey:
					Parameters.ssmode = !Parameters.ssmode;
					this.hudModel.gameSprite.map.player_.clearTextureCache();
					if (Parameters.ssmode)
					{
						if (Parameters.PlayerTex1 != -1)
						{
							player.setTex1(Parameters.PlayerTex1);
						}
						if (Parameters.PlayerTex2 != -1)
						{
							player.setTex2(Parameters.PlayerTex2);
						}
						if (Parameters.playerSkin != -1)
						{
							this.gs_.gsc_.setPlayerSkinTemplate(player, Parameters.playerSkin);
						}
						if (this.gs_.map.mapOverlay_)
						{
							this.gs_.map.mapOverlay_.removeChildren(0);
						}
						Parameters.oldFSmode = Parameters.root.stage.scaleMode;
						Parameters.root.stage.scaleMode = StageScaleMode.EXACT_FIT;
						Parameters.data_.stageScale = StageScaleMode.EXACT_FIT;
						this.gs_.realmQuestsDisplay.y = 10;
					} else
					{
						if (Parameters.data_.setTex1 != -1)
						{
							player.setTex1(Parameters.data_.setTex1);
						}
						if (Parameters.data_.setTex2 != -1)
						{
							player.setTex2(Parameters.data_.setTex2);
						}
						if (Parameters.data_.nsetSkin[1] != -1)
						{
							this.gs_.gsc_.setPlayerSkinTemplate(player, Parameters.data_.nsetSkin[1]);
						}
						Parameters.root.stage.scaleMode = Parameters.oldFSmode;
						Parameters.data_.stageScale = Parameters.oldFSmode;
						this.gs_.realmQuestsDisplay.y = 40;
					}
					this.gs_.hudView.toggleUI();
					this.gs_.hudView.characterDetails.setName(player.name_);
					this.gs_.chatBox_.list.setVisibleItemCount();
					this.gs_.chatBox_.list.removeOldestExcessVisible();
					this.gs_.chatBox_.model.setVisibleItemCount();
					this.gs_.chatBox_.list.removeBadMessages();
					if (this.gs_.map.partyOverlay_ != null)
					{
						this.gs_.map.partyOverlay_.draw(this.gs_.camera_, getTimer());
						if (this.gs_.map.partyOverlay_.questArrow_ != null)
						{
							this.gs_.map.partyOverlay_.draw(this.gs_.camera_, getTimer());
						}
					}
					this.gs_.hudView.statMeters.dispose();
					this.gs_.hudView.statMeters.init();
					this.gs_.camera_.nonPPMatrix_ = new Matrix3D();
					this.gs_.camera_.nonPPMatrix_.appendScale(50, 50, 50);
					TextureRedrawer.clearCache2();
					GlowRedrawer.clearCache();
					Parameters.root.stage.dispatchEvent(new Event(Event.RESIZE));
					Parameters.save();
					break;
				case Parameters.data_.aimAtQuest:
					if (this.gs_.map.quest_.objectId_ >= 0)
					{
						object2 = this.gs_.map.goDict_[this.gs_.map.quest_.objectId_];
						Parameters.data_.cameraAngle = (Math.atan2((player.y_ - object2.y_), (player.x_ - object2.x_)) - (Math.PI / 2));
						Parameters.save();
					}
					break;
			}
			for (counter = 1; counter <= 9; counter++)
			{
				var key:String = "msg" + (counter).toString() + "key";
				if (_arg_1.keyCode == Parameters.data_[key])
				{
					key = "msg" + (counter).toString();
					if (Parameters.data_[key] != null)
					{
						this.pcmc.dispatch(Parameters.data_[key]);
					}
					break;
				}
			}
			if (Parameters.ALLOW_SCREENSHOT_MODE)
			{
				switch (_arg_1.keyCode)
				{
					case KeyCodes.F2:
						this.toggleScreenShotMode();
						break;
					case KeyCodes.F3:
						Parameters.screenShotSlimMode_ = (!(Parameters.screenShotSlimMode_));
						break;
					case KeyCodes.F4:
						this.gs_.map.mapOverlay_.visible = (!(this.gs_.map.mapOverlay_.visible));
						this.gs_.map.partyOverlay_.visible = (!(this.gs_.map.partyOverlay_.visible));
						break;
				}
			}
			if (this.areFKeysAvailable)
			{
				switch (_arg_1.keyCode)
				{
					case KeyCodes.F6:
						TextureRedrawer.clearCache();
						Parameters.projColorType_ = ((Parameters.projColorType_ + 1) % 7);
						this.addTextLine.dispatch(ChatMessage.make(Parameters.ERROR_CHAT_NAME, ("Projectile Color Type: " + Parameters.projColorType_)));
						break;
					case KeyCodes.F7:
						for each (_local_13 in this.gs_.map.squares_)
						{
							if (_local_13 != null)
							{
								_local_13.faces_.length = 0;
							}
						}
						Parameters.blendType_ = ((Parameters.blendType_ + 1) % 2);
						this.addTextLine.dispatch(ChatMessage.make(Parameters.CLIENT_CHAT_NAME, ("Blend type: " + Parameters.blendType_)));
						break;
					case KeyCodes.F8:
						Parameters.data_.surveyDate = 0;
						Parameters.data_.needsSurvey = true;
						Parameters.data_.playTimeLeftTillSurvey = 5;
						Parameters.data_.surveyGroup = "testing";
						break;
					case KeyCodes.F9:
						Parameters.drawProj_ = (!(Parameters.drawProj_));
						break;
				}
			}
			this.setPlayerMovement();
		}

		public function useHPPot(_arg_1:Player):void
		{
			var _local_2:int;
			if (_arg_1.hp_ != _arg_1.maxHP_)
			{
				if (_arg_1.healthPotionCount_ == 0 && !Parameters.data_.fameBlockThirsty)
				{
					_local_2 = _arg_1.findItems(_arg_1.equipment_, Parameters.hpPotions, 4);
					if (_local_2 != -1)
					{
						this.gs_.gsc_.useItem(getTimer(), _arg_1.objectId_, _local_2, _arg_1.equipment_[_local_2], _arg_1.x_, _arg_1.y_, 1);
					}
				} else
				{
					this.useBuyPotionSignal.dispatch(new UseBuyPotionVO(2594, UseBuyPotionVO.CONTEXTBUY));
				}
			}
		}

		public function useMPPot(_arg_1:Player):void
		{
			var _local_2:int;
			if (_arg_1.mp_ != _arg_1.maxMP_)
			{
				if (_arg_1.magicPotionCount_ == 0 && !Parameters.data_.fameBlockThirsty)
				{
					_local_2 = _arg_1.findItems(_arg_1.equipment_, Parameters.mpPotions, 4);
					if (_local_2 != -1)
					{
						this.gs_.gsc_.useItem(getTimer(), _arg_1.objectId_, _local_2, _arg_1.equipment_[_local_2], _arg_1.x_, _arg_1.y_, 1);
					}
				} else
				{
					this.useBuyPotionSignal.dispatch(new UseBuyPotionVO(2595, UseBuyPotionVO.CONTEXTBUY));
				}
			}
		}

		public function teleQuest(_arg_1:Player):void
		{
			var _local_6:Number;
			var _local_3:int;
			var _local_7:Number;
			var _local_2:int = gs_.map.quest_.objectId_;
			if (_local_2 > 0)
			{
				var _local_4:GameObject = gs_.map.quest_.getObject();
				if (_local_4 != null)
				{
					_local_6 = Number.MAX_VALUE;
					_local_3 = -1;
					for each (var _local_5:GameObject in this.gs_.map.goDict_)
					{
						if (_local_5 is Player && !_local_5.isInvisible && !_local_5.isPaused)
						{
							_local_7 = (((_local_5.x_ - _local_4.x_) * (_local_5.x_ - _local_4.x_)) + ((_local_5.y_ - _local_4.y_) * (_local_5.y_ - _local_4.y_)));
							if (_local_7 < _local_6)
							{
								_local_6 = _local_7;
								_local_3 = _local_5.objectId_;
							}
						}
					}
					if (_local_3 == _arg_1.objectId_)
					{
						_arg_1.textNotification("You are closest!", 0xFFFFFF, 1500, false);
					} else
					{
						this.gs_.gsc_.teleport(_local_3);
						_arg_1.textNotification(("Teleporting to " + this.gs_.map.goDict_[_local_3].name_), 0xFFFFFF, 1500, false);
					}
				}
			} else
			{
				_arg_1.textNotification("You have no quest!", 0xFFFFFF, 1500, false);
			}
		}

		public function selectAimMode():void
		{
			var _local_2:String = "";
			var _local_1:int = ((Parameters.data_.aimMode + 1) % 4);
			switch (_local_1)
			{
				case 0:
					_local_2 = "AimMode: Mouse";
					break;
				case 1:
					_local_2 = "AimMode: Health";
					break;
				case 2:
					_local_2 = "AimMode: Closest";
					break;
				case 3:
					_local_2 = "AimMode: Random";
					break;
			}
			if (this.gs_ != null && this.gs_.map != null && this.gs_.map.player_ != null)
			{
				this.gs_.map.player_.textNotification(_local_2, 0xFFFFFF, 2000, false);
			}
			Parameters.data_.aimMode = _local_1;
		}

		private function onKeyUp(_arg_1:KeyboardEvent):void
		{
			var _local_2:Number;
			var _local_3:Number;
			switch (_arg_1.keyCode)
			{
				case Parameters.data_.moveUp:
					this.moveUp_ = false;
					break;
				case Parameters.data_.moveDown:
					this.moveDown_ = false;
					break;
				case Parameters.data_.moveLeft:
					this.moveLeft_ = false;
					break;
				case Parameters.data_.moveRight:
					this.moveRight_ = false;
					break;
				case Parameters.data_.rotateLeft:
					this.rotateLeft_ = false;
					break;
				case Parameters.data_.rotateRight:
					this.rotateRight_ = false;
					break;
				case Parameters.data_.useSpecial:
					if (this.specialKeyDown_)
					{
						this.specialKeyDown_ = false;
						if (this.gs_.map.player_.isUnstable)
						{
							_local_2 = ((Math.random() * 600) - 300);
							_local_3 = ((Math.random() * 600) - 325);
						} else
						{
							_local_2 = this.gs_.map.mouseX;
							_local_3 = this.gs_.map.mouseY;
						}
						this.gs_.map.player_.useAltWeapon(this.gs_.map.mouseX, this.gs_.map.mouseY, UseType.END_USE);
					}
					break;
			}
			this.setPlayerMovement();
		}

		private function setPlayerMovement():void
		{
			var _local_1:Player = this.gs_.map.player_;
			if (_local_1 != null)
			{
				if (this.enablePlayerInput_)
				{
					_local_1.setRelativeMovement((((this.rotateRight_) ? 1 : 0) - ((this.rotateLeft_) ? 1 : 0)), (((this.moveRight_) ? 1 : 0) - ((this.moveLeft_) ? 1 : 0)), (((this.moveDown_) ? 1 : 0) - ((this.moveUp_) ? 1 : 0)));
				} else
				{
					_local_1.setRelativeMovement(0, 0, 0);
				}
			}
		}

		private function useItem(_arg_1:int):void
		{
			if (this.tabStripModel.currentSelection == TabStripModel.BACKPACK || this.gs_.hudView.backpackSelected)
			{
				_arg_1 = (_arg_1 + GeneralConstants.NUM_INVENTORY_SLOTS);
			}
			GameServerConnection.instance.useItem_new(this.gs_.map.player_, _arg_1);
		}

		private function togglePerformanceStats():void
		{
			if (!Parameters.ssmode && Parameters.data_.liteMonitor)
			{
				if (this.gs_.stats)
				{
					this.gs_.stats.visible = false;
					this.gs_.stats = null;
				} else
				{
					this.gs_.addStats();
					this.gs_.statsStart = getTimer();
				}
			} else
			{
				if (this.gs_.contains(stats_))
				{
					this.gs_.removeChild(stats_);
					this.gs_.removeChild(this.gs_.gsc_.jitterWatcher_);
					this.gs_.gsc_.disableJitterWatcher();
				} else
				{
					this.gs_.addChild(stats_);
					this.gs_.gsc_.enableJitterWatcher();
					this.gs_.gsc_.jitterWatcher_.y = stats_.height;
					this.gs_.addChild(this.gs_.gsc_.jitterWatcher_);
				}
			}
		}

		private function toggleScreenShotMode():void
		{
			Parameters.screenShotMode_ = !Parameters.screenShotMode_;
			if (Parameters.screenShotMode_)
			{
				this.gs_.hudView.visible = false;
				this.setTextBoxVisibility.dispatch(false);
			} else
			{
				this.gs_.hudView.visible = true;
				this.setTextBoxVisibility.dispatch(true);
			}
		}

	}
}//package com.company.assembleegameclient.game

