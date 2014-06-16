-- Import all necessary requires.


-- Forward Declarations


-- local vars
local lockData = nil
local iconData = nil
local starData = nil
local iconSpriteSheet = nil
local starSpriteSheet = nil
local lockSpriteSheet = nil
 
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
    
    icon = display.newGroup()
    icon:insert( iconSprite )
    
    -- If this level is locked then display the lock icon
    if locked then
        icon:insert( lockSprite )
    end
    
    icon:insert( star1Sprite )
    icon:insert( star2Sprite )
    icon:insert( star3Sprite )
end
