-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
local meter = require "com.meter"
-- Your code here
local composer = require "composer"
meter.create_fps()
meter.create_mem()
--chuyển đến màn hình intro
composer.gotoScene("Scripts.Intro")
--ẩn thanh trạng thái
display.setStatusBar(display.HiddenStatusBar)
