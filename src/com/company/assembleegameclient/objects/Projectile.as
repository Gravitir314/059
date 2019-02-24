﻿//com.company.assembleegameclient.objects.Projectile

package com.company.assembleegameclient.objects
	{
    import com.company.assembleegameclient.engine3d.Point3D;
    import com.company.assembleegameclient.map.Camera;
    import com.company.assembleegameclient.map.Map;
    import com.company.assembleegameclient.map.Square;
    import com.company.assembleegameclient.objects.particles.HitEffect;
    import com.company.assembleegameclient.objects.particles.SparkParticle;
    import com.company.assembleegameclient.parameters.Parameters;
    import com.company.assembleegameclient.tutorial.Tutorial;
    import com.company.assembleegameclient.tutorial.doneAction;
    import com.company.assembleegameclient.util.BloodComposition;
    import com.company.assembleegameclient.util.FreeList;
    import com.company.assembleegameclient.util.RandomUtil;
    import com.company.assembleegameclient.util.TextureRedrawer;
    import com.company.util.GraphicsUtil;
    import com.company.util.Trig;

    import flash.display.BitmapData;
    import flash.display.GradientType;
    import flash.display.GraphicsGradientFill;
    import flash.display.GraphicsPath;
    import flash.display.IGraphicsData;
    import flash.geom.Matrix;
    import flash.geom.Point;
    import flash.geom.Vector3D;
    import flash.utils.Dictionary;

    import zfn.Hit;

    public class Projectile extends BasicObject
		{

			private static var objBullIdToObjId_:Dictionary = new Dictionary();

			public var props_:ObjectProperties;
			public var containerProps_:ObjectProperties;
			public var projProps_:ProjectileProperties;
			public var texture_:BitmapData;
			public var bulletId_:uint;
			public var bIdMod2Flip_:int;
			public var bIdMod4Flip_:int;
			public var phase_:Number;
			public var ownerId_:int;
			public var containerType_:int;
			public var bulletType_:uint;
			public var damagesEnemies_:Boolean;
			public var damagesPlayers_:Boolean;
			public var damage_:int;
			public var sound_:String;
			public var startX_:Number;
			public var startY_:Number;
			public var startTime_:int;
			public var halfway_:Number;
			public var angle_:Number = 0;
			public var sinAngle_:Number;
			public var cosAngle_:Number;
			public var multiHitDict_:Dictionary;
			public var p_:Point3D = new Point3D(100);
			private var staticPoint_:Point = new Point();
			private var staticVector3D_:Vector3D = new Vector3D();
			protected var shadowGradientFill_:GraphicsGradientFill = new GraphicsGradientFill(GradientType.RADIAL, [0, 0], [0.5, 0], null, new Matrix());
			protected var shadowPath_:GraphicsPath = new GraphicsPath(GraphicsUtil.QUAD_COMMANDS, new Vector.<Number>());
			public var multiHitVec:Vector.<int>;


			public static function findObjId(_arg_1:int, _arg_2:uint):int
			{
				return (objBullIdToObjId_[((_arg_2 << 24) | _arg_1)]);
			}

			public static function getNewObjId(_arg_1:int, _arg_2:uint):int
			{
				var _local_3:int = getNextFakeObjectId();
				objBullIdToObjId_[((_arg_2 << 24) | _arg_1)] = _local_3;
				return (_local_3);
			}

			public static function removeObjId(_arg_1:int, _arg_2:uint):void
			{
				delete objBullIdToObjId_[((_arg_2 << 24) | _arg_1)];
			}

			public static function dispose():void
			{
				objBullIdToObjId_ = new Dictionary();
			}


			public function reset(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:Number, _arg_6:int, _arg_7:String = "", _arg_8:String = "", _arg_9:ObjectProperties = null, _arg_10:ProjectileProperties = null):void
			{
				var _local_11:Number;
				clear();
				this.containerType_ = _arg_1;
				this.bulletType_ = _arg_2;
				this.ownerId_ = _arg_3;
				this.bulletId_ = _arg_4;
				this.bIdMod2Flip_ = ((this.bulletId_ % 2) ? 1 : -1);
				this.bIdMod4Flip_ = (((this.bulletId_ % 4) < 2) ? 1 : -1);
				this.phase_ = (((this.bulletId_ % 2) == 0) ? 0 : Math.PI);
				this.angle_ = Trig.boundToPI(_arg_5);
				this.sinAngle_ = Math.sin(this.angle_);
				this.cosAngle_ = Math.cos(this.angle_);
				this.startTime_ = _arg_6;
				objectId_ = getNewObjId(this.ownerId_, this.bulletId_);
				z_ = 0.5;
				if (_arg_9 == null)
				{
					this.containerProps_ = ObjectLibrary.propsLibrary_[this.containerType_];
				}
				else
				{
					this.containerProps_ = _arg_9;
				}
				if (_arg_10 == null)
				{
					this.projProps_ = this.containerProps_.projectiles_[_arg_2];
				}
				else
				{
					this.projProps_ = _arg_10;
				}
				this.halfway_ = ((this.projProps_.lifetime_ * this.projProps_.speed_) * 0.5);
				var _local_12:String = ((_arg_7 != "" && this.projProps_.objectId_ == _arg_8) ? _arg_7 : this.projProps_.objectId_);
				this.props_ = ObjectLibrary.getPropsFromId(_local_12);
				hasShadow_ = (this.props_.shadowSize_ > 0);
				var _local_10:TextureData = ObjectLibrary.typeToTextureData_[this.props_.type_];
				this.texture_ = _local_10.getTexture(objectId_);
				this.damagesPlayers_ = this.containerProps_.isEnemy_;
				this.damagesEnemies_ = (!(this.damagesPlayers_));
				this.sound_ = this.containerProps_.oldSound_;
				this.multiHitDict_ = ((this.projProps_.multiHit_) ? new Dictionary() : null);
				this.multiHitVec = ((this.projProps_.multiHit_) ? new Vector.<int>(0) : null);
				if (this.projProps_.size_ >= 0)
				{
					_local_11 = this.projProps_.size_;
				}
				else
				{
					_local_11 = ObjectLibrary.getSizeFromType(this.containerType_);
				}
				this.p_.setSize(8 * (_local_11 / 100));
				this.damage_ = 0;
			}

			public function setDamage(_arg_1:int):void
			{
				this.damage_ = _arg_1;
			}

			override public function addTo(_arg_1:Map, _arg_2:Number, _arg_3:Number):Boolean
			{
				var _local_4:Player;
				this.startX_ = _arg_2;
				this.startY_ = _arg_3;
				if (!super.addTo(_arg_1, _arg_2, _arg_3))
				{
					return (false);
				}
				if (((!(this.containerProps_.flying_)) && (square_.sink_)))
				{
					z_ = 0.1;
				}
				else
				{
					_local_4 = (_arg_1.goDict_[this.ownerId_] as Player);
					if (((!(_local_4 == null)) && (_local_4.sinkLevel_ > 0)))
					{
						z_ = (0.5 - (0.4 * (_local_4.sinkLevel_ / Parameters.MAX_SINK_LEVEL)));
					}
				}
				return (true);
			}

			public function moveTo(_arg_1:Number, _arg_2:Number):Boolean
			{
				var _local_3:Square = map_.getSquare(_arg_1, _arg_2);
				if (_local_3 == null)
				{
					return (false);
				}
				x_ = _arg_1;
				y_ = _arg_2;
				square_ = _local_3;
				return (true);
			}

			override public function removeFromMap():void
			{
				super.removeFromMap();
				removeObjId(this.ownerId_, this.bulletId_);
				this.multiHitDict_ = null;
				this.multiHitVec = null;
				FreeList.deleteObject(this);
			}

			private function positionAt(_arg_1:int, _arg_2:Point):void
			{
				var _local_5:Number;
				var _local_6:Number;
				var _local_7:Number;
				var _local_8:Number;
				var _local_9:Number;
				var _local_10:Number;
				var _local_11:Number;
				var _local_12:Number;
				var _local_13:Number;
				var _local_14:Number;
				_arg_2.x = this.startX_;
				_arg_2.y = this.startY_;
				var _local_3:Number = (_arg_1 * (this.projProps_.speed_ / 10000));
				var _local_4:Number = (((this.bulletId_ % 2) == 0) ? 0 : Math.PI);
				if (this.projProps_.wavy_)
				{
					_local_5 = (6 * Math.PI);
					_local_6 = (Math.PI / 64);
					_local_7 = (this.angle_ + (_local_6 * Math.sin((_local_4 + ((_local_5 * _arg_1) / 1000)))));
					_arg_2.x = (_arg_2.x + (_local_3 * Math.cos(_local_7)));
					_arg_2.y = (_arg_2.y + (_local_3 * Math.sin(_local_7)));
				}
				else
				{
					if (this.projProps_.parametric_)
					{
						_local_8 = (((_arg_1 / this.projProps_.lifetime_) * 2) * Math.PI);
						_local_9 = (Math.sin(_local_8) * ((this.bulletId_ % 2) ? 1 : -1));
						_local_10 = (Math.sin((2 * _local_8)) * (((this.bulletId_ % 4) < 2) ? 1 : -1));
						_local_11 = Math.sin(this.angle_);
						_local_12 = Math.cos(this.angle_);
						_arg_2.x = (_arg_2.x + (((_local_9 * _local_12) - (_local_10 * _local_11)) * this.projProps_.magnitude_));
						_arg_2.y = (_arg_2.y + (((_local_9 * _local_11) + (_local_10 * _local_12)) * this.projProps_.magnitude_));
					}
					else
					{
						if (this.projProps_.boomerang_)
						{
							_local_13 = ((this.projProps_.lifetime_ * (this.projProps_.speed_ / 10000)) / 2);
							if (_local_3 > _local_13)
							{
								_local_3 = (_local_13 - (_local_3 - _local_13));
							}
						}
						_arg_2.x = (_arg_2.x + (_local_3 * Math.cos(this.angle_)));
						_arg_2.y = (_arg_2.y + (_local_3 * Math.sin(this.angle_)));
						if (this.projProps_.amplitude_ != 0)
						{
							_local_14 = (this.projProps_.amplitude_ * Math.sin((_local_4 + ((((_arg_1 / this.projProps_.lifetime_) * this.projProps_.frequency_) * 2) * Math.PI))));
							_arg_2.x = (_arg_2.x + (_local_14 * Math.cos((this.angle_ + (Math.PI / 2)))));
							_arg_2.y = (_arg_2.y + (_local_14 * Math.sin((this.angle_ + (Math.PI / 2)))));
						}
					}
				}
			}

			// TODO stopped
			override public function update(_arg_1:int, _arg_2:int):Boolean
			{
				var _local_5:Vector.<uint>;
				var _local_7:Player;
				var _local_8:Boolean;
				var _local_9:Boolean;
				var _local_10:Boolean;
				var _local_11:int;
				var _local_12:Boolean;
				var _local_3:int = (_arg_1 - this.startTime_);
				if (_local_3 > this.projProps_.lifetime_ || map_ == null)
				{
					return (false);
				}
				var _local_4:Point = this.staticPoint_;
				this.positionAt(_local_3, _local_4);
				if (!this.moveTo(_local_4.x, _local_4.y) || square_.tileType_ == 0xFFFF)
				{
					if (this.damagesPlayers_)
					{
						map_.gs_.gsc_.squareHit(_arg_1, this.bulletId_, this.ownerId_);
					}
					else
					{
						if (square_.obj_ != null)
						{
							if (!Parameters.data_.noParticlesMaster || !Parameters.ssmode && !Parameters.data_.liteParticle)
							{
								if (texture_ != null)
								{
									_local_5 = BloodComposition.getColors(this.texture_);
									map_.addObj(new HitEffect(_local_5, 100, 3, this.angle_, this.projProps_.speed_), _local_4.x, _local_4.y);
								}
							}
						}
					}
					return (false);
				}
				if (!(ownerId_ == map_.player_.objectId_ && Parameters.data_.PassesCover))
				{
					if (square_.obj_ != null)
					{
						if ((!square_.obj_.props_.isEnemy_ || !damagesEnemies_) && (square_.obj_.props_.enemyOccupySquare_ || !projProps_.passesCover_ && square_.obj_.props_.occupySquare_))
						{
							if (damagesPlayers_)
							{
								map_.gs_.gsc_.otherHit(_arg_1, bulletId_, ownerId_, square_.obj_.objectId_);
							}
							else
							{
								if (!Parameters.data_.noParticlesMaster)
								{
									if (texture_ != null)
									{
										_local_5 = BloodComposition.getColors(texture_);
										this.map_.addObj(new HitEffect(_local_5, 100, 3, angle_, projProps_.speed_), _local_4.x, _local_4.y);
									}
								}
							}
							return (false);
						}
					}
				}
				var _local_6:GameObject = this.getHit(_local_4.x, _local_4.y);
				if (_local_6 != null)
				{
					_local_7 = map_.player_;
					_local_9 = _local_6.props_.isEnemy_;
					_local_10 = (_local_7 != null && !_local_7.isPaused && (this.damagesPlayers_ || _local_9 && this.ownerId_ == _local_7.objectId_));
					if (_local_10)
					{
						_local_11 = GameObject.damageWithDefense(this.damage_, _local_6.defense_, this.projProps_.armorPiercing_, _local_6.condition_);
						var isLast:Boolean = (_local_6.hp_ <= _local_11);
						if (isLast)
						{
							if (_local_6.props_.isEnemy_)
							{
								doneAction(map_.gs_, Tutorial.KILL_ACTION);
							}
						}
						if (_local_6 == _local_7)
						{
							if (_local_7.subtractDamage(_local_11, _arg_1))
							{
								return (false);
							}
							if (this.projProps_.effects_ != null)
							{
								_local_12 = false;
								var counter:int = 0;
								while (counter < this.projProps_.effects_.length)
								{
									var effect:uint = this.projProps_.effects_[counter];
									if (effect > 32)
									{
										effect = ((1 << effect) & Parameters.data_.ssdebuffBitmask2);
									}
									else
									{
										effect = ((1 << (effect - 32)) & Parameters.data_.ssdebuffBitmask);
									}
									if (effect > 0)
									{
										_local_12 = true;
									}
									counter++;
								}
								if (_local_12)
								{
									_local_7.damage(true, _local_11, null, false, this);
								}
								else
								{
									_local_7.damage(true, _local_11, this.projProps_.effects_, false, this);
									this.map_.gs_.hitQueue.push(new Hit(this.bulletId_, this.ownerId_));
								}
							}
							else
							{
								_local_7.damage(true, _local_11, this.projProps_.effects_, false, this);
								this.map_.gs_.hitQueue.push(new Hit(bulletId_, ownerId_));
							}
						}
						else
						{
							if (_local_6.props_.isEnemy_)
							{
								if (_local_6.props_.isCube_ && Parameters.data_.fameBlockCubes || !_local_6.props_.isGod_ && Parameters.data_.fameBlockGodsOnly)
								{
									return (true);
								}
								map_.gs_.gsc_.enemyHit(_arg_1, bulletId_, _local_6.objectId_, isLast);
								_local_6.damage(true, _local_11, projProps_.effects_, isLast, this);
								if (isNaN(Parameters.dmgCounter[_local_6.objectId_]))
								{
									Parameters.dmgCounter[_local_6.objectId_] = 0;
								}
								Parameters.dmgCounter[_local_6.objectId_] = Parameters.dmgCounter[_local_6.objectId_] + _local_11;
							}
							else
							{
								if (!projProps_.multiHit_)
								{
									map_.gs_.gsc_.otherHit(_arg_1, bulletId_, ownerId_, _local_6.objectId_);
								}
							}
						}
					}
					if (projProps_.multiHit_)
					{
						this.multiHitDict_[_local_6.objectId_] = true;
					}
					else
					{
						return (false);
					}
				}
				return (true);
			}

			public function getHit(_arg_1:Number, _arg_2:Number):GameObject
			{
				var _local_5:GameObject;
				var _local_6:Number;
				var _local_7:Number;
				var _local_9:Number;
				var _local_3:Number = Number.MAX_VALUE;
				var _local_4:GameObject;
				for each (_local_5 in map_.goDict_)
				{
					if (!_local_5.isInvincible)
					{
						if (!_local_5.isStasis)
						{
							if ((((this.damagesEnemies_) && (_local_5.props_.isEnemy_)) || ((this.damagesPlayers_) && (_local_5.props_.isPlayer_))))
							{
								if (!((_local_5.dead_) || (_local_5.isPaused)))
								{
									_local_6 = ((_local_5.x_ > _arg_1) ? (_local_5.x_ - _arg_1) : (_arg_1 - _local_5.x_));
									_local_7 = ((_local_5.y_ > _arg_2) ? (_local_5.y_ - _arg_2) : (_arg_2 - _local_5.y_));
									if (!((_local_6 > GameObject.radius_) || (_local_7 > GameObject.radius_)))
									{
										if (!((this.projProps_.multiHit_) && (!(this.multiHitDict_[_local_5.objectId_] == null))))
										{
											if (_local_5 == map_.player_)
											{
												return (_local_5);
											}
											_local_9 = ((_local_6 * _local_6) + (_local_7 * _local_7));
											if (_local_9 < _local_3)
											{
												_local_3 = _local_9;
												_local_4 = _local_5;
											}
										}
									}
								}
							}
						}
					}
				}
				return (_local_4);
			}

			override public function draw(_arg_1:Vector.<IGraphicsData>, _arg_2:Camera, _arg_3:int):void
			{
				var _local_8:uint;
				var _local_9:uint;
				var _local_10:int;
				var _local_11:int;
				if (!Parameters.drawProj_)
				{
					return;
				}
				var _local_4:BitmapData = this.texture_;
				if (Parameters.projColorType_ != 0)
				{
					switch (Parameters.projColorType_)
					{
						case 1:
							_local_8 = 16777100;
							_local_9 = 0xFFFFFF;
							break;
						case 2:
							_local_8 = 16777100;
							_local_9 = 16777100;
							break;
						case 3:
							_local_8 = 0xFF0000;
							_local_9 = 0xFF0000;
							break;
						case 4:
							_local_8 = 0xFF;
							_local_9 = 0xFF;
							break;
						case 5:
							_local_8 = 0xFFFFFF;
							_local_9 = 0xFFFFFF;
							break;
						case 6:
							_local_8 = 0;
							_local_9 = 0;
							break;
					}
					_local_4 = TextureRedrawer.redraw(_local_4, 120, true, _local_9);
				}
				var _local_5:Number;
				if (Parameters.ssmode || !Parameters.data_.noRotate)
				{
					_local_5 = ((props_.rotation_ == 0) ? 0 : (_arg_3 / props_.rotation_));
				}
				else
				{
					_local_5 = 0;
				}
				this.staticVector3D_.x = x_;
				this.staticVector3D_.y = y_;
				this.staticVector3D_.z = z_;
				var _local_6:Number = ((this.projProps_.faceDir_) ? this.getDirectionAngle(_arg_3) : this.angle_);
				var _local_7:Number = ((this.projProps_.noRotation_) ? (_arg_2.angleRad_ + this.props_.angleCorrection_) : (((_local_6 - _arg_2.angleRad_) + this.props_.angleCorrection_) + _local_5));
				this.p_.draw(_arg_1, this.staticVector3D_, _local_7, _arg_2.wToS_, _arg_2, _local_4);
				if (projProps_.particleTrail_ && (!Parameters.data_.noParticlesMaster || Parameters.ssmode || !Parameters.data_.liteParticle))
				{
					_local_10 = ((this.projProps_.particleTrailLifetimeMS != -1) ? this.projProps_.particleTrailLifetimeMS : 600);
					_local_11 = 0;
					while (_local_11 < 3)
					{
						if (map_ != null && map_.player_.objectId_ != ownerId_ || (!(projProps_.particleTrailIntensity_ == -1 && (Math.random() * 100) > projProps_.particleTrailIntensity_)))
						{
							map_.addObj(new SparkParticle(100, projProps_.particleTrailColor_, _local_10, 0.5, RandomUtil.plusMinus(3), RandomUtil.plusMinus(3)), x_, y_);
						}
						_local_11++;
					}
				}
			}

			private function getDirectionAngle(_arg_1:Number):Number
			{
				var _local_2:int = (_arg_1 - this.startTime_);
				var _local_3:Point = new Point();
				this.positionAt((_local_2 + 16), _local_3);
				var _local_4:Number = (_local_3.x - x_);
				var _local_5:Number = (_local_3.y - y_);
				return (Math.atan2(_local_5, _local_4));
			}

			override public function drawShadow(_arg_1:Vector.<IGraphicsData>, _arg_2:Camera, _arg_3:int):void
			{
				if (Parameters.data_.hideAllProjectiles || !Parameters.drawProj_)
				{
					return;
				}
				var _local_4:Number = (this.props_.shadowSize_ / 400);
				var _local_5:Number = (30 * _local_4);
				var _local_6:Number = (15 * _local_4);
				this.shadowGradientFill_.matrix.createGradientBox((_local_5 * 2), (_local_6 * 2), 0, (posS_[0] - _local_5), (posS_[1] - _local_6));
				_arg_1.push(this.shadowGradientFill_);
				this.shadowPath_.data.length = 0;
				Vector.<Number>(this.shadowPath_.data).push((posS_[0] - _local_5), (posS_[1] - _local_6), (posS_[0] + _local_5), (posS_[1] - _local_6), (posS_[0] + _local_5), (posS_[1] + _local_6), (posS_[0] - _local_5), (posS_[1] + _local_6));
				_arg_1.push(this.shadowPath_);
				_arg_1.push(GraphicsUtil.END_FILL);
			}


		}
	}//package com.company.assembleegameclient.objects

