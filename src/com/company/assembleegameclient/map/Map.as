﻿//com.company.assembleegameclient.map.Map

package com.company.assembleegameclient.map
{
	import com.adobe.images.PNGEncoder;
	import com.company.assembleegameclient.background.Background;
	import com.company.assembleegameclient.game.AGameSprite;
	import com.company.assembleegameclient.map.mapoverlay.MapOverlay;
	import com.company.assembleegameclient.map.partyoverlay.PartyOverlay;
	import com.company.assembleegameclient.objects.BasicObject;
	import com.company.assembleegameclient.objects.Character;
	import com.company.assembleegameclient.objects.GameObject;
	import com.company.assembleegameclient.objects.Party;
	import com.company.assembleegameclient.objects.Pet;
	import com.company.assembleegameclient.objects.Player;
	import com.company.assembleegameclient.objects.particles.ParticleEffect;
	import com.company.assembleegameclient.parameters.Parameters;
	import com.company.assembleegameclient.util.ConditionEffect;

	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.GraphicsBitmapFill;
	import flash.display.GraphicsSolidFill;
	import flash.display.IGraphicsData;
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.filters.BlurFilter;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.FileReference;
	import flash.utils.Dictionary;

	import kabam.rotmg.assets.EmbeddedAssets;
	import kabam.rotmg.core.StaticInjectorContext;
	import kabam.rotmg.game.logging.RollingMeanLoopMonitor;
	import kabam.rotmg.game.model.GameModel;
	import kabam.rotmg.game.model.QuestModel;
	import kabam.rotmg.stage3D.GraphicsFillExtra;
	import kabam.rotmg.stage3D.Object3D.Object3DStage3D;
	import kabam.rotmg.stage3D.Render3D;
	import kabam.rotmg.stage3D.Renderer;
	import kabam.rotmg.stage3D.graphic3D.Program3DFactory;
	import kabam.rotmg.stage3D.graphic3D.TextureFactory;
	import kabam.rotmg.ui.signals.RealmOryxSignal;

	public class Map extends AbstractMap
	{

		public static const REALMS:Vector.<String> = new <String>["Medusa", "Beholder", "Cyclops", "Djinn", "Ogre", "Flayer", "Sprite", "Golem"];
		public static const CLOTH_BAZAAR:String = "Cloth Bazaar";
		public static const NEXUS:String = "Nexus";
		public static const DAILY_QUEST_ROOM:String = "Daily Quest Room";
		public static const DAILY_LOGIN_ROOM:String = "Daily Login Room";
		public static const PET_YARD_1:String = "Pet Yard";
		public static const PET_YARD_2:String = "Pet Yard 2";
		public static const PET_YARD_3:String = "Pet Yard 3";
		public static const PET_YARD_4:String = "Pet Yard 4";
		public static const PET_YARD_5:String = "Pet Yard 5";
		public static const REALM:String = "Realm of the Mad God";
		public static const ORYX_CHAMBER:String = "Oryx's Chamber";
		public static const GUILD_HALL:String = "Guild Hall";
		public static const NEXUS_EXPLANATION:String = "Nexus_Explanation";
		public static const VAULT:String = "Vault";
		public static var forceSoftwareRender:Boolean = false;
		public static var teleportAllowed:Boolean;
		private static const VISIBLE_SORT_FIELDS:Array = ["sortVal_", "objectId_"];
		private static const VISIBLE_SORT_PARAMS:Array = [Array.NUMERIC, Array.NUMERIC];
		protected static const BLIND_FILTER:ColorMatrixFilter = new ColorMatrixFilter([0.05, 0.05, 0.05, 0, 0, 0.05, 0.05, 0.05, 0, 0, 0.05, 0.05, 0.05, 0, 0, 0.05, 0.05, 0.05, 1, 0]);
		protected static var BREATH_CT:ColorTransform = new ColorTransform((0xFF / 0xFF), (55 / 0xFF), (0 / 0xFF), 0);
		public static var texture:BitmapData;

		public var ifDrawEffectFlag:Boolean = true;
		private var loopMonitor:RollingMeanLoopMonitor;
		private var inUpdate_:Boolean = false;
		private var objsToAdd_:Vector.<BasicObject> = new Vector.<BasicObject>();
		private var idsToRemove_:Vector.<int> = new Vector.<int>();
		private var forceSoftwareMap:Dictionary = new Dictionary();
		private var lastSoftwareClear:Boolean = false;
		private var darknessOverlay_:DisplayObject = new EmbeddedAssets.DarknessBackground();
		private var bgCont:Sprite = new Sprite();
		private var oryxObjectId:int;
		private var graphicsData_:Vector.<IGraphicsData> = new Vector.<IGraphicsData>();
		private var graphicsDataStageSoftware_:Vector.<IGraphicsData> = new Vector.<IGraphicsData>();
		private var graphicsData3d_:Vector.<Object3DStage3D> = new Vector.<Object3DStage3D>();
		public var visible_:Array = [];
		public var visibleUnder_:Array = [];
		public var visibleSquares_:Vector.<Square> = new Vector.<Square>();
		public var topSquares_:Vector.<Square> = new Vector.<Square>();

		public function Map(_arg_1:AGameSprite)
		{
			gs_ = _arg_1;
			mapHitArea = new Sprite();
			hurtOverlay_ = new HurtOverlay();
			gradientOverlay_ = new GradientOverlay();
			mapOverlay_ = new MapOverlay();
			partyOverlay_ = new PartyOverlay(this);
			party_ = new Party(this);
			quest_ = new Quest(this);
			this.loopMonitor = StaticInjectorContext.getInjector().getInstance(RollingMeanLoopMonitor);
			StaticInjectorContext.getInjector().getInstance(GameModel).gameObjects = goDict_;
			this.forceSoftwareMap[PET_YARD_1] = true;
			this.forceSoftwareMap[PET_YARD_2] = true;
			this.forceSoftwareMap[PET_YARD_3] = true;
			this.forceSoftwareMap[PET_YARD_4] = true;
			this.forceSoftwareMap[PET_YARD_5] = true;
			this.forceSoftwareMap["Nexus"] = true;
			this.forceSoftwareMap["Tomb of the Ancients"] = true;
			this.forceSoftwareMap["Tomb of the Ancients (Heroic)"] = true;
			this.forceSoftwareMap["Mad Lab"] = true;
			this.forceSoftwareMap["Guild Hall"] = true;
			this.forceSoftwareMap["Guild Hall 2"] = true;
			this.forceSoftwareMap["Guild Hall 3"] = true;
			this.forceSoftwareMap["Guild Hall 4"] = true;
			this.forceSoftwareMap["Cloth Bazaar"] = true;
			this.forceSoftwareMap["Santa Workshop"] = true;
			wasLastFrameGpu = Parameters.isGpuRender();
		}

		override public function setProps(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:int, _arg_5:Boolean, _arg_6:Boolean):void
		{
			width_ = _arg_1;
			height_ = _arg_2;
			name_ = _arg_3;
			back_ = _arg_4;
			allowPlayerTeleport_ = _arg_5;
			showDisplays_ = _arg_6;
			this.forceSoftwareRenderCheck(name_);
		}

		override public function setHitAreaProps(_arg_1:int, _arg_2:int):void
		{
			mapHitArea.graphics.beginFill(0xFF0000, 0);
			mapHitArea.graphics.drawRect((-(_arg_1) / 2), ((-(_arg_2) / 2) - 20), _arg_1, _arg_2);
		}

		private function forceSoftwareRenderCheck(_arg_1:String):void
		{
			forceSoftwareRender = (this.forceSoftwareMap[_arg_1] != null || ROTMG.STAGE != null && ROTMG.STAGE.stage3Ds[0].context3D == null);
		}

		override public function initialize():void
		{
			squares_.length = (width_ * height_);
			addChild(this.bgCont);
			background_ = Background.getBackground(back_);
			if (!Parameters.isGpuRender())
			{
				if (background_ != null)
				{
					this.bgCont.addChild(background_);
				}
			}
			addChild(map_);
			addChild(mapHitArea);
			addChild(hurtOverlay_);
			addChild(gradientOverlay_);
			addChild(mapOverlay_);
			addChild(partyOverlay_);
			isPetYard = (name_.substr(0, 8) == "Pet Yard");
			isNexus = (name_ == "Nexus");
		}

		override public function resetOverlays():void
		{
			if (contains(hurtOverlay_))
			{
				removeChild(hurtOverlay_);
			}
			if (contains(darknessOverlay_))
			{
				removeChild(darknessOverlay_);
			}
			hurtOverlay_ = new HurtOverlay(gs_);
			darknessOverlay_ = new DarknessOverlay(gs_);
			addChild(hurtOverlay_);
			addChild(darknessOverlay_)
		}

		override public function dispose():void
		{
			var _local_1:Square;
			var _local_2:GameObject;
			var _local_3:BasicObject;
			gs_ = null;
			background_ = null;
			map_ = null;
			mapHitArea.graphics.clear();
			mapHitArea = null;
			hurtOverlay_ = null;
			gradientOverlay_ = null;
			mapOverlay_ = null;
			partyOverlay_ = null;
			for each (_local_1 in squareList_)
			{
				_local_1.dispose();
				_local_1 = null;
			}
			squareList_.length = 0;
			squareList_ = null;
			squares_.length = 0;
			squares_ = null;
			for each (_local_2 in goDict_)
			{
				_local_2.dispose();
				_local_2 = null;
			}
			goDict_ = null;
			for each (_local_3 in boDict_)
			{
				_local_3.dispose();
				_local_3 = null;
			}
			boDict_ = null;
			merchLookup_ = null;
			player_ = null;
			party_ = null;
			quest_ = null;
			this.objsToAdd_ = null;
			this.idsToRemove_ = null;
			TextureFactory.disposeTextures();
			GraphicsFillExtra.dispose();
			Program3DFactory.getInstance().dispose();
		}

		override public function update(_arg_1:int, _arg_2:int):void
		{
			var _local_3:BasicObject;
			var _local_4:int;
			this.inUpdate_ = true;
			for each (_local_3 in goDict_)
			{
				if (!_local_3.update(_arg_1, _arg_2))
				{
					if (this.idsToRemove_ != null)
					{
						this.idsToRemove_.push(_local_3.objectId_);
					}
				}
			}
			for each (_local_3 in boDict_)
			{
				if (!_local_3.update(_arg_1, _arg_2))
				{
					if (this.idsToRemove_ != null)
					{
						this.idsToRemove_.push(_local_3.objectId_);
					}
				}
			}
			this.inUpdate_ = false;
			for each (_local_3 in this.objsToAdd_)
			{
				this.internalAddObj(_local_3);
			}
			if (this.objsToAdd_ != null)
			{
				this.objsToAdd_.length = 0;
			}
			for each (_local_4 in this.idsToRemove_)
			{
				this.internalRemoveObj(_local_4);
			}
			if (this.idsToRemove_ != null)
			{
				this.idsToRemove_.length = 0;
			}
			if (party_ != null)
			{
				party_.update(_arg_1, _arg_2);
			}
		}

		override public function pSTopW(_arg_1:Number, _arg_2:Number):Point
		{
			var _local_3:Square;
			for each (_local_3 in this.visibleSquares_)
			{
				if (((!(_local_3.faces_.length == 0)) && (_local_3.faces_[0].face_.contains(_arg_1, _arg_2))))
				{
					return (new Point(_local_3.center_.x, _local_3.center_.y));
				}
			}
			return (null);
		}

		override public function setGroundTile(_arg_1:int, _arg_2:int, _arg_3:uint):void
		{
			var _local_8:int;
			var _local_9:int;
			var _local_10:Square;
			var _local_4:Square = this.getSquare(_arg_1, _arg_2);
			_local_4.setTileType(_arg_3);
			var _local_5:int = ((_arg_1 < (width_ - 1)) ? (_arg_1 + 1) : _arg_1);
			var _local_6:int = ((_arg_2 < (height_ - 1)) ? (_arg_2 + 1) : _arg_2);
			var _local_7:int = ((_arg_1 > 0) ? (_arg_1 - 1) : _arg_1);
			while (_local_7 <= _local_5)
			{
				_local_8 = ((_arg_2 > 0) ? (_arg_2 - 1) : _arg_2);
				while (_local_8 <= _local_6)
				{
					_local_9 = (_local_7 + (_local_8 * width_));
					_local_10 = squares_[_local_9];
					if (((!(_local_10 == null)) && ((_local_10.props_.hasEdge_) || (!(_local_10.tileType_ == _arg_3)))))
					{
						_local_10.faces_.length = 0;
					}
					_local_8++;
				}
				_local_7++;
			}
		}

		override public function addObj(_arg_1:BasicObject, _arg_2:Number, _arg_3:Number):void
		{
			_arg_1.x_ = _arg_2;
			_arg_1.y_ = _arg_3;
			if ((_arg_1 is ParticleEffect))
			{
				(_arg_1 as ParticleEffect).reducedDrawEnabled = (!(Parameters.data_.particleEffect));
			}
			if (this.inUpdate_)
			{
				this.objsToAdd_.push(_arg_1);
			} else
			{
				this.internalAddObj(_arg_1);
			}
		}

		public function internalAddObj(_arg_1:BasicObject):void
		{
			if (!_arg_1.addTo(this, _arg_1.x_, _arg_1.y_))
			{
				return;
			}
			var _local_2:Dictionary = ((_arg_1 is GameObject) ? goDict_ : boDict_);
			if (_local_2[_arg_1.objectId_] != null)
			{
				if (!isPetYard)
				{
					return;
				}
			}
			if (name_ == ORYX_CHAMBER && this.oryxObjectId == 0)
			{
				if (_arg_1 is Character && (_arg_1 as Character).getName() == QuestModel.ORYX_THE_MAD_GOD)
				{
					this.oryxObjectId = _arg_1.objectId_;
				}
			}
			_local_2[_arg_1.objectId_] = _arg_1;
		}

		override public function removeObj(_arg_1:int):void
		{
			if (this.inUpdate_)
			{
				this.idsToRemove_.push(_arg_1);
			} else
			{
				this.internalRemoveObj(_arg_1);
			}
		}

		public function internalRemoveObj(_arg_1:int):void
		{
			var _local_2:Dictionary = goDict_;
			var _local_3:BasicObject = _local_2[_arg_1];
			if (_local_3 == null)
			{
				_local_2 = boDict_;
				_local_3 = _local_2[_arg_1];
				if (_local_3 == null)
				{
					return;
				}
			}
			_local_3.removeFromMap();
			if (name_ == ORYX_CHAMBER && _arg_1 == this.oryxObjectId)
			{
				StaticInjectorContext.getInjector().getInstance(RealmOryxSignal).dispatch();
			}
			delete _local_2[_arg_1];
		}

		public function getSquare(_arg_1:Number, _arg_2:Number):Square
		{
			if (((((_arg_1 < 0) || (_arg_1 >= width_)) || (_arg_2 < 0)) || (_arg_2 >= height_)))
			{
				return (null);
			}
			var _local_3:int = (int(_arg_1) + (int(_arg_2) * width_));
			var _local_4:Square = squares_[_local_3];
			if (_local_4 == null)
			{
				_local_4 = new Square(this, int(_arg_1), int(_arg_2));
				squares_[_local_3] = _local_4;
				squareList_.push(_local_4);
			}
			return (_local_4);
		}

		public function lookupSquare(_arg_1:int, _arg_2:int):Square
		{
			if (((((_arg_1 < 0) || (_arg_1 >= width_)) || (_arg_2 < 0)) || (_arg_2 >= height_)))
			{
				return (null);
			}
			return (squares_[(_arg_1 + (_arg_2 * width_))]);
		}

		public function correctMapView(_arg_1:Camera):Point
		{
			var _local_7:Number;
			var _local_2:Rectangle = _arg_1.clipRect_;
			if (Parameters.ssmode || stage.scaleMode == StageScaleMode.EXACT_FIT)
			{
				x = -(_local_2.x);
				y = -(_local_2.y);
			} else
			{
				if (stage.scaleMode == StageScaleMode.NO_SCALE)
				{
					_local_7 = Parameters.data_.mscale;
					x = ((-(_local_2.x) * 800) / (ROTMG.sWidth / _local_7));
					y = ((-(_local_2.y) * 600) / (ROTMG.sHeight / _local_7));
				}
			}
			var _local_3:Number = ((-(_local_2.x) - (_local_2.width / 2)) / 50);
			var _local_5:Number = ((-(_local_2.y) - (_local_2.height / 2)) / 50);
			var _local_6:Number = Math.sqrt(((_local_3 * _local_3) + (_local_5 * _local_5)));
			var _local_4:Number = ((_arg_1.angleRad_ - (Math.PI / 2)) - Math.atan2(_local_3, _local_5));
			return (new Point((_arg_1.x_ + (_local_6 * Math.cos(_local_4))), (_arg_1.y_ + (_local_6 * Math.sin(_local_4)))));
		}

		override public function calcVulnerables():void
		{
			var _local_1:GameObject;
			this.vulnEnemyDict_.length = 0;
			this.vulnPlayerDict_.length = 0;
			for each (_local_1 in goDict_)
			{
				if (_local_1.props_.isEnemy_)
				{
					if (!_local_1.dead_)
					{
						if (_local_1.props_.isCube_ && Parameters.data_.fameBlockCubes)
						{
							continue;
						}
						if (!_local_1.props_.isGod_ && Parameters.data_.fameBlockGodsOnly)
						{
							continue;
						}
						if (!(_local_1.condition_[0] & 0xA00000))
						{
							vulnEnemyDict_.push(_local_1);
						}
					}
				} else
				{
					if (_local_1.props_.isPlayer_)
					{
						if (!_local_1.isPaused && !_local_1.isInvincible && !_local_1.isStasis && !_local_1.dead_)
						{
							vulnPlayerDict_.push(_local_1);
						}
					}
				}
			}
		}

		override public function draw(_arg_1:Camera, _arg_2:int):void
		{
			var _local_6:Square;
			var _local_13:GameObject;
			var _local_14:BasicObject;
			var _local_15:int;
			var _local_16:Number;
			var _local_17:Number;
			var _local_18:Number;
			var _local_19:Number;
			var _local_20:Number;
			var _local_21:uint;
			var _local_22:Render3D;
			var _local_23:int;
			var _local_24:Array;
			var _local_25:Number;
			var _local_3:Rectangle = _arg_1.clipRect_;
			if (stage.scaleMode == StageScaleMode.NO_SCALE)
			{
				x = ((-(_local_3.x) * 800) / ROTMG.sWidth);
				y = ((-(_local_3.y) * 600) / ROTMG.sHeight);
			} else
			{
				x = -(_local_3.x);
				y = -(_local_3.y);
			}
			if (wasLastFrameGpu != Parameters.isGpuRender())
			{
				if ((((wasLastFrameGpu == true) && (!(ROTMG.STAGE.stage3Ds[0].context3D == null))) && (!((!(ROTMG.STAGE.stage3Ds[0].context3D == null)) && (!(ROTMG.STAGE.stage3Ds[0].context3D.driverInfo.toLowerCase().indexOf("disposed") == -1))))))
				{
					ROTMG.STAGE.stage3Ds[0].context3D.clear();
					ROTMG.STAGE.stage3Ds[0].context3D.present();
				} else
				{
					map_.graphics.clear();
				}
				signalRenderSwitch.dispatch(wasLastFrameGpu);
				wasLastFrameGpu = Parameters.isGpuRender();
				if (Parameters.isGpuRender())
				{
					if (((!(background_ == null)) && (this.bgCont.contains(background_))))
					{
						this.bgCont.removeChild(background_);
					}
				} else
				{
					if (((!(background_ == null)) && (!(this.bgCont.contains(background_)))))
					{
						this.bgCont.addChild(background_);
					}
				}
			}
			var _local_5:Point = this.correctMapView(_arg_1);
			if (Parameters.ssmode || (!Parameters.lowCPUMode && Parameters.data_.showBG))
			{
				if (background_ != null && this.bgCont.contains(background_))
				{
					background_.draw(_arg_1, _arg_2);
					this.background_.visible = true;
				}
			}
			this.visible_.length = 0;
			this.visibleUnder_.length = 0;
			this.visibleSquares_.length = 0;
			this.topSquares_.length = 0;
			var _local_7:int = _arg_1.maxDist_;
			var _local_8:int = Math.max(0, (_local_5.x - _local_7));
			var _local_9:int = Math.min((width_ - 1), (_local_5.x + _local_7));
			var _local_10:int = Math.max(0, (_local_5.y - _local_7));
			var _local_11:int = Math.min((height_ - 1), (_local_5.y + _local_7));
			this.graphicsData_.length = 0;
			this.graphicsDataStageSoftware_.length = 0;
			this.graphicsData3d_.length = 0;
			var _local_12:int = _local_8;
			while (_local_12 <= _local_9)
			{
				_local_15 = _local_10;
				while (_local_15 <= _local_11)
				{
					if (squares_ != null)
					{
						_local_6 = squares_[(_local_12 + (_local_15 * width_))];
						if (_local_6 != null)
						{
							_local_16 = (_local_5.x - _local_6.center_.x);
							_local_17 = (_local_5.y - _local_6.center_.y);
							_local_18 = ((_local_16 * _local_16) + (_local_17 * _local_17));
							if (_local_18 <= _arg_1.maxDistSq_)
							{
								_local_6.lastVisible_ = _arg_2;
								_local_6.draw(this.graphicsData_, _arg_1, _arg_2);
								this.visibleSquares_.push(_local_6);
								if (_local_6.topFace_ != null)
								{
									this.topSquares_.push(_local_6);
								}
							}
						}
					}
					_local_15++;
				}
				_local_12++;
			}
			for each (_local_13 in goDict_)
			{
				_local_13.drawn_ = false;
				if (!_local_13.dead_ || _local_13.size_ == 0)
				{
					_local_6 = _local_13.square_;
					if (!((_local_6 == null) || (!(_local_6.lastVisible_ == _arg_2))))
					{
						_local_13.drawn_ = true;
						_local_13.computeSortVal(_arg_1);
						if (_local_13.props_.drawUnder_)
						{
							if (_local_13.props_.drawOnGround_)
							{
								_local_13.draw(this.graphicsData_, _arg_1, _arg_2);
							} else
							{
								this.visibleUnder_.push(_local_13);
							}
						} else
						{
							this.visible_.push(_local_13);
						}
					}
				}
			}
			for each (_local_14 in boDict_)
			{
				_local_14.drawn_ = false;
				_local_6 = _local_14.square_;
				if (!((_local_6 == null) || (!(_local_6.lastVisible_ == _arg_2))))
				{
					_local_14.drawn_ = true;
					_local_14.computeSortVal(_arg_1);
					this.visible_.push(_local_14);
				}
			}
			if (this.visibleUnder_.length > 0)
			{
				if (Parameters.ssmode || !Parameters.lowCPUMode)
				{
					this.visibleUnder_.sortOn(VISIBLE_SORT_FIELDS, VISIBLE_SORT_PARAMS);
				}
				for each (_local_14 in this.visibleUnder_)
				{
					_local_14.draw(this.graphicsData_, _arg_1, _arg_2);
				}
			}
			if (Parameters.ssmode || !Parameters.lowCPUMode)
			{
				this.visible_.sortOn(VISIBLE_SORT_FIELDS, VISIBLE_SORT_PARAMS);
			}
			if (Parameters.data_.drawShadows && !Parameters.data_.lowCPUMode)
			{
				for each (_local_14 in this.visible_)
				{
					if (_local_14.hasShadow_ && (!Parameters.data_.hideLockList && _local_14 is Player || !Parameters.data_.hidePets && _local_14 is Pet || Parameters.ssmode))
					{
						_local_14.drawShadow(this.graphicsData_, _arg_1, _arg_2);
					}
				}
			}
			for each (_local_14 in this.visible_)
			{
				_local_14.draw(this.graphicsData_, _arg_1, _arg_2);
				if (Parameters.isGpuRender())
				{
					_local_14.draw3d(this.graphicsData3d_);
				}
			}
			if (this.topSquares_.length > 0)
			{
				for each (_local_6 in this.topSquares_)
				{
					_local_6.drawTop(this.graphicsData_, _arg_1, _arg_2);
				}
			}
			if ((((!(player_ == null)) && (player_.breath_ >= 0)) && (player_.breath_ < Parameters.BREATH_THRESH)))
			{
				_local_19 = ((Parameters.BREATH_THRESH - player_.breath_) / Parameters.BREATH_THRESH);
				_local_20 = (Math.abs(Math.sin((_arg_2 / 300))) * 0.75);
				BREATH_CT.alphaMultiplier = (_local_19 * _local_20);
				hurtOverlay_.transform.colorTransform = BREATH_CT;
				hurtOverlay_.visible = true;
				hurtOverlay_.x = _local_3.left;
				hurtOverlay_.y = _local_3.top;
			} else
			{
				if (hurtOverlay_ != null)
				{
					hurtOverlay_.visible = false;
				}
			}
			if (player_ != null && !Parameters.screenShotMode_)
			{
				if (Parameters.ssmode)
				{
					gradientOverlay_.visible = true;
					gradientOverlay_.x = (_local_3.right - 10);
					gradientOverlay_.y = _local_3.top;
				} else
				{
					gradientOverlay_.visible = false;
				}
			} else
			{
				if (gradientOverlay_ != null)
				{
					gradientOverlay_.visible = false;
				}
			}
			if (Parameters.isGpuRender() && Renderer.inGame)
			{
				_local_21 = this.getFilterIndex();
				_local_22 = StaticInjectorContext.getInjector().getInstance(Render3D);
				_local_22.dispatch(this.graphicsData_, this.graphicsData3d_, width_, height_, _arg_1, _local_21);
				_local_23 = 0;
				while (_local_23 < this.graphicsData_.length)
				{
					if (((this.graphicsData_[_local_23] is GraphicsBitmapFill) && (GraphicsFillExtra.isSoftwareDraw(GraphicsBitmapFill(this.graphicsData_[_local_23])))))
					{
						this.graphicsDataStageSoftware_.push(this.graphicsData_[_local_23]);
						this.graphicsDataStageSoftware_.push(this.graphicsData_[(_local_23 + 1)]);
						this.graphicsDataStageSoftware_.push(this.graphicsData_[(_local_23 + 2)]);
					} else
					{
						if (((this.graphicsData_[_local_23] is GraphicsSolidFill) && (GraphicsFillExtra.isSoftwareDrawSolid(GraphicsSolidFill(this.graphicsData_[_local_23])))))
						{
							this.graphicsDataStageSoftware_.push(this.graphicsData_[_local_23]);
							this.graphicsDataStageSoftware_.push(this.graphicsData_[(_local_23 + 1)]);
							this.graphicsDataStageSoftware_.push(this.graphicsData_[(_local_23 + 2)]);
						}
					}
					_local_23++;
				}
				if (this.graphicsDataStageSoftware_.length > 0)
				{
					map_.graphics.clear();
					map_.graphics.drawGraphicsData(this.graphicsDataStageSoftware_);
					if (this.lastSoftwareClear)
					{
						this.lastSoftwareClear = false;
					}
				} else
				{
					if (!this.lastSoftwareClear)
					{
						map_.graphics.clear();
						this.lastSoftwareClear = true;
					}
				}
				if ((_arg_2 % 149) == 0)
				{
					GraphicsFillExtra.manageSize();
				}
			} else
			{
				map_.graphics.clear();
				map_.graphics.drawGraphicsData(this.graphicsData_);
			}
			map_.filters.length = 0;
			if (((!(player_ == null)) && (!((player_.condition_[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.MAP_FILTER_BITMASK) == 0))))
			{
				_local_24 = [];
				if (player_.isDrunk)
				{
					_local_25 = (20 + (10 * Math.sin((_arg_2 / 1000))));
					_local_24.push(new BlurFilter(_local_25, _local_25));
				}
				if (player_.isBlind)
				{
					_local_24.push(BLIND_FILTER);
				}
				map_.filters = _local_24;
			} else
			{
				if (map_.filters.length > 0)
				{
					map_.filters = [];
				}
			}
			mapOverlay_.draw(_arg_1, _arg_2);
			partyOverlay_.draw(_arg_1, _arg_2);
			if (player_ != null && player_.isDarkness && !Parameters.data_.ignoreDarkness)
			{
				darknessOverlay_.x = -300;
				darknessOverlay_.y = ((Parameters.data_.centerOnPlayer) ? -525 : -515);
				darknessOverlay_.alpha = 0.95;
				addChild(this.darknessOverlay_);
			} else
			{
				if (contains(darknessOverlay_))
				{
					removeChild(darknessOverlay_);
				}
			}
		}

		private function getFilterIndex():uint
		{
			var _local_1:uint;
			if (player_ != null && (player_.condition_[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.MAP_FILTER_BITMASK) != 0)
			{
				if (player_.isPaused)
				{
					_local_1 = Renderer.STAGE3D_FILTER_PAUSE;
				} else
				{
					if (player_.isBlind)
					{
						_local_1 = Renderer.STAGE3D_FILTER_BLIND;
					} else
					{
						if (player_.isDrunk)
						{
							_local_1 = Renderer.STAGE3D_FILTER_DRUNK;
						}
					}
				}
			}
			return (_local_1);
		}

		override public function saveMap(_arg_1:Boolean):void
		{
			if (_arg_1)
			{
				var _local_3:String;
				for each (var _local_2:Square in this.squares_)
				{
					if (_local_2)
					{
						_local_3 = _local_3 + "x" + _local_2.x_ + "y" + _local_2.y_ + "t" + _local_2.tileType_ + "\n";
					}
				}
				new FileReference().save(_local_3, (this.name_ + ".txt"));
			} else
			{
				new FileReference().save(PNGEncoder.encode(this.gs_.hudView.miniMap.miniMapData_), (this.name_ + ".png"));
			}
		}

		override public function needsMapHack(_arg_1:String):int
		{
			if (!Parameters.data_.mapHack)
			{
				return (0);
			}
			var _local_2:Vector.<String> = new <String>["Vault", "Oryx's Castle", "Oryx's Chamber", "Wine Cellar", "Nexus"];
			if (_local_2.indexOf(_arg_1) > -1)
			{
				return (2);
			}
			if (_arg_1 == "Nexus")
			{
				return (3);
			}
			if (_arg_1 == "Realm of the Mad God")
			{
				return (1);
			}
			return (0);
		}

	}
}//package com.company.assembleegameclient.map

