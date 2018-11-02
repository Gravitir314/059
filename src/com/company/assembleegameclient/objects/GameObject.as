//com.company.assembleegameclient.objects.GameObject

package com.company.assembleegameclient.objects
	{
	import com.company.assembleegameclient.engine3d.Model3D;
	import com.company.assembleegameclient.engine3d.Object3D;
	import com.company.assembleegameclient.map.Camera;
	import com.company.assembleegameclient.map.Map;
	import com.company.assembleegameclient.map.Square;
	import com.company.assembleegameclient.map.mapoverlay.CharacterStatusText;
	import com.company.assembleegameclient.objects.animation.Animations;
	import com.company.assembleegameclient.objects.animation.AnimationsData;
	import com.company.assembleegameclient.objects.particles.ExplosionEffect;
	import com.company.assembleegameclient.objects.particles.HitEffect;
	import com.company.assembleegameclient.objects.particles.ParticleEffect;
	import com.company.assembleegameclient.objects.particles.ShockerEffect;
	import com.company.assembleegameclient.parameters.Parameters;
	import com.company.assembleegameclient.sound.SoundEffectLibrary;
	import com.company.assembleegameclient.util.AnimatedChar;
	import com.company.assembleegameclient.util.BloodComposition;
	import com.company.assembleegameclient.util.ConditionEffect;
	import com.company.assembleegameclient.util.MaskedImage;
	import com.company.assembleegameclient.util.TextureRedrawer;
	import com.company.assembleegameclient.util.redrawers.GlowRedrawer;
	import com.company.util.AssetLibrary;
	import com.company.util.BitmapUtil;
	import com.company.util.CachingColorTransformer;
	import com.company.util.ConversionUtil;
	import com.company.util.GraphicsUtil;
	import com.company.util.MoreColorUtil;

	import flash.display.BitmapData;
	import flash.display.GradientType;
	import flash.display.GraphicsBitmapFill;
	import flash.display.GraphicsGradientFill;
	import flash.display.GraphicsPath;
	import flash.display.GraphicsSolidFill;
	import flash.display.IGraphicsData;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Vector3D;
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	import flash.utils.getTimer;

	import io.decagames.rotmg.pets.data.PetsModel;
	import io.decagames.rotmg.pets.data.vo.PetVO;

	import kabam.rotmg.core.StaticInjectorContext;
	import kabam.rotmg.messaging.impl.data.WorldPosData;
	import kabam.rotmg.stage3D.GraphicsFillExtra;
	import kabam.rotmg.stage3D.Object3D.Object3DStage3D;
	import kabam.rotmg.text.model.TextKey;
	import kabam.rotmg.text.view.BitmapTextFactory;
	import kabam.rotmg.text.view.stringBuilder.LineBuilder;
	import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
	import kabam.rotmg.text.view.stringBuilder.StringBuilder;

	public class GameObject extends BasicObject
		{

			protected static const PAUSED_FILTER:ColorMatrixFilter = new ColorMatrixFilter(MoreColorUtil.greyscaleFilterMatrix);
			protected static const CURSED_FILTER:ColorMatrixFilter = new ColorMatrixFilter(MoreColorUtil.redFilterMatrix);
			protected static const IDENTITY_MATRIX:Matrix = new Matrix();
			private static const ZERO_LIMIT:Number = 1E-5;
			private static const NEGATIVE_ZERO_LIMIT:Number = -(ZERO_LIMIT);
			public static const ATTACK_PERIOD:int = 300;
			private static const DEFAULT_HP_BAR_Y_OFFSET:int = 6;
			public static const radius_:Number = 0.5;

			public var nameBitmapData_:BitmapData = null;
			private var nameFill_:GraphicsBitmapFill = null;
			private var namePath_:GraphicsPath = null;
			public var shockEffect:ShockerEffect;
			private var isShocked:Boolean;
			private var isShockedTransformSet:Boolean = false;
			private var isCharging:Boolean;
			private var isChargingTransformSet:Boolean = false;
			public var props_:ObjectProperties = ObjectLibrary.defaultProps_;
			public var name_:String;
			public var facing_:Number = 0;
			public var flying_:Boolean = false;
			public var attackAngle_:Number = 0;
			public var attackStart_:int = 0;
			public var animatedChar_:AnimatedChar = null;
			public var texture_:BitmapData = null;
			public var mask_:BitmapData = null;
			public var randomTextureData_:Vector.<TextureData> = null;
			public var obj3D_:Object3D = null;
			public var object3d_:Object3DStage3D = null;
			public var effect_:ParticleEffect = null;
			public var animations_:Animations = null;
			public var dead_:Boolean = false;
			public var deadCounter_:uint = 0;
			protected var portrait_:BitmapData = null;
			protected var texturingCache_:Dictionary = null;
			public var maxHP_:int = 200;
			public var hp_:int = 200;
			public var size_:int = 100;
			public var level_:int = -1;
			public var defense_:int = 0;
			public var slotTypes_:Vector.<int> = null;
			public var equipment_:Vector.<int> = null;
			public var lockedSlot:Vector.<int> = null;
			public var condition_:Vector.<uint> = new <uint>[0, 0];
			public var supporterPoints:int = 0;
			protected var tex1Id_:int = 0;
			protected var tex2Id_:int = 0;
			public var isInteractive_:Boolean = false;
			public var objectType_:int;
			private var nextBulletId_:uint = 1;
			private var sizeMult_:Number = 1;
			public var sinkLevel_:int = 0;
			public var hallucinatingTexture_:BitmapData = null;
			public var flash_:FlashDescription = null;
			public var connectType_:int = -1;
			private var isStasisImmune_:Boolean = false;
			private var isInvincibleXML:Boolean = false;
			private var isStunImmuneVar_:Boolean = false;
			private var isParalyzeImmuneVar_:Boolean = false;
			private var isDazedImmuneVar_:Boolean = false;
			protected var lastTickUpdateTime_:int = 0;
			protected var myLastTickId_:int = -1;
			protected var posAtTick_:Point = new Point();
			protected var bitmapFill_:GraphicsBitmapFill = new GraphicsBitmapFill(null, null, false, false);
			protected var path_:GraphicsPath = new GraphicsPath(GraphicsUtil.QUAD_COMMANDS, null);
			protected var vS_:Vector.<Number> = new Vector.<Number>();
			protected var uvt_:Vector.<Number> = new Vector.<Number>();
			protected var fillMatrix_:Matrix = new Matrix();
			private var hpbarBackFill_:GraphicsSolidFill = null;
			private var hpbarBackPath_:GraphicsPath = null;
			private var hpbarFill_:GraphicsSolidFill = null;
			private var hpbarPath_:GraphicsPath = null;
			private var icons_:Vector.<BitmapData> = null;
			private var iconFills_:Vector.<GraphicsBitmapFill> = null;
			private var iconPaths_:Vector.<GraphicsPath> = null;
			protected var shadowGradientFill_:GraphicsGradientFill = null;
			protected var shadowPath_:GraphicsPath = null;

			private var lastCon1:uint = 0;
			private var lastCon2:uint = 0;
			public var fakeBag_:Boolean;
			public var hasShock:Boolean;
			public var isQuiet:Boolean;
			public var isWeak:Boolean;
			public var isSlowed:Boolean;
			public var isSick:Boolean;
			public var isDazed:Boolean;
			public var isStunned:Boolean;
			public var isBlind:Boolean;
			public var isDrunk:Boolean;
			public var isBleeding:Boolean;
			public var isConfused:Boolean;
			public var isStunImmune:Boolean;
			public var isInvisible:Boolean;
			public var isParalyzed:Boolean;
			public var isSpeedy:Boolean;
			public var isNinjaSpeedy:Boolean;
			public var isHallucinating:Boolean;
			public var isHealing:Boolean;
			public var isDamaging:Boolean;
			public var isBerserk:Boolean;
			public var isPaused:Boolean;
			public var isStasis:Boolean;
			public var isInvincible:Boolean;
			public var isInvulnerable:Boolean;
			public var isArmored:Boolean;
			public var isArmorBroken:Boolean;
			public var isArmorBrokenImmune:Boolean;
			public var isSlowedImmune:Boolean;
			public var isUnstable:Boolean;
			public var isShowPetEffectIcon:Boolean;
			public var isDarkness:Boolean;
			public var isParalyzeImmune:Boolean;
			public var isDazedImmune:Boolean;
			public var isPetrified:Boolean;
			public var isPetrifiedImmune:Boolean;
			public var isCursed:Boolean;
			public var isCursedImmune:Boolean;
			public var isSilenced:Boolean;
			public var isExposed:Boolean;
			public var mobInfoShown:Boolean;
			public var footer_:Boolean;
			public var lastPercent_:int;
			public var myPet:Boolean;
			public var jittery:Boolean = false;
			public var highestDpsWeaponIcon:BitmapData;
			public var calcHighestDps:Boolean = true;
			private var previousArmored:Boolean = false;
			private var previousArmorBroken:Boolean = false;
			private var previousCursed:Boolean = false;
			private var previousPetrified:Boolean = false;
			private var previousExposed:Boolean = false;

			public var iconCache:Vector.<BitmapData> = new Vector.<BitmapData>();
			public var tickPosition_:Point = new Point();
			public var moveVec_:Vector3D = new Vector3D();

			public function GameObject(_arg_1:XML)
			{
				var _local_4:int;
				super();
				if (_arg_1 == null)
				{
					return;
				}
				this.objectType_ = int(_arg_1.@type);
				this.props_ = ObjectLibrary.propsLibrary_[this.objectType_];
				hasShadow_ = (this.props_.shadowSize_ > 0);
				var _local_2:TextureData = ObjectLibrary.typeToTextureData_[this.objectType_];
				this.texture_ = _local_2.texture_;
				this.mask_ = _local_2.mask_;
				this.animatedChar_ = _local_2.animatedChar_;
				this.randomTextureData_ = _local_2.randomTextureData_;
				if (_local_2.effectProps_ != null)
				{
					this.effect_ = ParticleEffect.fromProps(_local_2.effectProps_, this);
				}
				if (this.texture_ != null)
				{
					this.sizeMult_ = (this.texture_.height / 8);
				}
				if (_arg_1.hasOwnProperty("Model"))
				{
					this.obj3D_ = Model3D.getObject3D(String(_arg_1.Model));
					this.object3d_ = Model3D.getStage3dObject3D(String(_arg_1.Model));
					if (this.texture_ != null)
					{
						this.object3d_.setBitMapData(this.texture_);
					}
				}
				var _local_3:AnimationsData = ObjectLibrary.typeToAnimationsData_[this.objectType_];
				if (_local_3 != null)
				{
					this.animations_ = new Animations(_local_3);
				}
				z_ = this.props_.z_;
				this.flying_ = this.props_.flying_;
				if (_arg_1.hasOwnProperty("MaxHitPoints"))
				{
					this.hp_ = (this.maxHP_ = int(_arg_1.MaxHitPoints));
				}
				if (_arg_1.hasOwnProperty("Defense"))
				{
					this.defense_ = int(_arg_1.Defense);
				}
				if (_arg_1.hasOwnProperty("SlotTypes"))
				{
					this.slotTypes_ = ConversionUtil.toIntVector(_arg_1.SlotTypes);
					this.equipment_ = new Vector.<int>(this.slotTypes_.length);
					_local_4 = 0;
					while (_local_4 < this.equipment_.length)
					{
						this.equipment_[_local_4] = -1;
						_local_4++;
					}
					this.lockedSlot = new Vector.<int>(this.slotTypes_.length);
				}
				if (_arg_1.hasOwnProperty("Tex1"))
				{
					this.tex1Id_ = int(_arg_1.Tex1);
				}
				if (_arg_1.hasOwnProperty("Tex2"))
				{
					this.tex2Id_ = int(_arg_1.Tex2);
				}
				if (_arg_1.hasOwnProperty("StunImmune"))
				{
					this.isStunImmuneVar_ = true;
				}
				if (_arg_1.hasOwnProperty("ParalyzeImmune"))
				{
					this.isParalyzeImmuneVar_ = true;
				}
				if (_arg_1.hasOwnProperty("DazedImmune"))
				{
					this.isDazedImmuneVar_ = true;
				}
				if (_arg_1.hasOwnProperty("StasisImmune"))
				{
					this.isStasisImmune_ = true;
				}
				if (_arg_1.hasOwnProperty("Invincible"))
				{
					this.isInvincibleXML = true;
				}
				this.props_.loadSounds();
			}

			public static function outputPositions(_arg_1:GameObject):String
			{
				return ((((((((((("X: " + int(_arg_1.x_)) + ", Y: ") + int(_arg_1.y_)) + ", pX: ") + int(_arg_1.posAtTick_.x)) + ", pY: ") + int(_arg_1.posAtTick_.y)) + ", tX: ") + int(_arg_1.tickPosition_.x)) + ", tY: ") + int(_arg_1.tickPosition_.y));
			}

			public function updateStatuses():void
			{
				isPaused = isPaused_();
				isStasis = isStasis_();
				isInvincible = isInvincible_();
				isInvulnerable = isInvulnerable_();
				isArmored = isArmored_();
				isArmorBroken = isArmorBroken_();
				isArmorBrokenImmune = isArmorBrokenImmune_();
				isStunImmune = isStunImmune_();
				isSlowedImmune = isSlowedImmune_();
				isShowPetEffectIcon = isShowPetEffectIcon_();
				isParalyzeImmune = isParalyzeImmune_();
				isDazedImmune = isDazedImmune_();
				isPetrified = isPetrified_();
				isPetrifiedImmune = isPetrifiedImmune_();
				isCursed = isCursed_();
				isCursedImmune = isCursedImmune_();
				if (this.props_.isEnemy_)
				{
					if (this.isArmored != this.previousArmored)
					{
						this.previousArmored = this.isArmored;
						this.calcHighestDps = true;
					}
					if (this.isArmored != this.previousArmored)
					{
						this.previousArmored = this.isArmored;
						this.calcHighestDps = true;
					}
					if (this.isArmorBroken != this.previousArmorBroken)
					{
						this.previousArmorBroken = this.isArmorBroken;
						this.calcHighestDps = true;
					}
					if (this.isCursed != this.previousCursed)
					{
						this.previousCursed = this.isCursed;
						this.calcHighestDps = true;
					}
					if (this.isPetrified != this.previousPetrified)
					{
						this.previousPetrified = this.isPetrified;
						this.calcHighestDps = true;
					}
					if (this.isExposed != this.previousExposed)
					{
						this.previousExposed = this.isExposed;
						this.calcHighestDps = true;
					}
				}
			}

			public static function damageWithDefense(_arg_1:int, _arg_2:int, _arg_3:Boolean, _arg_4:Vector.<uint>):int
			{
				if (((_arg_3) || (!((_arg_4[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.ARMORBROKEN_BIT) == 0))))
				{
					_arg_2 = 0;
				}
				else
				{
					if ((_arg_4[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.ARMORED_BIT) != 0)
					{
						_arg_2 = (_arg_2 * 2);
					}
				}
				if ((_arg_4[ConditionEffect.CE_SECOND_BATCH] & ConditionEffect.EXPOSED_BIT) != 0)
				{
					_arg_2 = (_arg_2 - 20);
				}
				var _local_6:int = int(((_arg_1 * 3) / 20));
				var _local_7:int = Math.max(_local_6, (_arg_1 - _arg_2));
				if ((_arg_4[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.INVULNERABLE_BIT) != 0)
				{
					_local_7 = 0;
				}
				if ((_arg_4[ConditionEffect.CE_SECOND_BATCH] & ConditionEffect.PETRIFIED_BIT) != 0)
				{
					_local_7 = (_local_7 * 0.9);
				}
				if ((_arg_4[ConditionEffect.CE_SECOND_BATCH] & ConditionEffect.CURSE_BIT) != 0)
				{
					_local_7 = (_local_7 * 1.2);
				}
				return (_local_7);
			}


			public function setObjectId(_arg_1:int):void
			{
				var _local_2:TextureData;
				objectId_ = _arg_1;
				if (this.randomTextureData_ != null)
				{
					_local_2 = this.randomTextureData_[(objectId_ % this.randomTextureData_.length)];
					this.texture_ = _local_2.texture_;
					this.mask_ = _local_2.mask_;
					this.animatedChar_ = _local_2.animatedChar_;
					if (this.object3d_ != null)
					{
						this.object3d_.setBitMapData(this.texture_);
					}
				}
			}

			public function setTexture(_arg_1:int):void
			{
				var _local_2:TextureData = ObjectLibrary.typeToTextureData_[_arg_1];
				this.texture_ = _local_2.texture_;
				this.mask_ = _local_2.mask_;
				this.animatedChar_ = _local_2.animatedChar_;
			}

			public function setAltTexture(_arg_1:int):void
			{
				var _local_3:TextureData;
				var _local_2:TextureData = ObjectLibrary.typeToTextureData_[this.objectType_];
				if (_arg_1 == 0)
				{
					_local_3 = _local_2;
				}
				else
				{
					_local_3 = _local_2.getAltTextureData(_arg_1);
					if (_local_3 == null)
					{
						return;
					}
				}
				this.texture_ = _local_3.texture_;
				this.mask_ = _local_3.mask_;
				this.animatedChar_ = _local_3.animatedChar_;
				if (this.effect_ != null)
				{
					map_.removeObj(this.effect_.objectId_);
					this.effect_ = null;
				}
				if (((!(Parameters.data_.noParticlesMaster)) && (!(_local_3.effectProps_ == null))))
				{
					this.effect_ = ParticleEffect.fromProps(_local_3.effectProps_, this);
					if (map_ != null)
					{
						map_.addObj(this.effect_, x_, y_);
					}
				}
			}

			public function setTex1(_arg_1:int):void
			{
				if (_arg_1 == this.tex1Id_)
				{
					return;
				}
				this.tex1Id_ = _arg_1;
				this.texturingCache_ = new Dictionary();
				this.portrait_ = null;
			}

			public function setTex2(_arg_1:int):void
			{
				if (_arg_1 == this.tex2Id_)
				{
					return;
				}
				this.tex2Id_ = _arg_1;
				this.texturingCache_ = new Dictionary();
				this.portrait_ = null;
			}

			public function playSound(_arg_1:int):void
			{
				SoundEffectLibrary.play(this.props_.sounds_[_arg_1]);
			}

			override public function dispose():void
			{
				super.dispose();
				this.texture_ = null;
				if (this.portrait_ != null)
				{
					this.portrait_.dispose();
					this.portrait_ = null;
				}
				this.clearTextureCache();
				this.texturingCache_ = null;
				if (this.obj3D_ != null)
				{
					this.obj3D_.dispose();
					this.obj3D_ = null;
				}
				if (this.object3d_ != null)
				{
					this.object3d_.dispose();
					this.object3d_ = null;
				}
				this.slotTypes_ = null;
				this.equipment_ = null;
				this.lockedSlot = null;
				if (this.nameBitmapData_ != null)
				{
					this.nameBitmapData_.dispose();
					this.nameBitmapData_ = null;
				}
				this.nameFill_ = null;
				this.namePath_ = null;
				this.bitmapFill_ = null;
				this.path_.commands = null;
				this.path_.data = null;
				this.vS_ = null;
				this.uvt_ = null;
				this.fillMatrix_ = null;
				this.icons_ = null;
				this.iconFills_ = null;
				this.iconPaths_ = null;
				this.shadowGradientFill_ = null;
				if (this.shadowPath_ != null)
				{
					this.shadowPath_.commands = null;
					this.shadowPath_.data = null;
					this.shadowPath_ = null;
				}
				this.footer_ = false;
				if (this.highestDpsWeaponIcon)
				{
					this.highestDpsWeaponIcon.dispose();
					this.highestDpsWeaponIcon = null;
				}
			}

			public function isQuiet_():Boolean
			{
				return (!((this.condition_[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.QUIET_BIT) == 0));
			}

			public function isWeak_():Boolean
			{
				return (!((this.condition_[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.WEAK_BIT) == 0));
			}

			public function isSlowed_():Boolean
			{
				return (!((this.condition_[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.SLOWED_BIT) == 0));
			}

			public function isSick_():Boolean
			{
				return (!((this.condition_[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.SICK_BIT) == 0));
			}

			public function isDazed_():Boolean
			{
				return (!((this.condition_[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.DAZED_BIT) == 0));
			}

			public function isStunned_():Boolean
			{
				return (!((this.condition_[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.STUNNED_BIT) == 0));
			}

			public function isBlind_():Boolean
			{
				if (!Parameters.ssmode && (1 << 8 & Parameters.data_.ccdebuffBitmask) > 0)
				{
					return (false);
				}
				return (!((this.condition_[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.BLIND_BIT) == 0));
			}

			public function isDrunk_():Boolean
			{
				if (!Parameters.ssmode && (1 << 10 & Parameters.data_.ccdebuffBitmask) > 0)
				{
					return (false);
				}
				return (!((this.condition_[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.DRUNK_BIT) == 0));
			}

			public function isBleeding_():Boolean
			{
				return (!((this.condition_[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.BLEEDING_BIT) == 0));
			}

			public function isConfused_():Boolean
			{
				if (!Parameters.ssmode && (1 << 11 & Parameters.data_.ccdebuffBitmask) > 0)
				{
					return (false);
				}
				return (!((this.condition_[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.CONFUSED_BIT) == 0));
			}

			public function isStunImmune_():Boolean
			{
				return ((!((this.condition_[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.STUN_IMMUNE_BIT) == 0)) || (this.isStunImmuneVar_));
			}

			public function isInvisible_():Boolean
			{
				return (!((this.condition_[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.INVISIBLE_BIT) == 0));
			}

			public function isParalyzed_():Boolean
			{
				return (!((this.condition_[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.PARALYZED_BIT) == 0));
			}

			public function isSpeedy_():Boolean
			{
				return (!((this.condition_[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.SPEEDY_BIT) == 0));
			}

			public function isNinjaSpeedy_():Boolean
			{
				return (!((this.condition_[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.NINJA_SPEEDY_BIT) == 0));
			}

			public function isHallucinating_():Boolean
			{
				if (!Parameters.ssmode && (1 << 9 & Parameters.data_.ccdebuffBitmask) > 0)
				{
					return (false);
				}
				return (!((this.condition_[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.HALLUCINATING_BIT) == 0));
			}

			public function isHealing_():Boolean
			{
				return (!((this.condition_[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.HEALING_BIT) == 0));
			}

			public function isDamaging_():Boolean
			{
				return (!((this.condition_[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.DAMAGING_BIT) == 0));
			}

			public function isBerserk_():Boolean
			{
				return (!((this.condition_[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.BERSERK_BIT) == 0));
			}

			public function isPaused_():Boolean
			{
				return (!((this.condition_[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.PAUSED_BIT) == 0));
			}

			public function isStasis_():Boolean
			{
				return (!((this.condition_[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.STASIS_BIT) == 0));
			}

			public function isStasisImmune():Boolean
			{
				return ((this.isStasisImmune_) || (!((this.condition_[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.STASIS_IMMUNE_BIT) == 0)));
			}

			public function isInvincible_():Boolean
			{
				return (this.isInvincibleXML || !((this.condition_[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.INVINCIBLE_BIT) == 0));
			}

			public function isInvulnerable_():Boolean
			{
				return (!((this.condition_[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.INVULNERABLE_BIT) == 0));
			}

			public function isArmored_():Boolean
			{
				return (!((this.condition_[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.ARMORED_BIT) == 0));
			}

			public function isArmorBroken_():Boolean
			{
				return (!((this.condition_[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.ARMORBROKEN_BIT) == 0));
			}

			public function isArmorBrokenImmune_():Boolean
			{
				return (!((this.condition_[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.ARMORBROKEN_IMMUNE_BIT) == 0));
			}

			public function isSlowedImmune_():Boolean
			{
				return (!((this.condition_[ConditionEffect.CE_SECOND_BATCH] & ConditionEffect.SLOWED_IMMUNE_BIT) == 0));
			}

			public function isUnstable_():Boolean
			{
				if (!Parameters.ssmode && (1 << 30 & Parameters.data_.ccdebuffBitmask) > 0)
				{
					return (false);
				}
				return (!((this.condition_[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.UNSTABLE_BIT) == 0));
			}

			public function isShowPetEffectIcon_():Boolean
			{
				return (!((this.condition_[ConditionEffect.CE_SECOND_BATCH] & ConditionEffect.PET_EFFECT_ICON) == 0));
			}

			public function isDarkness_():Boolean
			{
				if (!Parameters.ssmode && (1 << 31 & Parameters.data_.ccdebuffBitmask) > 0)
				{
					return (false);
				}
				return (!((this.condition_[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.DARKNESS_BIT) == 0));
			}

			public function isParalyzeImmune_():Boolean
			{
				return ((this.isParalyzeImmuneVar_) || (!((this.condition_[ConditionEffect.CE_SECOND_BATCH] & ConditionEffect.PARALYZED_IMMUNE_BIT) == 0)));
			}

			public function isDazedImmune_():Boolean
			{
				return ((this.isDazedImmuneVar_) || (!((this.condition_[ConditionEffect.CE_SECOND_BATCH] & ConditionEffect.DAZED_IMMUNE_BIT) == 0)));
			}

			public function isPetrified_():Boolean
			{
				return (!((this.condition_[ConditionEffect.CE_SECOND_BATCH] & ConditionEffect.PETRIFIED_BIT) == 0));
			}

			public function isPetrifiedImmune_():Boolean
			{
				return (!((this.condition_[ConditionEffect.CE_SECOND_BATCH] & ConditionEffect.PETRIFIED_IMMUNE_BIT) == 0));
			}

			public function isCursed_():Boolean
			{
				return (!((this.condition_[ConditionEffect.CE_SECOND_BATCH] & ConditionEffect.CURSE_BIT) == 0));
			}

			public function isCursedImmune_():Boolean
			{
				return (!((this.condition_[ConditionEffect.CE_SECOND_BATCH] & ConditionEffect.CURSE_IMMUNE_BIT) == 0));
			}

			public function isSilenced_():Boolean
			{
				return (!((this.condition_[ConditionEffect.CE_SECOND_BATCH] & ConditionEffect.SILENCED_BIT) == 0));
			}

			public function isExposed_():Boolean
			{
				return (!((this.condition_[ConditionEffect.CE_SECOND_BATCH] & ConditionEffect.EXPOSED_BIT) == 0));
			}

			public function isSafe(_arg_1:int = 20):Boolean
			{
				var _local_2:GameObject;
				var _local_3:int;
				var _local_4:int;
				for each (_local_2 in map_.goDict_)
				{
					if (((_local_2 is Character) && (_local_2.props_.isEnemy_)))
					{
						_local_3 = ((x_ > _local_2.x_) ? (x_ - _local_2.x_) : (_local_2.x_ - x_));
						_local_4 = ((y_ > _local_2.y_) ? (y_ - _local_2.y_) : (_local_2.y_ - y_));
						if (((_local_3 < _arg_1) && (_local_4 < _arg_1)))
						{
							return (false);
						}
					}
				}
				return (true);
			}

			public function getName():String
			{
				return (((this.name_ == null) || (this.name_ == "")) ? ObjectLibrary.typeToDisplayId_[this.objectType_] : this.name_);
			}

			public function getColor():uint
			{
				if (this.props_.color_ != -1)
				{
					return (this.props_.color_);
				}
				return (BitmapUtil.mostCommonColor(this.texture_));
			}

			public function getBulletId():uint
			{
				var _local_1:uint = this.nextBulletId_;
				this.nextBulletId_ = ((this.nextBulletId_ + 1) % 128);
				return (_local_1);
			}

			public function distTo(_arg_1:WorldPosData):Number
			{
				var _local_2:Number = (_arg_1.x_ - x_);
				var _local_3:Number = (_arg_1.y_ - y_);
				return (Math.sqrt(((_local_2 * _local_2) + (_local_3 * _local_3))));
			}

			public function toggleShockEffect(_arg_1:Boolean):void
			{
				if (_arg_1)
				{
					this.isShocked = true;
				}
				else
				{
					this.isShocked = false;
					this.isShockedTransformSet = false;
				}
			}

			public function toggleChargingEffect(_arg_1:Boolean):void
			{
				if (_arg_1)
				{
					this.isCharging = true;
				}
				else
				{
					this.isCharging = false;
					this.isChargingTransformSet = false;
				}
			}

			override public function addTo(_arg_1:Map, _arg_2:Number, _arg_3:Number):Boolean
			{
				map_ = _arg_1;
				this.posAtTick_.x = (this.tickPosition_.x = _arg_2);
				this.posAtTick_.y = (this.tickPosition_.y = _arg_3);
				if (!this.moveTo(_arg_2, _arg_3))
				{
					map_ = null;
					return (false);
				}
				if (this.effect_ != null)
				{
					map_.addObj(this.effect_, _arg_2, _arg_3);
				}
				return (true);
			}

			override public function removeFromMap():void
			{
				if (this.props_.static_ && square_ != null)
				{
					if (square_.obj_ == this)
					{
						square_.obj_ = null;
					}
					square_ = null;
				}
				if (this.effect_ != null)
				{
					map_.removeObj(this.effect_.objectId_);
				}
				super.removeFromMap();
				this.dispose();
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
				if (this.props_.static_)
				{
					if (square_ != null)
					{
						square_.obj_ = null;
					}
					_local_3.obj_ = this;
				}
				square_ = _local_3;
				if (this.obj3D_ != null)
				{
					this.obj3D_.setPosition(x_, y_, 0, this.props_.rotation_);
				}
				if (this.object3d_ != null)
				{
					this.object3d_.setPosition(x_, y_, 0, this.props_.rotation_);
				}
				return (true);
			}

			public function footer(_arg_1:String):void
			{
				var _local_2:CharacterStatusText = new CharacterStatusText(this, 0xFFFFFF, -1);
				_local_2.setStringBuilder(new StaticStringBuilder(_arg_1));
				map_.mapOverlay_.addStatusText(_local_2);
			}

			public function mobInfo(_arg_1:String):void
			{
				var _local_2:CharacterStatusText = new CharacterStatusText(this, 0xFFFFFF, int.MAX_VALUE);
				_local_2.setStringBuilder(new StaticStringBuilder(_arg_1));
				map_.mapOverlay_.addStatusText(_local_2);
			}

			override public function update(_arg_1:int, _arg_2:int):Boolean
			{
				if (!Parameters.ssmode && Parameters.data_.showMobInfo)
				{
					if (!this.mobInfoShown && this.props_.isEnemy_)
					{
						this.mobInfo(("" + this.objectType_));
						this.mobInfoShown = true;
					}
				}
				else
				{
					this.mobInfoShown = false;
				}
				var _local_4:int;
				var _local_5:Number;
				var _local_6:Number;
				var _local_3:Boolean;
				if (this.moveVec_.x != 0 && this.moveVec_.y != 0)
				{
					if (this.myLastTickId_ < map_.gs_.gsc_.lastTickId_)
					{
						this.moveVec_.x = 0;
						this.moveVec_.y = 0;
						this.moveTo(this.tickPosition_.x, this.tickPosition_.y);
					}
					else
					{
						_local_4 = (_arg_1 - this.lastTickUpdateTime_);
						_local_5 = (this.posAtTick_.x + (_local_4 * this.moveVec_.x));
						_local_6 = (this.posAtTick_.y + (_local_4 * this.moveVec_.y));
						this.moveTo(_local_5, _local_6);
						_local_3 = true;
					}
				}
				if (this.props_.whileMoving_ != null)
				{
					if (!_local_3)
					{
						z_ = this.props_.z_;
						this.flying_ = this.props_.flying_;
					}
					else
					{
						z_ = this.props_.whileMoving_.z_;
						this.flying_ = this.props_.whileMoving_.flying_;
					}
				}
				return (true);
			}

			public function onGoto(_arg_1:Number, _arg_2:Number, _arg_3:int):void
			{
				this.moveTo(_arg_1, _arg_2);
				this.lastTickUpdateTime_ = _arg_3;
				this.tickPosition_.x = _arg_1;
				this.tickPosition_.y = _arg_2;
				this.posAtTick_.x = _arg_1;
				this.posAtTick_.y = _arg_2;
				this.moveVec_.x = 0;
				this.moveVec_.y = 0;
			}

			public function onTickPos(_arg_1:Number, _arg_2:Number, _arg_3:int, _arg_4:int):void
			{
				if (this.myLastTickId_ < map_.gs_.gsc_.lastTickId_)
				{
					this.moveTo(this.tickPosition_.x, this.tickPosition_.y);
				}
				this.lastTickUpdateTime_ = map_.gs_.lastUpdate_;
				this.tickPosition_.x = _arg_1;
				this.tickPosition_.y = _arg_2;
				this.posAtTick_.x = x_;
				this.posAtTick_.y = y_;
				this.moveVec_.x = ((this.tickPosition_.x - this.posAtTick_.x) / _arg_3);
				this.moveVec_.y = ((this.tickPosition_.y - this.posAtTick_.y) / _arg_3);
				this.myLastTickId_ = _arg_4;
				_arg_1 = Math.atan2(this.moveVec_.y, this.moveVec_.x);
				_arg_2 = _arg_1;
				this.jittery = ((_arg_2 > (_arg_1 + (Math.PI / 4))) || (_arg_2 < (_arg_1 - (Math.PI / 4))));
			}

			public function damage(_arg_1:Boolean, _arg_2:int, _arg_3:Vector.<uint>, _arg_4:Boolean, _arg_5:Projectile, _arg_6:Boolean = false):void
			{
				var _local_8:int;
				var _local_9:uint;
				var _local_10:ConditionEffect;
				var _local_11:CharacterStatusText;
				var _local_12:PetsModel;
				var _local_13:PetVO;
				var _local_14:String;
				var _local_15:Vector.<uint>;
				var _local_16:Boolean;
				var _local_7:Boolean;
				if (_arg_4)
				{
					this.dead_ = true;
				}
				else
				{
					if (_arg_3 != null)
					{
						_arg_4 = (Parameters.ssmode || !Parameters.data_.ignoreStatusText);
						_local_8 = 0;
						for each (_local_9 in _arg_3)
						{
							_local_10 = null;
							if ((((!(_arg_5 == null)) && (_arg_5.projProps_.isPetEffect_)) && (_arg_5.projProps_.isPetEffect_[_local_9])))
							{
								_local_12 = StaticInjectorContext.getInjector().getInstance(PetsModel);
								_local_13 = _local_12.getActivePet();
								if (_local_13 != null)
								{
									_local_10 = ConditionEffect.effects_[_local_9];
									if (_arg_4)
									{
										this.showConditionEffectPet(_local_8, _local_10.name_);
									}
									_local_8 = (_local_8 + 500);
								}
							}
							else
							{
								switch (_local_9)
								{
									case ConditionEffect.NOTHING:
										break;
									case ConditionEffect.WEAK:
									case ConditionEffect.SICK:
									case ConditionEffect.BLIND:
									case ConditionEffect.HALLUCINATING:
									case ConditionEffect.DRUNK:
									case ConditionEffect.CONFUSED:
									case ConditionEffect.STUN_IMMUNE:
									case ConditionEffect.INVISIBLE:
									case ConditionEffect.SPEEDY:
									case ConditionEffect.BLEEDING:
									case ConditionEffect.STASIS_IMMUNE:
									case ConditionEffect.NINJA_SPEEDY:
									case ConditionEffect.UNSTABLE:
									case ConditionEffect.DARKNESS:
									case ConditionEffect.PETRIFIED_IMMUNE:
									case ConditionEffect.SILENCED:
										_local_10 = ConditionEffect.effects_[_local_9];
										break;
									case ConditionEffect.QUIET:
										if (map_.player_ == this)
										{
											map_.player_.mp_ = 0;
										}
										_local_10 = ConditionEffect.effects_[_local_9];
										break;
									case ConditionEffect.STASIS:
										if (this.isStasisImmune_)
										{
											if (_arg_4)
											{
												_local_11 = new CharacterStatusText(this, 0xFF0000, 3000);
												_local_11.setStringBuilder(new LineBuilder().setParams(TextKey.GAMEOBJECT_IMMUNE));
												map_.mapOverlay_.addStatusText(_local_11);
											}
										}
										else
										{
											_local_10 = ConditionEffect.effects_[_local_9];
										}
										break;
									case ConditionEffect.SLOWED:
										if (this.isSlowedImmune)
										{
											if (_arg_4)
											{
												_local_11 = new CharacterStatusText(this, 0xFF0000, 3000);
												_local_11.setStringBuilder(new LineBuilder().setParams(TextKey.GAMEOBJECT_IMMUNE));
												map_.mapOverlay_.addStatusText(_local_11);
											}
										}
										else
										{
											_local_10 = ConditionEffect.effects_[_local_9];
										}
										break;
									case ConditionEffect.ARMORBROKEN:
										if (this.isArmorBrokenImmune)
										{
											if (_arg_4)
											{
												_local_11 = new CharacterStatusText(this, 0xFF0000, 3000);
												_local_11.setStringBuilder(new LineBuilder().setParams(TextKey.GAMEOBJECT_IMMUNE));
												map_.mapOverlay_.addStatusText(_local_11);
											}
										}
										else
										{
											_local_10 = ConditionEffect.effects_[_local_9];
										}
										break;
									case ConditionEffect.STUNNED:
										if (this.isStunImmune)
										{
											if (_arg_4)
											{
												_local_11 = new CharacterStatusText(this, 0xFF0000, 3000);
												_local_11.setStringBuilder(new LineBuilder().setParams(TextKey.GAMEOBJECT_IMMUNE));
												map_.mapOverlay_.addStatusText(_local_11);
											}
										}
										else
										{
											_local_10 = ConditionEffect.effects_[_local_9];
											this.isStunned = true;
										}
										break;
									case ConditionEffect.DAZED:
										if (this.isDazedImmune)
										{
											if (_arg_4)
											{
												_local_11 = new CharacterStatusText(this, 0xFF0000, 3000);
												_local_11.setStringBuilder(new LineBuilder().setParams(TextKey.GAMEOBJECT_IMMUNE));
												map_.mapOverlay_.addStatusText(_local_11);
											}
										}
										else
										{
											_local_10 = ConditionEffect.effects_[_local_9];
											this.isDazed = true;
										}
										break;
									case ConditionEffect.PARALYZED:
										if (this.isParalyzeImmune)
										{
											if (_arg_4)
											{
												_local_11 = new CharacterStatusText(this, 0xFF0000, 3000);
												_local_11.setStringBuilder(new LineBuilder().setParams(TextKey.GAMEOBJECT_IMMUNE));
												map_.mapOverlay_.addStatusText(_local_11);
											}
										}
										else
										{
											_local_10 = ConditionEffect.effects_[_local_9];
											this.isParalyzed = true;
										}
										break;
									case ConditionEffect.PETRIFIED:
										if (this.isPetrifiedImmune)
										{
											if (_arg_4)
											{
												_local_11 = new CharacterStatusText(this, 0xFF0000, 3000);
												_local_11.setStringBuilder(new LineBuilder().setParams(TextKey.GAMEOBJECT_IMMUNE));
												map_.mapOverlay_.addStatusText(_local_11);
											}
										}
										else
										{
											_local_10 = ConditionEffect.effects_[_local_9];
											this.isPetrified = true;
										}
										break;
									case ConditionEffect.CURSE:
										if (this.isCursedImmune)
										{
											if (_arg_4)
											{
												_local_11 = new CharacterStatusText(this, 0xFF0000, 3000);
												_local_11.setStringBuilder(new LineBuilder().setParams(TextKey.GAMEOBJECT_IMMUNE));
												map_.mapOverlay_.addStatusText(_local_11);
											}
										}
										else
										{
											_local_10 = ConditionEffect.effects_[_local_9];
										}
										break;
									case ConditionEffect.GROUND_DAMAGE:
										_local_7 = true;
										break;
								}
								if (_local_10 != null)
								{
									if (_local_9 < ConditionEffect.NEW_CON_THRESHOLD)
									{
										if ((this.condition_[ConditionEffect.CE_FIRST_BATCH] | _local_10.bit_) == this.condition_[ConditionEffect.CE_FIRST_BATCH])
										{
											continue;
										}
										this.condition_[ConditionEffect.CE_FIRST_BATCH] = (this.condition_[ConditionEffect.CE_FIRST_BATCH] | _local_10.bit_);
									}
									else
									{
										if ((this.condition_[ConditionEffect.CE_SECOND_BATCH] | _local_10.bit_) == this.condition_[ConditionEffect.CE_SECOND_BATCH])
										{
											continue;
										}
										this.condition_[ConditionEffect.CE_SECOND_BATCH] = (this.condition_[ConditionEffect.CE_SECOND_BATCH] | _local_10.bit_);
									}
									_local_14 = _local_10.localizationKey_;
									if (!Parameters.ssmode && !Parameters.data_.ignoreStatusText)
									{
										this.showConditionEffect(_local_8, _local_14);
									}
									_local_8 = (_local_8 + 500);
								}
							}
						}
					}
				}
				if (!(this.props_.isEnemy_ && Parameters.data_.disableEnemyParticles) && (!(!this.props_.isEnemy_) && Parameters.data_.disablePlayersHitParticles) && this.texture_ != null)
				{
					if (!Parameters.data_.liteParticle || !Parameters.ssmode)
					{
						_local_15 = BloodComposition.getBloodComposition(this.objectType_, this.texture_, this.props_.bloodProb_, this.props_.bloodColor_);
						if (this.dead_)
						{
							map_.addObj(new ExplosionEffect(_local_15, this.size_, 30), x_, y_);
						}
						else
						{
							if (_arg_5)
							{
								map_.addObj(new HitEffect(_local_15, this.size_, 10, _arg_5.angle_, _arg_5.projProps_.speed_), x_, y_);
							}
							else
							{
								map_.addObj(new ExplosionEffect(_local_15, this.size_, 10), x_, y_);
							}
						}
					}
				}
				if (!_arg_1 && (Parameters.data_.noEnemyDamage && this.props_.isEnemy_ || Parameters.data_.noAllyDamage && this.props_.isPlayer_))
				{
					return;
				}
				if (_arg_2 > 0 && !this.dead_ && this.map_ != null)
				{
					if (Parameters.data_.autoDecrementHP && this != this.map_.player_)
					{
						this.hp_ = (this.hp_ - _arg_2);
					}
					_local_16 = (this.isArmorBroken || _arg_5 != null && _arg_5.projProps_.armorPiercing_ || _local_7 || _arg_6);
					this.showDamageText(_arg_2, _local_16);
				}
			}

			public function showConditionEffect(_arg_1:int, _arg_2:String):void
			{
				if (this.texture_ != null)
				{
					var _local_3:CharacterStatusText = new CharacterStatusText(this, 0xFF0000, 3000, _arg_1);
					_local_3.setStringBuilder(new LineBuilder().setParams(_arg_2));
					map_.mapOverlay_.addStatusText(_local_3);
				}
			}

			public function showConditionEffectPet(_arg_1:int, _arg_2:String):void
			{
				if (this.texture_ != null)
				{
					var _local_3:CharacterStatusText = new CharacterStatusText(this, 0xFF0000, 3000, _arg_1);
					_local_3.setStringBuilder(new StaticStringBuilder(("Pet " + _arg_2)));
					map_.mapOverlay_.addStatusText(_local_3);
				}
			}

			public function showDamageText(_arg_1:int, _arg_2:Boolean):void
			{
				takeDmgNotif(_arg_1, this, _arg_2);
			}

			public static function takeDmgNotif(_arg_1:int, _arg_2:GameObject, _arg_3:Boolean = false):void
			{
				if (_arg_2.texture_ != null)
				{
					var _local_4:int;
					var _local_5:Boolean = (Parameters.data_.showDamageAndHP == "base" || Parameters.data_.showDamageAndHP == "total" || Parameters.data_.showDamageAndHP == "all");
					var _local_6:Boolean = ((Parameters.data_.showDamageAndHP == "total" || Parameters.data_.showDamageAndHP == "all") && !Parameters.ssmode);
					var _local_7:int = (_arg_2.hp_ - _arg_1);
					_local_7 = ((_local_7 < 0) ? 0 : _local_7);
					if (_arg_3)
					{
						_local_4 = 0x9000FF;
					}
					else
					{
						if (Parameters.data_.showDamageAndHPColorized && !Parameters.ssmode)
						{
							_local_4 = int(Character.green2red((_arg_2.hp_ / _arg_2.maxHP_) * 100));
						}
						else
						{
							_local_4 = 0xFF0000;
						}
					}
					var _local_8:String = ((_local_5 ? "-" + _arg_1 + (_local_6 ? " [" : "") : "") + ((_local_6) ? ((_local_7).toString() + ((_local_5) ? "]" : "")) : ""));
					var _local_9:CharacterStatusText = new CharacterStatusText(_arg_2, _local_4, 1000);
					_local_9.setStringBuilder(new StaticStringBuilder(_local_8));
					_arg_2.map_.mapOverlay_.addStatusText(_local_9);
				}
			}

			protected function makeNameBitmapData():BitmapData
			{
				var _local_1:StringBuilder = new StaticStringBuilder(this.name_);
				var _local_2:BitmapTextFactory = StaticInjectorContext.getInjector().getInstance(BitmapTextFactory);
				return (_local_2.make(_local_1, 16, 0xFFFFFF, true, IDENTITY_MATRIX, true));
			}

			public function drawName(_arg_1:Vector.<IGraphicsData>, _arg_2:Camera, _arg_3:Boolean):void
			{
				if (!Parameters.ssmode && Parameters.lowCPUMode && this.objectType_ != 1810)
				{
					return;
				}
				if (this.nameBitmapData_ == null)
				{
					this.nameBitmapData_ = this.makeNameBitmapData();
					this.nameFill_ = new GraphicsBitmapFill(null, new Matrix(), false, false);
					this.namePath_ = new GraphicsPath(GraphicsUtil.QUAD_COMMANDS, new Vector.<Number>());
				}
				var _local_3:int = int(((this.nameBitmapData_.width / 2) + 1));
				var _local_4:int = (_arg_3 ? 42 : 30);
				var _local_5:Vector.<Number> = this.namePath_.data;
				_local_5.length = 0;
				if (_arg_3)
				{
					_local_5.push((posS_[0] - _local_3), (posS_[1] + 12), (posS_[0] + _local_3), (posS_[1] + 12), (posS_[0] + _local_3), (posS_[1] + _local_4), (posS_[0] - _local_3), (posS_[1] + _local_4));
				}
				else
				{
					_local_5.push((posS_[0] - _local_3), posS_[1], (posS_[0] + _local_3), posS_[1], (posS_[0] + _local_3), (posS_[1] + _local_4), (posS_[0] - _local_3), (posS_[1] + _local_4));
				}
				this.nameFill_.bitmapData = this.nameBitmapData_;
				var _local_6:Matrix = this.nameFill_.matrix;
				_local_6.identity();
				_local_6.translate(_local_5[0], _local_5[1]);
				_arg_1.push(this.nameFill_);
				_arg_1.push(this.namePath_);
				_arg_1.push(GraphicsUtil.END_FILL);
			}

			protected function getHallucinatingTexture():BitmapData
			{
				if (this.hallucinatingTexture_ == null)
				{
					this.hallucinatingTexture_ = AssetLibrary.getImageFromSet("lofiChar8x8", int((Math.random() * 239)));
				}
				return (this.hallucinatingTexture_);
			}

			protected function getTexture(_arg_1:Camera, _arg_2:int):BitmapData
			{
				var _local_6:Pet;
				var _local_7:Number;
				var _local_8:int;
				var _local_9:MaskedImage;
				var _local_10:int;
				var _local_11:BitmapData;
				var _local_12:int;
				var _local_13:BitmapData;
				if ((this is Pet))
				{
					_local_6 = Pet(this);
					if (this.condition_[ConditionEffect.CE_FIRST_BATCH] != 0 && !this.isPaused)
					{
						if (_local_6.skinId != 32912)
						{
							_local_6.setSkin(32912);
						}
					}
					else
					{
						if (!_local_6.isDefaultAnimatedChar)
						{
							_local_6.setDefaultSkin();
						}
					}
				}
				var _local_3:BitmapData = this.texture_;
				var _local_4:int = this.size_;
				var _local_5:BitmapData;
				if (this is Container && !Parameters.ssmode && Parameters.data_.bigLootBags && (this as Container).drawMeBig_)
				{
					_local_4 = 200;
				}
				if (this.animatedChar_ != null)
				{
					_local_7 = 0;
					_local_8 = AnimatedChar.STAND;
					if (_arg_2 < (this.attackStart_ + ATTACK_PERIOD))
					{
						if (!this.props_.dontFaceAttacks_)
						{
							this.facing_ = this.attackAngle_;
						}
						_local_7 = (((_arg_2 - this.attackStart_) % ATTACK_PERIOD) / ATTACK_PERIOD);
						_local_8 = AnimatedChar.ATTACK;
					}
					else
					{
						if (((!(this.moveVec_.x == 0)) || (!(this.moveVec_.y == 0))))
						{
							_local_10 = int((0.5 / this.moveVec_.length));
							_local_10 = (_local_10 + (400 - (_local_10 % 400)));
							if (((((this.moveVec_.x > ZERO_LIMIT) || (this.moveVec_.x < NEGATIVE_ZERO_LIMIT)) || (this.moveVec_.y > ZERO_LIMIT)) || (this.moveVec_.y < NEGATIVE_ZERO_LIMIT)))
							{
								if (!this.props_.dontFaceMovement_)
								{
									this.facing_ = Math.atan2(this.moveVec_.y, this.moveVec_.x);
								}
								_local_8 = AnimatedChar.WALK;
							}
							else
							{
								_local_8 = AnimatedChar.STAND;
							}
							_local_7 = ((_arg_2 % _local_10) / _local_10);
						}
					}
					_local_9 = this.animatedChar_.imageFromFacing(this.facing_, _arg_1, _local_8, _local_7);
					_local_3 = _local_9.image_;
					_local_5 = _local_9.mask_;
				}
				else
				{
					if (this.animations_ != null)
					{
						_local_11 = this.animations_.getTexture(_arg_2);
						if (_local_11 != null)
						{
							_local_3 = _local_11;
						}
					}
				}
				if (((this.props_.drawOnGround_) || (!(this.obj3D_ == null))))
				{
					return (_local_3);
				}
				if (_arg_1.isHallucinating_)
				{
					_local_12 = ((_local_3 == null) ? 8 : _local_3.width);
					_local_3 = this.getHallucinatingTexture();
					_local_5 = null;
					_local_4 = int((this.size_ * Math.min(1.5, (_local_12 / _local_3.width))));
				}
				if (!(this is Pet))
				{
					if (this.isStasis || this.isPetrified)
					{
						_local_3 = CachingColorTransformer.filterBitmapData(_local_3, PAUSED_FILTER);
					}
				}
				if (((this.tex1Id_ == 0) && (this.tex2Id_ == 0)))
				{
					if (this.isCursed && Parameters.data_.curseIndication)
					{
						_local_3 = TextureRedrawer.redraw(_local_3, _local_4, false, 0xFF0000);
					}
					else
					{
						_local_3 = TextureRedrawer.redraw(_local_3, _local_4, false, 0);
					}
				}
				else
				{
					_local_13 = null;
					if (this.texturingCache_ == null)
					{
						this.texturingCache_ = new Dictionary();
					}
					else
					{
						_local_13 = this.texturingCache_[_local_3];
					}
					if (_local_13 == null)
					{
						_local_13 = TextureRedrawer.resize(_local_3, _local_5, _local_4, false, this.tex1Id_, this.tex2Id_);
						_local_13 = GlowRedrawer.outlineGlow(_local_13, 0);
						this.texturingCache_[_local_3] = _local_13;
					}
					_local_3 = _local_13;
				}
				if (!Parameters.ssmode && _local_6 != null && !this.myPet && Parameters.data_.alphaOnOthers && !map_.isPetYard)
				{
					_local_3 = CachingColorTransformer.alphaBitmapData(_local_3, Parameters.data_.alphaMan);
				}
				return (_local_3);
			}

			public function useAltTexture(_arg_1:String, _arg_2:int):void
			{
				this.texture_ = AssetLibrary.getImageFromSet(_arg_1, _arg_2);
				this.sizeMult_ = (this.texture_.height / 8);
			}

			public function getPortrait():BitmapData
			{
				var _local_1:BitmapData;
				var _local_2:int;
				if (this.portrait_ == null)
				{
					_local_1 = ((this.props_.portrait_ != null) ? this.props_.portrait_.getTexture() : this.texture_);
					_local_2 = int(((4 / _local_1.width) * 100));
					this.portrait_ = TextureRedrawer.resize(_local_1, this.mask_, _local_2, true, this.tex1Id_, this.tex2Id_);
					this.portrait_ = GlowRedrawer.outlineGlow(this.portrait_, 0);
				}
				return (this.portrait_);
			}

			public function setAttack(_arg_1:int, _arg_2:Number):void
			{
				this.attackAngle_ = _arg_2;
				this.attackStart_ = getTimer();
			}

			override public function draw3d(_arg_1:Vector.<Object3DStage3D>):void
			{
				if (this.object3d_ != null)
				{
					_arg_1.push(this.object3d_);
				}
			}

			protected function drawHpBar(_arg_1:Vector.<IGraphicsData>, _arg_2:int = 6):void
			{
				var _local_6:Number;
				var _local_7:Number;
				if (this.hpbarPath_ == null)
				{
					this.hpbarBackFill_ = new GraphicsSolidFill();
					this.hpbarBackPath_ = new GraphicsPath(GraphicsUtil.QUAD_COMMANDS, new Vector.<Number>());
					this.hpbarFill_ = new GraphicsSolidFill();
					this.hpbarPath_ = new GraphicsPath(GraphicsUtil.QUAD_COMMANDS, new Vector.<Number>());
				}
				if (this.hp_ > this.maxHP_)
				{
					this.maxHP_ = this.hp_;
				}
				this.hpbarBackFill_.color = 0x111111;
				var _local_3:int = 20;
				var _local_4:int = 5;
				this.hpbarBackPath_.data.length = 0;
				var _local_5:Number = 1.2;
				(this.hpbarBackPath_.data as Vector.<Number>).push(((posS_[0] - _local_3) - _local_5), ((posS_[1] + _arg_2) - _local_5), ((posS_[0] + _local_3) + _local_5), ((posS_[1] + _arg_2) - _local_5), ((posS_[0] + _local_3) + _local_5), (((posS_[1] + _arg_2) + _local_4) + _local_5), ((posS_[0] - _local_3) - _local_5), (((posS_[1] + _arg_2) + _local_4) + _local_5));
				_arg_1.push(this.hpbarBackFill_);
				_arg_1.push(this.hpbarBackPath_);
				_arg_1.push(GraphicsUtil.END_FILL);
				var hp:int = (this == this.map_.player_) ? this.map_.player_.clientHp : this.hp_;
				if (hp > 0)
				{
					_local_6 = (hp / this.maxHP_);
					_local_7 = ((_local_6 * 2) * _local_3);
					this.hpbarPath_.data.length = 0;
					(this.hpbarPath_.data as Vector.<Number>).push((posS_[0] - _local_3), (posS_[1] + _arg_2), ((posS_[0] - _local_3) + _local_7), (posS_[1] + _arg_2), ((posS_[0] - _local_3) + _local_7), ((posS_[1] + _arg_2) + _local_4), (posS_[0] - _local_3), ((posS_[1] + _arg_2) + _local_4));
					this.hpbarFill_.color = ((_local_6 < 0.5) ? ((_local_6 < 0.2) ? 14684176 : 16744464) : 0x10FF00);
					_arg_1.push(this.hpbarFill_);
					_arg_1.push(this.hpbarPath_);
					_arg_1.push(GraphicsUtil.END_FILL);
				}
				GraphicsFillExtra.setSoftwareDrawSolid(this.hpbarFill_, true);
				GraphicsFillExtra.setSoftwareDrawSolid(this.hpbarBackFill_, true);
			}

			override public function draw(_arg_1:Vector.<IGraphicsData>, _arg_2:Camera, _arg_3:int):void
			{
				var _local_9:BitmapData;
				var _local_10:uint;
				var _local_11:uint;
				var _local_12:int;
				var _local_4:BitmapData = this.getTexture(_arg_2, _arg_3);
				if (this.props_.drawOnGround_)
				{
					if (!Parameters.ssmode && Parameters.lowCPUMode)
					{
						return;
					}
					if (square_.faces_.length == 0)
					{
						return;
					}
					this.path_.data = square_.faces_[0].face_.vout_;
					this.bitmapFill_.bitmapData = _local_4;
					square_.baseTexMatrix_.calculateTextureMatrix(this.path_.data);
					this.bitmapFill_.matrix = square_.baseTexMatrix_.tToS_;
					_arg_1.push(this.bitmapFill_);
					_arg_1.push(this.path_);
					_arg_1.push(GraphicsUtil.END_FILL);
					return;
				}
				var _local_5:Boolean = (((((this.props_) && ((this.props_.isEnemy_) || (this.props_.isPlayer_))) && (!(this.isInvincible))) && ((this.props_.isPlayer_) || (!(this.isInvulnerable)))) && (!(this.props_.noMiniMap_)));
				if (!Parameters.ssmode)
				{
					if (this.props_ && !this.isInvincible)
					{
						if (this.props_.isEnemy_ && !this.props_.noMiniMap_)
						{
							_local_5 = true;
						}
						else
						{
							if (this.props_.isPlayer_)
							{
								if (this == this.map_.player_)
								{
									_local_5 = true;
								}
								else
								{
									if (Parameters.data_.showHPBarOnAlly)
									{
										_local_5 = true;
									}
								}
							}
						}
					}
				}
				if (this.obj3D_ != null)
				{
					if ((((_local_5) && (this.bHPBarParamCheck())) && (this.props_.healthBar_)))
					{
						this.drawHpBar(_arg_1, this.props_.healthBar_);
					}
					if (!Parameters.isGpuRender())
					{
						this.obj3D_.draw(_arg_1, _arg_2, this.props_.color_, _local_4);
						return;
					}
					if (Parameters.isGpuRender())
					{
						_arg_1.push(null);
						return;
					}
				}
				var _local_6:int = _local_4.width;
				var _local_7:int = _local_4.height;
				var _local_8:int = (square_.sink_ + this.sinkLevel_);
				if (((_local_8 > 0) && ((this.flying_) || ((!(square_.obj_ == null)) && (square_.obj_.props_.protectFromSink_)))))
				{
					_local_8 = 0;
				}
				if (Parameters.isGpuRender())
				{
					if (_local_8 != 0)
					{
						GraphicsFillExtra.setSinkLevel(this.bitmapFill_, Math.max((((_local_8 / _local_7) * 1.65) - 0.02), 0));
						_local_8 = (-(_local_8) + 0.02);
					}
					else
					{
						if (((_local_8 == 0) && (!(GraphicsFillExtra.getSinkLevel(this.bitmapFill_) == 0))))
						{
							GraphicsFillExtra.clearSink(this.bitmapFill_);
						}
					}
				}
				this.vS_.length = 0;
				this.vS_.push((posS_[3] - (_local_6 / 2)), ((posS_[4] - _local_7) + _local_8), (posS_[3] + (_local_6 / 2)), ((posS_[4] - _local_7) + _local_8), (posS_[3] + (_local_6 / 2)), posS_[4], (posS_[3] - (_local_6 / 2)), posS_[4]);
				this.path_.data = this.vS_;
				if (this.flash_ != null)
				{
					if (!this.flash_.doneAt(_arg_3))
					{
						if (Parameters.isGpuRender())
						{
							this.flash_.applyGPUTextureColorTransform(_local_4, _arg_3);
						}
						else
						{
							_local_4 = this.flash_.apply(_local_4, _arg_3);
						}
					}
					else
					{
						this.flash_ = null;
					}
				}
				if (((this.isShocked) && (!(this.isShockedTransformSet))))
				{
					if (Parameters.isGpuRender())
					{
						GraphicsFillExtra.setColorTransform(_local_4, new ColorTransform(-1, -1, -1, 1, 0xFF, 0xFF, 0xFF, 0));
					}
					else
					{
						_local_9 = _local_4.clone();
						_local_9.colorTransform(_local_9.rect, new ColorTransform(-1, -1, -1, 1, 0xFF, 0xFF, 0xFF, 0));
						_local_9 = CachingColorTransformer.filterBitmapData(_local_9, new ColorMatrixFilter(MoreColorUtil.greyscaleFilterMatrix));
						_local_4 = _local_9;
					}
					this.isShockedTransformSet = true;
				}
				if (((this.isCharging) && (!(this.isChargingTransformSet))))
				{
					if (Parameters.isGpuRender())
					{
						GraphicsFillExtra.setColorTransform(_local_4, new ColorTransform(1, 1, 1, 1, 0xFF, 0xFF, 0xFF, 0));
					}
					else
					{
						_local_9 = _local_4.clone();
						_local_9.colorTransform(_local_9.rect, new ColorTransform(1, 1, 1, 1, 0xFF, 0xFF, 0xFF, 0));
						_local_4 = _local_9;
					}
					this.isChargingTransformSet = true;
				}
				this.bitmapFill_.bitmapData = _local_4;
				this.fillMatrix_.identity();
				this.fillMatrix_.translate(this.vS_[0], this.vS_[1]);
				this.bitmapFill_.matrix = this.fillMatrix_;
				_arg_1.push(this.bitmapFill_);
				_arg_1.push(this.path_);
				_arg_1.push(GraphicsUtil.END_FILL);
				if (((((!(this.isPaused)) && ((this.condition_[ConditionEffect.CE_FIRST_BATCH]) || (this.condition_[ConditionEffect.CE_SECOND_BATCH]))) && (!(Parameters.screenShotMode_))) && (!(this is Pet))))
				{
					this.drawConditionIcons(_arg_1, _arg_2, _arg_3);
				}

				var _local_13:String = Parameters.data_["showHighestDps"];
				if (this.map_.player_ != null && !Parameters.ssmode && _local_13 != "off")
				{
					if (this.props_.isEnemy_ && (_local_13 == "quest" && this.props_.isQuest_ || _local_13 == "all"))
					{
						if (this.calcHighestDps)
						{
							this.calcHighestDps = false;
							_local_8 = this.defense_;
							if (this.isArmorBroken)
							{
								_local_8 = 0;
							}
							if (this.isArmored)
							{
								_local_8 = (_local_8 * 2);
							}
							if (this.isExposed)
							{
								_local_8 = (_local_8 - 20);
							}
							if (this.highestDpsWeaponIcon)
							{
								this.highestDpsWeaponIcon.dispose();
								this.highestDpsWeaponIcon = null;
							}
							this.highestDpsWeaponIcon = ObjectLibrary.getItemIcon(this.map_.player_.highestDpsWeapon(_local_8, this.isPetrified, this.isCursed));
						}
						this.drawHighestDps(_arg_1, _arg_2);
					}
				}

				if ((((this.props_.showName_) && (!(this.name_ == null))) && (!(this.name_.length == 0))))
				{
					this.drawName(_arg_1, _arg_2, false);
				}
				if (_local_5)
				{
					_local_10 = int(((_local_4.getPixel32((_local_4.width / 4), (_local_4.height / 4)) | _local_4.getPixel32((_local_4.width / 2), (_local_4.height / 2))) | _local_4.getPixel32(((_local_4.width * 3) / 4), ((_local_4.height * 3) / 4))));
					_local_11 = (_local_10 >> 24);
					if (_local_11 != 0)
					{
						hasShadow_ = true;
						_local_12 = (((this.props_.isPlayer_) && (!(this == map_.player_))) ? 12 : 0);
						if (((this.bHPBarParamCheck()) && (!(this.props_.healthBar_ == -1))))
						{
							this.drawHpBar(_arg_1, ((this.props_.healthBar_) ? this.props_.healthBar_ : (_local_12 + DEFAULT_HP_BAR_Y_OFFSET)));
						}
					}
					else
					{
						hasShadow_ = false;
					}
				}
				if (!Parameters.ssmode)
				{
					if (!this.dead_ && (Parameters.data_.showDamageAndHP == "percent" || Parameters.data_.showDamageAndHP == "all"))
					{
						if (this.footer_)
						{
							_local_11 = Parameters.dmgCounter[this.objectId_];
							if (_local_11 != this.lastPercent_)
							{
								_local_11 = int(((_local_11 / this.maxHP_) * 100));
								this.name_ = (_local_11 + "%");
								this.lastPercent_ = _local_11;
								this.nameBitmapData_ = null;
								this.drawName(_arg_1, _arg_2, true);
							}
						}
						else
						{
							_local_11 = Parameters.dmgCounter[this.objectId_];
							if (!isNaN(_local_11) && _local_11 > 0)
							{
								_local_11 = int(((_local_11 / this.maxHP_) * 100));
								this.name_ = (_local_11 + "%");
								this.lastPercent_ = _local_11;
								this.drawName(_arg_1, _arg_2, true);
								this.footer_ = true;
							}
						}
					}
				}
				else
				{
					if (this.footer_)
					{
						this.nameBitmapData_ = null;
					}
				}
			}

			private function bHPBarParamCheck():Boolean
			{
				return ((Parameters.data_.HPBar) && (((((Parameters.data_.HPBar == 1) || ((Parameters.data_.HPBar == 2) && (this.props_.isEnemy_))) || ((Parameters.data_.HPBar == 3) && ((this == map_.player_) || (this.props_.isEnemy_)))) || ((Parameters.data_.HPBar == 4) && (this == map_.player_))) || ((Parameters.data_.HPBar == 5) && (this.props_.isPlayer_))));
			}

			public function drawConditionIcons(_arg_1:Vector.<IGraphicsData>, _arg_2:Camera, _arg_3:int):void
			{
				var _local_9:BitmapData;
				var _local_10:GraphicsBitmapFill;
				var _local_11:GraphicsPath;
				var _local_12:Number;
				var _local_13:Number;
				var _local_14:Matrix;
				if (!Parameters.ssmode)
				{
					if (this is Player && this != map_.player_ && Parameters.data_.alphaOnOthers && !(this as Player).starred_)
					{
						if (this.icons_)
						{
							this.icons_.length = 0;
							return;
						}
					}
				}
				var _local_4:int = int((_arg_3 / 500));
				if (this.icons_ == null)
				{
					this.icons_ = new Vector.<BitmapData>();
					this.iconFills_ = new Vector.<GraphicsBitmapFill>();
					this.iconPaths_ = new Vector.<GraphicsPath>();
					this.icons_.length = 0;
					ConditionEffect.getConditionEffectIcons(this.condition_[ConditionEffect.CE_FIRST_BATCH], this.icons_, _local_4);
					ConditionEffect.getConditionEffectIcons2(this.condition_[ConditionEffect.CE_SECOND_BATCH], this.icons_, _local_4);
				}
				else
				{
					if (this.lastCon1 != this.condition_[ConditionEffect.CE_FIRST_BATCH] || this.lastCon2 != this.condition_[ConditionEffect.CE_SECOND_BATCH])
					{
						this.lastCon1 = this.condition_[ConditionEffect.CE_FIRST_BATCH];
						this.lastCon2 = this.condition_[ConditionEffect.CE_SECOND_BATCH];
						this.icons_.length = 0;
						ConditionEffect.getConditionEffectIcons(this.condition_[ConditionEffect.CE_FIRST_BATCH], this.icons_, _local_4);
						ConditionEffect.getConditionEffectIcons2(this.condition_[ConditionEffect.CE_SECOND_BATCH], this.icons_, _local_4);
					}
				}
				var _local_5:Number = posS_[3];
				var _local_6:Number = this.vS_[1];
				var _local_7:int = this.icons_.length;
				var _local_8:int;
				while (_local_8 < _local_7)
				{
					_local_9 = this.icons_[_local_8];
					if (_local_8 >= this.iconFills_.length)
					{
						this.iconFills_.push(new GraphicsBitmapFill(null, new Matrix(), false, false));
						this.iconPaths_.push(new GraphicsPath(GraphicsUtil.QUAD_COMMANDS, new Vector.<Number>()));
					}
					_local_10 = this.iconFills_[_local_8];
					_local_11 = this.iconPaths_[_local_8];
					_local_10.bitmapData = _local_9;
					_local_12 = ((_local_5 - ((_local_9.width * _local_7) / 2)) + (_local_8 * _local_9.width));
					_local_13 = (_local_6 - (_local_9.height / 2));
					_local_11.data.length = 0;
					(_local_11.data as Vector.<Number>).push(_local_12, _local_13, (_local_12 + _local_9.width), _local_13, (_local_12 + _local_9.width), (_local_13 + _local_9.height), _local_12, (_local_13 + _local_9.height));
					_local_14 = _local_10.matrix;
					_local_14.identity();
					_local_14.translate(_local_12, _local_13);
					_arg_1.push(_local_10);
					_arg_1.push(_local_11);
					_arg_1.push(GraphicsUtil.END_FILL);
					_local_8++;
				}
			}

			public function drawHighestDps(_arg_1:Vector.<IGraphicsData>, _arg_2:Camera):void
			{
				var _local_6:BitmapData;
				var _local_9:GraphicsBitmapFill;
				var _local_3:GraphicsPath;
				var _local_7:Number;
				var _local_8:Number;
				var _local_10:Matrix;
				var _local_5:Number = this.posS_[3];
				var _local_4:Number = this.vS_[1];
				_local_6 = this.highestDpsWeaponIcon;
				_local_9 = new GraphicsBitmapFill(null, new Matrix(), false, false);
				_local_3 = new GraphicsPath(GraphicsUtil.QUAD_COMMANDS, new Vector.<Number>());
				_local_9.bitmapData = _local_6;
				_local_7 = (_local_5 - (_local_6.width / 2));
				_local_8 = ((_local_4 - _local_6.height) - (_local_6.height / 2));
				_local_3.data.length = 0;
				(_local_3.data as Vector.<Number>).push(_local_7, _local_8, (_local_7 + _local_6.width), _local_8, (_local_7 + _local_6.width), (_local_8 + _local_6.height), _local_7, (_local_8 + _local_6.height));
				_local_10 = _local_9.matrix;
				_local_10.identity();
				_local_10.translate(_local_7, _local_8);
				_arg_1.push(_local_9);
				_arg_1.push(_local_3);
				_arg_1.push(GraphicsUtil.END_FILL);
			}

			override public function drawShadow(_arg_1:Vector.<IGraphicsData>, _arg_2:Camera, _arg_3:int):void
			{
				if (!Parameters.ssmode && Parameters.lowCPUMode)
				{
					return;
				}
				if (this.shadowGradientFill_ == null)
				{
					this.shadowGradientFill_ = new GraphicsGradientFill(GradientType.RADIAL, [this.props_.shadowColor_, this.props_.shadowColor_], [0.5, 0], null, new Matrix());
					this.shadowPath_ = new GraphicsPath(GraphicsUtil.QUAD_COMMANDS, new Vector.<Number>());
				}
				var _local_4:Number = (((this.size_ / 100) * (this.props_.shadowSize_ / 100)) * this.sizeMult_);
				var _local_5:Number = (30 * _local_4);
				var _local_6:Number = (15 * _local_4);
				this.shadowGradientFill_.matrix.createGradientBox((_local_5 * 2), (_local_6 * 2), 0, (posS_[0] - _local_5), (posS_[1] - _local_6));
				_arg_1.push(this.shadowGradientFill_);
				this.shadowPath_.data.length = 0;
				(this.shadowPath_.data as Vector.<Number>).push((posS_[0] - _local_5), (posS_[1] - _local_6), (posS_[0] + _local_5), (posS_[1] - _local_6), (posS_[0] + _local_5), (posS_[1] + _local_6), (posS_[0] - _local_5), (posS_[1] + _local_6));
				_arg_1.push(this.shadowPath_);
				_arg_1.push(GraphicsUtil.END_FILL);
			}

			public function clearTextureCache():void
			{
				var _local_3:Object;
				var _local_1:BitmapData;
				var _local_2:Dictionary;
				var _local_4:Object;
				var _local_5:BitmapData;
				if (this.texturingCache_ != null)
				{
					for each (_local_3 in this.texturingCache_)
					{
						_local_1 = (_local_3 as BitmapData);
						if (_local_1 != null)
						{
							_local_1.dispose();
						}
						else
						{
							_local_2 = (_local_3 as Dictionary);
							for each (_local_4 in _local_2)
							{
								_local_5 = (_local_4 as BitmapData);
								if (_local_5 != null)
								{
									_local_5.dispose();
								}
							}
						}
					}
				}
				this.texturingCache_ = new Dictionary();
			}

			public function setSize(_arg_1:int):void
			{
				if (_arg_1 == this.size_)
				{
					return;
				}
				this.size_ = _arg_1;
				this.texturingCache_ = new Dictionary();
				this.portrait_ = null;
			}

			public function toString():String
			{
				return (((((((((("[" + getQualifiedClassName(this)) + " id: ") + objectId_) + " type: ") + ObjectLibrary.typeToDisplayId_[this.objectType_]) + " pos: ") + x_) + ", ") + y_) + "]");
			}


		}
	}//package com.company.assembleegameclient.objects

