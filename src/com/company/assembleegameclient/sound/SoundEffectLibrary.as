﻿//com.company.assembleegameclient.sound.SoundEffectLibrary

package com.company.assembleegameclient.sound
{
	import com.company.assembleegameclient.parameters.Parameters;

	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;

	import kabam.rotmg.application.api.ApplicationSetup;
	import kabam.rotmg.core.StaticInjectorContext;

	import zfn.sound.SoundAssets;
	import zfn.sound.SoundCustom;

	public class SoundEffectLibrary
	{
		private static var urlBase:String;
		private static const URL_PATTERN:String = "{URLBASE}/sfx/{NAME}.mp3";
		public static var nameMap_:Dictionary = new Dictionary();
		private static var activeSfxList_:Dictionary = new Dictionary(true);
		private static var activeCustomSfxList_:Dictionary = new Dictionary(true);

		public static function load(_arg_1:String):Sound
		{
			return (nameMap_[_arg_1] = ((nameMap_[_arg_1]) || (makeSound(_arg_1))));
		}

		public static function makeSound(_arg_1:String):Sound
		{
			return (SoundAssets.grab(_arg_1));
		}

		public static function playCustomSFX(_arg_1:String, _arg_2:Number = 1):void
		{
			var _local_7:Number;
			var _local_5:Sound = SoundCustom.grab(_arg_1);
			if (!_local_5)
			{
				return;
			}
			var _local_3:Number = (Parameters.data_.customVolume * _arg_2);
			_local_7 = ((Parameters.data_.customSounds) ? _local_3 : 0);
			if (isNaN(_local_7))
			{
				return;
			}
			var _local_8:SoundTransform = new SoundTransform(_local_7);
			var _local_6:SoundChannel = _local_5.play(0, 0, _local_8);
			if (_local_6 == null)
			{
				return;
			}
			_local_6.addEventListener(Event.SOUND_COMPLETE, onCustomSoundComplete, false, 0, true);
			activeCustomSfxList_[_local_6] = _local_3;
		}

		public static function play(name:String, volumeMultiplier:Number = 1, isFX:Boolean = true):void
		{
			var actualVolume:Number;
			var trans:SoundTransform;
			var channel:SoundChannel;
			var sound:Sound = load(name);
			if (!sound)
			{
				sound = SoundCustom.grab(name);
			}
			var volume:Number = (Parameters.data_.SFXVolume * volumeMultiplier);
			try
			{
				actualVolume = ((((Parameters.data_.playSFX) && (isFX)) || ((!(isFX)) && (Parameters.data_.playPewPew))) ? volume : 0);
				trans = new SoundTransform(actualVolume);
				channel = sound.play(0, 0, trans);
				channel.addEventListener(Event.SOUND_COMPLETE, onSoundComplete, false, 0, true);
				activeSfxList_[channel] = volume;
			}
			catch (error:Error)
			{
			}
		}

		public static function playCustom(_arg_1:Sound, _arg_2:String, _arg_3:Boolean):void
		{
			var volume:Number = Parameters.data_.SFXVolume;
			var _local_6:SoundTransform = new SoundTransform(volume);
			var channel:SoundChannel = _arg_1.play(0, 0, _local_6);
			channel.addEventListener(Event.SOUND_COMPLETE, onSoundComplete, false, 0, true);
			activeSfxList_[channel] = volume;
		}

		private static function onSoundComplete(_arg_1:Event):void
		{
			var _local_2:SoundChannel = (_arg_1.target as SoundChannel);
			delete activeSfxList_[_local_2];
		}

		private static function onCustomSoundComplete(_arg_1:Event):void
		{
			var _local_2:SoundChannel = (_arg_1.target as SoundChannel);
			delete activeCustomSfxList_[_local_2];
		}

		public static function updateVolume(_arg_1:Number):void
		{
			var _local_2:SoundChannel;
			var _local_3:SoundTransform;
			for each (_local_2 in activeSfxList_)
			{
				activeSfxList_[_local_2] = _arg_1;
				_local_3 = _local_2.soundTransform;
				_local_3.volume = ((Parameters.data_.playSFX) ? activeSfxList_[_local_2] : 0);
				_local_2.soundTransform = _local_3;
			}
		}

		public static function updateTransform():void
		{
			var _local_1:SoundChannel;
			var _local_2:SoundTransform;
			for each (_local_1 in activeSfxList_)
			{
				_local_2 = _local_1.soundTransform;
				_local_2.volume = ((Parameters.data_.playSFX) ? activeSfxList_[_local_1] : 0);
				_local_1.soundTransform = _local_2;
			}
		}

		public static function updateCustomVolume(_arg_1:Number):void
		{
			var _local_3:SoundChannel;
			var _local_2:SoundTransform;
			for each (_local_3 in activeCustomSfxList_)
			{
				activeCustomSfxList_[_local_3] = _arg_1;
				_local_2 = _local_3.soundTransform;
				_local_2.volume = ((Parameters.data_.customSounds) ? activeCustomSfxList_[_local_3] : 0);
				_local_3.soundTransform = _local_2;
			}
		}

		public static function updateCustomTransform():void
		{
			var _local_2:SoundChannel;
			var _local_1:SoundTransform;
			for each (_local_2 in activeCustomSfxList_)
			{
				_local_1 = _local_2.soundTransform;
				_local_1.volume = ((Parameters.data_.customSounds) ? activeCustomSfxList_[_local_2] : 0);
				_local_2.soundTransform = _local_1;
			}
		}

		public static function onIOError(_arg_1:IOErrorEvent):void
		{
		}

	}
}//package com.company.assembleegameclient.sound

