extends Node

@onready var music = $Music
@onready var sounds = $Sounds

const TRACK_01 = preload("res://assets/music/8-bit-arcade-138828.mp3")
const TRACK_02 = preload("res://assets/music/bit-beats-1-168243.mp3")
const TRACK_03 = preload("res://assets/music/byte-blast-8-bit-arcade-music-background-music-for-video-208780.mp3")
const TRACK_04 = preload("res://assets/music/flat-8-bit-gaming-music-instrumental-211547.mp3")
const TRACK_05 = preload("res://assets/music/pixel-fight-8-bit-arcade-music-background-music-for-video-28-second-208770.mp3")

const TRANSITION = preload("res://assets/sound/transition.wav")

func play_sound(sound):
	sounds.stream = sound
	sounds.play()

func play_music(track):
	music.stream = track
	music.play()

func music_stop():
	music.stop()

func _on_music_finished():
	music.play()
