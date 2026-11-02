extends Node3D

var isopen = false

func toggle():
	if not isopen:
		print("open")
	elif isopen:
		print("closed")
	isopen = not isopen
