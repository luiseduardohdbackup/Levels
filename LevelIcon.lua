--------------------------------------------------------------------------------------------------
-- Class    : Level Icon
-- Author   : Peter Dwyer
-- Created  : ${date}
-- 
-- The icon displayed for a level on the level select screen. 
-- Each individual part of the icon is a sprite and so can be individually 
-- animated
------------------------------------------------------------------------------------------------- 
local class = {}

-- Import all necessary requires.
local json = require("json")
local analytics = require("analytics")

-- Forward Declarations
local layout = nil

-- local vars
local icon = nil
local lockData = nil
local iconData = nil
local starData = nil
local iconSpriteSheet = nil
local starSpriteSheet = nil
local lockSpriteSheet = nil
local star1Sprite = nil
local star2Sprite = nil
local star3Sprite = nil
local lockSprite = nil
local iconSprite = nil
 

------------------------------------------------------------------------------------
-- New
-- 
-- Create a new instance of this class
------------------------------------------------------------------------------------
--@Param: _p inheritance using metatables
--@Param: argTable table of any additional arguments we want to pass to this class. 
--@Returns: new instance.
------------------------------------------------------------------------------------
function class:new( _p, argTable )
    _p = _p or {}
    setmetatable( _p, self )
    
    self.__index = self

    -- Initialise the level status
    self.star1 = argTable.star1
    self.star2 = argTable.star2
    self.star3 = argTable.star3
    
    self.score = argTable.score
    self.locked = argTable.lockStatus
    
    data = system.pathForFile( "config.json", system.ResourceDirectory )
        
    local fileHandle = io.open("config.json", "r")
    local  configData = fileHandle:read("*a")
    io.close( fileHandle )
        
    self.configData = json.decode( data )
    
    return _p
end 

------------------------------------------------------------------------------------
-- Draw
-- 
-- Display the icon using the inital settings to determine how to draw each element 
------------------------------------------------------------------------------------
--@Param: _p inheritance using metatables
--@Param: argTable table of any additional arguments we want to pass to this class. 
--@Returns: new instance.
------------------------------------------------------------------------------------
function class:Draw()
    iconData = require( "IconData" )
    starData = require( "StarData" )
    lockData = require( "LockData" )
    
    iconSpriteSheet = graphics.newImageSheet("IconSprite.png", "LevelManager", iconData.getSheet())
    starSpriteSheet = graphics.newImageSheet("StarSprite.png", "LevelManager", starData.getSheet())
    lockSpriteSheet = graphics.newImageSheet("LockSprite.png", "LevelManager", lockData.getSheet())
    
    icon = display.newGroup( )
    icon:insert( iconSprite )
    
    -- Set the stars to on or off depending on the level status
    iconSprite = display.newSprite( iconSpriteSheet, starData.sequenceData() )
    star1Sprite = display.newSprite( starSpriteSheet, starData.sequenceData() )
    star2Sprite = display.newSprite( starSpriteSheet, starData.sequenceData() )
    star3Sprite = display.newSprite( starSpriteSheet, starData.sequenceData() )
    
    star1Sprite:setSequence(self.star1)
    star1Sprite:play()
    
    star2Sprite:setSequence(self.star1)
    star2Sprite:play()
    
    star3Sprite:setSequence(self.star1)
    star3Sprite:play()
   
    icon:insert( star1Sprite )
    icon:insert( star2Sprite )
    icon:insert( star3Sprite )
    
    -- If this level is locked then display the lock icon
    if self.locked then
        lockSprite =  display.newSprite( lockSpriteSheet, starData.sequenceData() )
        lockSprite:setSequence("locked")
        lockSprite:play()
        
        icon:insert( lockSprite )
    end
    
    layout( self )
end

------------------------------------------------------------------------------------
-- layout
-- 
-- Layout the icon based on the information in the icon configuration file. The 
-- file contains infomration about the following 
-- relative (x,y) position of star
-- relative (x,y) position of the lock  
------------------------------------------------------------------------------------
--@Param: _p inheritance using metatables
--@Param: argTable table of any additional arguments we want to pass to this class. 
--@Returns: new instance.
------------------------------------------------------------------------------------
layout = function( levelIcon )
    -- position the stars within the icon
    star1Sprite.x = levelIcon.configData.star1.x
    star1Sprite.y = levelIcon.configData.star1.y
    star2Sprite.x = levelIcon.configData.star2.x
    star2Sprite.y = levelIcon.configData.star2.y
    star3Sprite.x = levelIcon.configData.star3.x
    star3Sprite.y = levelIcon.configData.star3.y
    
    -- If the icon is locked then position the lock image
    if levelIcon.locked and lockSprite ~= nil then
        lockSprite.x = levelIcon.configData.lock.x
        lockSprite.y = levelIcon.configData.lock.y      
    end
end

return class